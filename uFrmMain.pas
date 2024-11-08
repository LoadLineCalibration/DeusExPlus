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
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


uses uFrmSettings;


procedure TfrmMain.VerifyResources();
begin
    var AppDirectory := ExtractFilePath(Application.ExeName);
    AppExeName := ExtractFileName(Application.ExeName);
    AppExeName := ChangeFileExt(AppExeName, '');

//    ShowMessage(AppExeName);

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
begin
//
end;

procedure TfrmMain.GetCommandLineParams();
begin
    Caption := ExtractFileName(Application.ExeName);

    var cmdLineParameters: string;
    for var i:= 1 to ParamCount do
        cmdLineParameters := cmdLineParameters + ParamStr(i);
    edtCommandline.Text := cmdLineParameters;
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
    Application.Terminate();
end;

procedure TfrmMain.btnPlayGameClick(Sender: TObject);
begin
    frmSettings.SaveGameSettings();
    ExtractResources();
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
