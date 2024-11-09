unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, ES.Labels,
  System.Hash, System.IOUtils;

type
  TfrmMain = class(TForm)
    btnPlayGame: TButton;
    btnExit: TButton;
    btnSettings: TButton;
    EsLinkLabel1: TEsLinkLabel;
    EsLinkLabel2: TEsLinkLabel;
    edtCommandline: TEdit;

    // new procedures
    procedure VerifyResources();
    procedure ExtractResources();
    procedure GetCommandLineParams();
    procedure LaunchGame();


    procedure btnSettingsClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnPlayGameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    var GameIniFile: string;
    var UserIniFile: string;
    var AppExeName: string;
    var GameExeFile: string;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
{$R Launchbag_Extra.res}


uses uFrmSettings;


procedure TfrmMain.VerifyResources();
begin
    var AppDirectory := ExtractFilePath(Application.ExeName);
    AppExeName := ExtractFileName(Application.ExeName);
    AppExeName := ChangeFileExt(AppExeName, '');


    if TFile.Exists(AppDirectory + 'Engine.dll') = false then
    begin
        MessageBox(Handle, 'Engine.dll not found!', 'Error', MB_OK + MB_ICONSTOP + MB_TOPMOST);
        Application.Terminate();
    end;

    if TFile.Exists(AppDirectory + 'Core.dll') = false then
    begin
        MessageBox(Handle, 'Core.dll not found!', 'Error', MB_OK + MB_ICONSTOP + MB_TOPMOST);
        Application.Terminate();
    end;

    if TFile.Exists(AppDirectory + 'Windrv.dll') = false then
    begin
        MessageBox(Handle, 'Windrv.dll not found!', 'Error', MB_OK + MB_ICONSTOP + MB_TOPMOST);
        Application.Terminate();
    end;

    if TFile.Exists(AppDirectory + 'Window.dll') = false then
    begin
        MessageBox(Handle, 'Window.dll not found!', 'Error', MB_OK + MB_ICONSTOP + MB_TOPMOST);
        Application.Terminate();
    end;
end;

procedure TfrmMain.ExtractResources();
var
    ResStream: TResourceStream;
    FileStream: TFileStream;
begin
    GameExeFile := ExtractFilePath(Application.ExeName) + 'DeusEx.bin';

    ResStream := TResourceStream.Create(HInstance, 'DEUSEX.BIN','LAUNCHBAG');
    try
        FileStream := TFileStream.Create(GameExeFile, fmCreate);
        try
            FileStream.CopyFrom(ResStream, 0);
        finally
            FileStream.Free();
        end;

    finally
        ResStream.Free();
    end;
end;

procedure TfrmMain.GetCommandLineParams();
begin
    Caption := ExtractFileName(Application.ExeName);

    var cmdLineParameters: string;
    for var i:= 1 to ParamCount do
        cmdLineParameters := cmdLineParameters + ParamStr(i);
    edtCommandline.Text := cmdLineParameters;
end;

procedure TfrmMain.LaunchGame();
var
    StartupInfo: TStartupInfo;
    ProcessInfo: TProcessInformation;
    RunningFile: string;
begin
    RunningFile := 'Running.ini';

    if TFile.Exists(RunningFile) then
        TFile.Delete(RunningFile);

    ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
    StartupInfo.cb := SizeOf(StartupInfo);
    ZeroMemory(@ProcessInfo, SizeOf(ProcessInfo));

    var parameters := frmSettings.mmoCommandline.Text;

    if CreateProcess(
        PChar(GameExeFile), PChar(parameters),nil, nil, False,
        CREATE_NEW_PROCESS_GROUP, nil, nil, StartupInfo,
        ProcessInfo)
    then
    begin
        if frmSettings.chkSingleCPUCore.Checked = True then
            SetProcessAffinityMask(ProcessInfo.hProcess, 1);

        CloseHandle(ProcessInfo.hThread);
        CloseHandle(ProcessInfo.hProcess);
    end
    else
    begin
        //MessageBox(Handle, PChar('CreateProcess() failed!'), PChar('ERROR!'), MB_OK + MB_ICONSTOP + MB_TOPMOST);
        RaiseLastOSError();
    end;

    Application.Terminate();
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
    Application.Terminate();
end;

procedure TfrmMain.btnPlayGameClick(Sender: TObject);
begin
    frmSettings.SaveGameSettings();
    ExtractResources();
    LaunchGame();
end;

procedure TfrmMain.btnSettingsClick(Sender: TObject);
begin
    frmSettings.ShowModal();
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    VerifyResources();
    GetCommandLineParams();
end;

end.
