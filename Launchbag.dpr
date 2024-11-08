{
    I don't know how to call it. Deus Exe V2? Launchbag?
}

program Launchbag;

uses
  Vcl.Forms,
  uFrmMain in 'uFrmMain.pas' {frmMain},
  uFrmSettings in 'uFrmSettings.pas' {frmSettings},
  Launchbag.Classes in 'Launchbag.Classes.pas',
  Launchbag.Consts in 'Launchbag.Consts.pas',
  Launchbag.Utils in 'Launchbag.Utils.pas';

{$R *.res}

begin
  Application.Initialize();
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.Run();

  ReportMemoryLeaksOnShutdown := True;
end.
