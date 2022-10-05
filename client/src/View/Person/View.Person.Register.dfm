object frmPersonRegister: TfrmPersonRegister
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 344
  ClientWidth = 478
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 478
    Height = 70
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTop'
    Color = clSilver
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 20
      Top = 3
      Width = 154
      Height = 64
      Margins.Left = 20
      Align = alLeft
      Caption = 'Cadastro de Pessoas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 18
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 298
    Width = 478
    Height = 46
    Margins.Top = 10
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlTop'
    Color = clSilver
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      478
      46)
    object ShapeCancel: TShape
      Left = 188
      Top = 7
      Width = 129
      Height = 33
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Brush.Color = clMaroon
      Shape = stRoundRect
      ExplicitLeft = 331
    end
    object ShapeSave: TShape
      Left = 342
      Top = 6
      Width = 129
      Height = 33
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Brush.Color = clTeal
      Shape = stRoundRect
      ExplicitLeft = 485
    end
    object btnSave: TSpeedButton
      Left = 342
      Top = 6
      Width = 129
      Height = 33
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = 'Salvar'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = btnSaveClick
      ExplicitLeft = 485
    end
    object btnCancel: TSpeedButton
      Left = 188
      Top = 7
      Width = 129
      Height = 33
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = btnCancelClick
      ExplicitLeft = 331
    end
  end
  object PnlContent: TPanel
    Left = 0
    Top = 70
    Width = 478
    Height = 228
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 21
      Width = 44
      Height = 13
      Caption = 'Natureza'
    end
    object Label3: TLabel
      Left = 152
      Top = 21
      Width = 54
      Height = 13
      Caption = 'Documento'
    end
    object Label4: TLabel
      Left = 8
      Top = 80
      Width = 68
      Height = 13
      Caption = 'Primeiro Nome'
    end
    object Label5: TLabel
      Left = 8
      Top = 138
      Width = 72
      Height = 13
      Caption = 'Segundo Nome'
    end
    object Label6: TLabel
      Left = 352
      Top = 21
      Width = 19
      Height = 13
      Caption = 'Cep'
    end
    object edNature: TDBEdit
      Left = 8
      Top = 40
      Width = 121
      Height = 21
      DataField = 'Nature'
      DataSource = dsResigter
      TabOrder = 0
    end
    object edDocument: TDBEdit
      Left = 152
      Top = 40
      Width = 182
      Height = 21
      DataField = 'Document'
      DataSource = dsResigter
      TabOrder = 1
    end
    object edFirstName: TDBEdit
      Left = 8
      Top = 99
      Width = 457
      Height = 21
      DataField = 'FirstName'
      DataSource = dsResigter
      TabOrder = 3
    end
    object edLastName: TDBEdit
      Left = 8
      Top = 157
      Width = 457
      Height = 21
      DataField = 'LastName'
      DataSource = dsResigter
      TabOrder = 4
    end
    object edCep: TDBEdit
      Left = 352
      Top = 40
      Width = 113
      Height = 21
      DataField = 'Cep'
      DataSource = dsResigter
      TabOrder = 2
    end
  end
  object CdsResgister: TClientDataSet
    PersistDataPacket.Data = {
      A40000009619E0BD010000001800000006000000000003000000A40002496408
      00010000000000064E6174757265040001000000000008446F63756D656E7401
      0049000000010005574944544802000200140003436570010049000000010005
      5749445448020002000F000946697273744E616D650100490000000100055749
      445448020002003200084C6173744E616D650100490000000100055749445448
      0200020032000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 16
    object CdsResgisterId: TLargeintField
      FieldName = 'Id'
    end
    object CdsResgisterNature: TIntegerField
      FieldName = 'Nature'
    end
    object CdsResgisterDocument: TStringField
      FieldName = 'Document'
    end
    object CdsResgisterCep: TStringField
      FieldName = 'Cep'
      Size = 15
    end
    object CdsResgisterFirstName: TStringField
      FieldName = 'FirstName'
      Size = 50
    end
    object CdsResgisterLastName: TStringField
      FieldName = 'LastName'
      Size = 50
    end
  end
  object dsResigter: TDataSource
    DataSet = CdsResgister
    Left = 400
    Top = 16
  end
end
