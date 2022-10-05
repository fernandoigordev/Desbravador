unit View.Person.Register;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Data.DB, Datasnap.DBClient, Controller.Person;

type
  TTypeOperation = (toCreate, toUpdate);

  TfrmPersonRegister = class(TForm)
    pnlTop: TPanel;
    Label1: TLabel;
    pnlBottom: TPanel;
    ShapeSave: TShape;
    btnSave: TSpeedButton;
    btnCancel: TSpeedButton;
    ShapeCancel: TShape;
    edNature: TDBEdit;
    edDocument: TDBEdit;
    edFirstName: TDBEdit;
    edLastName: TDBEdit;
    PnlContent: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edCep: TDBEdit;
    CdsResgister: TClientDataSet;
    dsResigter: TDataSource;
    CdsResgisterNature: TIntegerField;
    CdsResgisterId: TLargeintField;
    CdsResgisterDocument: TStringField;
    CdsResgisterCep: TStringField;
    CdsResgisterFirstName: TStringField;
    CdsResgisterLastName: TStringField;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FControllerPerson: TControllerPerson;
    FTypeOperation: TTypeOperation;
    function Validate: Boolean;
  public
    { Public declarations }
    Constructor Create;
    procedure PopulatePerson(AClientDataSet: TClientDataSet);
  end;

implementation

uses
  System.SysUtils;

{$R *.dfm}

procedure TfrmPersonRegister.btnCancelClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente cancelar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Close;
  end;
end;

procedure TfrmPersonRegister.btnSaveClick(Sender: TObject);
begin
  if Validate then
  begin
    CdsResgister.Post;
    try
      case FTypeOperation of
        toCreate: FControllerPerson.CreatePerson;
        toUpdate: FControllerPerson.UpdatePerson;
      end;
      MessageDlg('Salvo com sucesso!', mtError,[mbOK], 0);
    Except
      on E: Exception do
      begin
        MessageDlg(Concat('Erro ao Salvar!', #13, E.Message), mtError,[mbOK], 0);
      end;
    end;
    Close;
  end;
end;

constructor TfrmPersonRegister.Create;
begin
  inherited Create(Application);
  FTypeOperation := toCreate;
end;

procedure TfrmPersonRegister.FormCreate(Sender: TObject);
begin
  FControllerPerson := TControllerPerson.Create(CdsResgister);
end;

procedure TfrmPersonRegister.FormShow(Sender: TObject);
begin
  case FTypeOperation of
    toCreate: CdsResgister.Insert;
    toUpdate: CdsResgister.Edit;
  end;
end;

procedure TfrmPersonRegister.PopulatePerson(AClientDataSet: TClientDataSet);
begin
  FTypeOperation := toUpdate;
  CdsResgister.Append;
  CdsResgister.FieldByName('Id').AsLargeInt      := AClientDataSet.FieldByName('Id').AsLargeInt;
  CdsResgister.FieldByName('Nature').AsInteger   := AClientDataSet.FieldByName('Nature').AsInteger;
  CdsResgister.FieldByName('Document').AsString  := AClientDataSet.FieldByName('Document').AsString;
  CdsResgister.FieldByName('FirstName').AsString := AClientDataSet.FieldByName('FirstName').AsString;
  CdsResgister.FieldByName('LastName').AsString  := AClientDataSet.FieldByName('LastName').AsString;
  CdsResgister.FieldByName('Cep').AsString := AClientDataSet.FieldByName('Cep').AsString;
  CdsResgister.Post;
end;

function TfrmPersonRegister.Validate: Boolean;
begin
  Result := True;
  if Result and (edNature.Text = EmptyStr) then
  begin
    Result := False;
    MessageDlg('Campo Natureza é obrigatório', mtWarning,[mbOK], 0);
    edNature.SetFocus;
  end
  else if Result and (edDocument.Text = EmptyStr) then
  begin
    Result := False;
    MessageDlg('Campo Documento é obrigatório', mtWarning,[mbOK], 0);
    edDocument.SetFocus;
  end
  else if Result and (edCep.Text = EmptyStr) then
  begin
    Result := False;
    MessageDlg('Campo Cep é obrigatório', mtWarning,[mbOK], 0);
    edDocument.SetFocus;
  end
  else if Result and (edFirstName.Text = EmptyStr) then
  begin
    Result := False;
    MessageDlg('Campo Primeiro Nome é obrigatório', mtWarning,[mbOK], 0);
    edFirstName.SetFocus;
  end
  else if Result and (edLastName.Text = EmptyStr) then
  begin
    Result := False;
    MessageDlg('Campo Segundo Nome é obrigatório', mtWarning,[mbOK], 0);
    edLastName.SetFocus;
  end;

end;

end.
