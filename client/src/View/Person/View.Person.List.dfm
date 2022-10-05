object frmPersonList: TfrmPersonList
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 442
  ClientWidth = 784
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 70
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTop'
    Color = clSilver
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      784
      70)
    object Shape1: TShape
      Left = 642
      Top = 24
      Width = 129
      Height = 33
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Brush.Color = clTeal
      Shape = stRoundRect
      ExplicitLeft = 632
    end
    object SpeedButton1: TSpeedButton
      Left = 642
      Top = 24
      Width = 129
      Height = 33
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = SpeedButton1Click
      ExplicitLeft = 632
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 20
      Top = 3
      Width = 155
      Height = 64
      Margins.Left = 20
      Align = alLeft
      Caption = 'Listagem de Pessoas'
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
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 75
    Width = 778
    Height = 364
    Margins.Top = 5
    Align = alClient
    BorderStyle = bsNone
    DataSource = dsSearch
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 123
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nature'
        Title.Caption = 'Natureza'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Document'
        Title.Caption = 'Documento'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 136
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FirstName'
        Title.Caption = 'Primeiro Nome'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LastName'
        Title.Caption = 'Segundo Nome'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 168
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cep'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 92
        Visible = True
      end>
  end
  object CdsSearch: TClientDataSet
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
    object CdsSearchId: TLargeintField
      FieldName = 'Id'
    end
    object CdsSearchNature: TIntegerField
      FieldName = 'Nature'
    end
    object CdsSearchDocument: TStringField
      FieldName = 'Document'
    end
    object CdsSearchCep: TStringField
      FieldName = 'Cep'
      Size = 15
    end
    object CdsSearchFirstName: TStringField
      FieldName = 'FirstName'
      Size = 50
    end
    object CdsSearchLastName: TStringField
      FieldName = 'LastName'
      Size = 50
    end
  end
  object dsSearch: TDataSource
    DataSet = CdsSearch
    Left = 376
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 384
    Top = 224
    object Editar1: TMenuItem
      Caption = 'Editar'
      OnClick = Editar1Click
    end
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      OnClick = Excluir1Click
    end
  end
end
