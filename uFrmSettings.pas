unit uFrmSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Generics.Collections, System.Generics.Defaults, Launchbag.Consts, System.IniFiles, system.IOUtils, Vcl.Samples.Spin;

type
  TfrmSettings = class(TForm)
    chkRunInWindow: TCheckBox;
    chkBorderlessWindow: TCheckBox;
    chkSingleCPUCore: TCheckBox;
    chkAutomaticFOV: TCheckBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    cmbScreenRes: TComboBox;
    cmbRenderDevice: TComboBox;
    cmbGameUIScale: TComboBox;
    Label1: TLabel;
    btnClose: TButton;
    edtResX: TEdit;
    edtResY: TEdit;
    lblResX: TLabel;
    grpCommandLineParams: TGroupBox;
    mmoCommandline: TMemo;
    GroupBox3: TGroupBox;
    se_FPSLimit: TSpinEdit;
    Label2: TLabel;

    // New procedures
    procedure ToggleCustomResolutionControls(bShow: Boolean);
    procedure FillScreenResolutions();
    procedure SaveGameSettings();
    procedure LoadGameSettings();

    procedure FormCreate(Sender: TObject);
    procedure cmbScreenResChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cmbRenderDeviceChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

uses uFrmMain;

procedure TfrmSettings.ToggleCustomResolutionControls(bShow: Boolean);
begin
    lblResX.Visible := bShow;
    edtResY.Visible := bShow;
    edtResX.Visible := bShow;
end;

procedure TfrmSettings.FillScreenResolutions();
var
    DevMode: TDeviceMode;
    i: Integer;
    Resolutions: TList<string>;
begin
    Resolutions := TList<string>.Create();

    try
        cmbScreenRes.Items.Add(strResolutionCustomLabel);

        i := 0;
        while EnumDisplaySettings(nil, i, DevMode) do
        begin
            // �������� ������ ��� ����������
            var resolution := Format('%dx%d', [DevMode.dmPelsWidth, DevMode.dmPelsHeight]);

            // ���������� ���������� � ������, ���� ��� ��� �� ���������
            if Resolutions.IndexOf(resolution) = -1 then
                Resolutions.Add(resolution);

            Inc(i);
        end;

        // �� ��� ������ ��� ���� ����� ����������� ������ ��� ��� ������ ��������
        Resolutions.Sort(TComparer<string>.Construct(
        function(const Left, Right: string): Integer
        var
            LeftWidth, LeftHeight, RightWidth, RightHeight: Integer;
        begin
            // ������� ������ � ������ �� ������
            LeftWidth := StrToIntDef(Left.Split(['x'])[0], 0);
            LeftHeight := StrToIntDef(Left.Split(['x'])[1], 0);
            RightWidth := StrToIntDef(Right.Split(['x'])[0], 0);
            RightHeight := StrToIntDef(Right.Split(['x'])[1], 0);

            // ��������� ������
            if LeftWidth < RightWidth then
                Result := -1
            else if LeftWidth > RightWidth then
                Result := 1
            else
                // ���� ������ �����, ��������� ������
                if LeftHeight < RightHeight then
                    Result := -1
                else if LeftHeight > RightHeight then
                    Result := 1
                else
                    Result := 0;
        end));

        // ���������� ��������������� ���������� � ��������������� ������
        for var item in Resolutions do
            cmbScreenRes.Items.Add(item);

    finally
        Resolutions.Free();
    end;
end;

procedure TfrmSettings.SaveGameSettings();
begin
//
end;

procedure TfrmSettings.LoadGameSettings();
begin
    var GameIniToCheck: string;

    if (SameText(frmMain.AppExeName, 'DeusEx') = True) or (SameText(frmMain.AppExeName, 'Launchbag') = True) then
        GameIniToCheck := 'DeusEx.ini'
    else
        GameIniToCheck := frmMain.AppExeName + '.ini';

    if TFile.Exists(GameIniToCheck) = False then
    begin
        MessageBox(Handle, PChar('File not found: ' + GameIniToCheck), 'Error', MB_OK + MB_ICONSTOP + MB_TOPMOST);
        Application.Terminate();
    end;



    var UserIniToCheck: string;

    if (SameText(frmMain.AppExeName, 'DeusEx') = True) or (SameText(frmMain.AppExeName, 'Launchbag') = True) then
        UserIniToCheck := 'User.ini'
    else
        UserIniToCheck := frmMain.AppExeName + USER_INI;

    if TFile.Exists(UserIniToCheck) = False then
    begin
        MessageBox(Handle, PChar('File not found: ' + UserIniToCheck + USER_INI), 'Error', MB_OK + MB_ICONSTOP + MB_TOPMOST);
        Application.Terminate();
    end;


    var GameIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + GameIniToCheck);

    try
        // screen resolution
        var ResX := GameIni.ReadInteger('WinDrv.WindowsClient', 'FullscreenViewportX', DEFAULT_RES_X);
        var ResY := GameIni.ReadInteger('WinDrv.WindowsClient', 'FullscreenViewportY', DEFAULT_RES_Y);
        var ResStr := IntToStr(ResX) + 'x' + IntToStr(ResY);

        var bFound := False;
        for var i := 0 to cmbScreenRes.Items.Count - 1 do
        begin
            if cmbScreenRes.Items[i] = ResStr then
            begin
                cmbScreenRes.ItemIndex := i;
                bFound := True;
                Break;
            end;
        end;

        if bFound=False then
        begin
            cmbScreenRes.ItemIndex := 0;
            edtResX.Text := IntToStr(ResX);
            edtResY.Text := IntToStr(ResY);
        end;

        cmbScreenResChange(self);

        // rendering device
        var RenDev := GameIni.ReadString('Engine.Engine', 'GameRenderDevice', 'OpenGlDrv.OpenGlRenderDevice');

        for var i := 0 to cmbRenderDevice.Items.Count - 1 do
        begin
            if LowerCase(cmbRenderDevice.Items.ValueFromIndex[i]) = LowerCase(RenDev) then
            begin
                cmbRenderDevice.ItemIndex := i;
                Break;
            end
        end;
        cmbRenderDeviceChange(self);

        // Game interface scale
        var GameInterfaceScale := GameIni.ReadInteger(frmMain.AppExeName + 'Launcher', 'UIScale', 1);
        case GameInterfaceScale of
            1: cmbGameUIScale.ItemIndex := 0;
            2: cmbGameUIScale.ItemIndex := 1;
            3: cmbGameUIScale.ItemIndex := 2;
            4: cmbGameUIScale.ItemIndex := 3;
        end;

        // windowed mode/full screen
        var bRunInWindow := GameIni.ReadString('WinDrv.WindowsClient','StartupFullscreen', 'True');

        if UpperCase(bRunInWindow) = 'TRUE' then
            chkRunInWindow.Checked := False
        else if UpperCase(bRunInWindow) = 'FALSE' then
            chkRunInWindow.Checked := True;


        // BorderlessWindowed
        var bBorderlessWindowed := GameIni.ReadString(frmMain.AppExeName + 'Launcher', 'UIScale', 'False');

        if UpperCase(bBorderlessWindowed) = 'TRUE' then
            chkBorderlessWindow.Checked := False
        else if UpperCase(bBorderlessWindowed) = 'FALSE' then
            chkBorderlessWindow.Checked := True;


        // Single core or default
        var bRunOnSingleCPUCore := GameIni.ReadBool(frmMain.AppExeName + 'Launcher', 'chkSingleCore.Checked', False);
        case bRunOnSingleCPUCore of
            True:  chkSingleCPUCore.Checked := True;
            False: chkSingleCPUCore.Checked := False;
        end;

        // Auto FOV (like in 2027 mod)
        var bAutomaticFOV := GameIni.ReadBool(frmMain.AppExeName + 'Launcher', 'chkAutomaticFOV.Checked', False);
        case bAutomaticFOV of
            True:  chkAutomaticFOV.Checked := True;
            False: chkAutomaticFOV.Checked := False;
        end;

        // FPS limit
        var FPSLimit := GameIni.ReadInteger(frmMain.AppExeName + 'Launcher', 'FPSCap', 120);
        se_FPSLimit.Value := FPSLimit;

    finally
        GameIni.Free();
    end;
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
    grpCommandLineParams.Caption := Format(strGrpCommandLineTitle, [frmMain.Caption]);
    mmoCommandline.Text := frmMain.edtCommandline.Text;

    FillScreenResolutions();
    LoadGameSettings();
end;

procedure TfrmSettings.btnCloseClick(Sender: TObject);
begin
    Close();
end;

procedure TfrmSettings.cmbRenderDeviceChange(Sender: TObject);
begin
//
end;

procedure TfrmSettings.cmbScreenResChange(Sender: TObject);
begin
    if cmbScreenRes.Items.Count > 0 then
        ToggleCustomResolutionControls(cmbScreenRes.ItemIndex < 1);
end;

end.
