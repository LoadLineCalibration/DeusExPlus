object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'App title'
  ClientHeight = 268
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object EsLinkLabel1: TEsLinkLabel
    Left = 8
    Top = 244
    Width = 205
    Height = 15
    Caption = 'Uses Markie'#39's Unreal Engine 1 launcher'
    Url = 'https://github.com/TheMarkie/Unreal-Engine-1-Launcher'
    LinkStyle = Mixed
  end
  object EsLinkLabel2: TEsLinkLabel
    Left = 8
    Top = 223
    Width = 150
    Height = 15
    Caption = 'Uses FreeEsVCLComponents'
    Url = 'https://github.com/errorcalc/FreeEsVclComponents'
    LinkStyle = Mixed
  end
  object btnPlayGame: TButton
    Left = 46
    Top = 32
    Width = 200
    Height = 41
    Caption = 'Play'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnPlayGameClick
  end
  object btnExit: TButton
    Left = 46
    Top = 150
    Width = 200
    Height = 41
    Hint = 'La la la...'
    Cancel = True
    Caption = 'Exit'
    TabOrder = 1
    OnClick = btnExitClick
  end
  object btnSettings: TButton
    Left = 46
    Top = 87
    Width = 200
    Height = 41
    Caption = 'Settings'
    TabOrder = 2
    OnClick = btnSettingsClick
  end
  object edtCommandline: TEdit
    Left = 4
    Top = 8
    Width = 289
    Height = 23
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 3
    Visible = False
  end
end
