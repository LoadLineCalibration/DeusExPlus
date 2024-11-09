object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Settings'
  ClientHeight = 402
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 140
    Width = 239
    Height = 113
    Caption = 'Options'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object chkAutomaticFOV: TCheckBox
      Left = 13
      Top = 86
      Width = 200
      Height = 20
      Caption = 'Automatic FOV'
      TabOrder = 0
    end
    object chkBorderlessWindow: TCheckBox
      Left = 13
      Top = 43
      Width = 200
      Height = 20
      Caption = 'Borderless window'
      TabOrder = 1
    end
    object chkRunInWindow: TCheckBox
      Left = 13
      Top = 21
      Width = 200
      Height = 20
      Caption = 'Run in window'
      TabOrder = 2
    end
    object chkSingleCPUCore: TCheckBox
      Left = 13
      Top = 65
      Width = 200
      Height = 20
      Caption = 'Run on single CPU core'
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 2
    Width = 486
    Height = 137
    Caption = 'Graphics'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 19
      Width = 136
      Height = 113
      Align = alLeft
      Alignment = taRightJustify
      Caption = 
        'Screen resolution:'#13#10#13#10#13#10'Rendering device:'#13#10#13#10#13#10'Game interface sc' +
        'ale:'
      ExplicitHeight = 98
    end
    object lblResX: TLabel
      Left = 381
      Top = 15
      Width = 25
      Height = 22
      Alignment = taCenter
      AutoSize = False
      Caption = 'x'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object cmbScreenRes: TComboBox
      Left = 156
      Top = 16
      Width = 145
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 0
      OnChange = cmbScreenResChange
    end
    object cmbRenderDevice: TComboBox
      Left = 156
      Top = 57
      Width = 225
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 1
      OnChange = cmbRenderDeviceChange
      OnDrawItem = cmbRenderDeviceDrawItem
    end
    object cmbGameUIScale: TComboBox
      Left = 156
      Top = 98
      Width = 225
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 2
      Items.Strings = (
        'x1'
        'x2'
        'x3'
        'x4')
    end
    object edtResX: TEdit
      Left = 311
      Top = 16
      Width = 70
      Height = 22
      HideSelection = False
      NumbersOnly = True
      TabOrder = 3
    end
    object edtResY: TEdit
      Left = 408
      Top = 16
      Width = 70
      Height = 22
      HideSelection = False
      NumbersOnly = True
      TabOrder = 4
    end
  end
  object btnClose: TButton
    Left = 400
    Top = 368
    Width = 94
    Height = 26
    Cancel = True
    Caption = 'Close'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object grpCommandLineParams: TGroupBox
    Left = 8
    Top = 259
    Width = 486
    Height = 98
    Caption = '%s command  line parameters'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object mmoCommandline: TMemo
      Left = 13
      Top = 36
      Width = 460
      Height = 53
      Lines.Strings = (
        'mmoCommandline')
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 255
    Top = 140
    Width = 239
    Height = 113
    Caption = 'Extra Options'
    DefaultHeaderFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -12
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label2: TLabel
      Left = 12
      Top = 16
      Width = 81
      Height = 23
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'FPS limit:'
      Layout = tlCenter
    end
    object se_FPSLimit: TSpinEdit
      Left = 99
      Top = 16
      Width = 82
      Height = 23
      MaxValue = 500
      MinValue = 25
      TabOrder = 0
      Value = 25
    end
  end
end
