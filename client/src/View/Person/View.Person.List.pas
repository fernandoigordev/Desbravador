unit View.Person.List;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, View.Person.Register,
  Datasnap.DBClient, Vcl.Menus, Controller.Person, Observer.Person.Interfaces,
  System.Generics.Collections, Dto.Person;

type
  TfrmPersonList = class(TForm, IObserverPerson)
    pnlTop: TPanel;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    Shape1: TShape;
    Label1: TLabel;
    CdsSearch: TClientDataSet;
    CdsSearchId: TLargeintField;
    CdsSearchNature: TIntegerField;
    CdsSearchDocument: TStringField;
    CdsSearchCep: TStringField;
    CdsSearchFirstName: TStringField;
    CdsSearchLastName: TStringField;
    dsSearch: TDataSource;
    PopupMenu1: TPopupMenu;
    Editar1: TMenuItem;
    Excluir1: TMenuItem;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FControllerPerson: TControllerPerson;
    procedure Update(AList: TList<TPersonDto>);
  public
    { Public declarations }
  end;

var
  frmPersonList: TfrmPersonList;

implementation

{$R *.dfm}

procedure TfrmPersonList.Editar1Click(Sender: TObject);
var
  frmPersonRegister: TfrmPersonRegister;
begin
  if CdsSearch.RecordCount > 0 then
  begin
    frmPersonRegister := TfrmPersonRegister.Create;
    try
      frmPersonRegister.PopulatePerson(CdsSearch);
      frmPersonRegister.ShowModal;
      FControllerPerson.ReadPeople;
    finally
      FreeAndNil(frmPersonRegister);
    end;
  end;
end;

procedure TfrmPersonList.Excluir1Click(Sender: TObject);
begin
  if CdsSearch.RecordCount > 0 then
  begin
    if MessageDlg('Deseja Excluir essa pessoa?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try
        FControllerPerson.DeletePerson;
        MessageDlg('Deletado com sucesso!', mtInformation,[mbOK], 0);
        FControllerPerson.ReadPeople;
      Except
        on E: Exception do
        begin
          MessageDlg(Concat('Erro ao Deletar!', #13, E.Message), mtError,[mbOK], 0);
        end;
      end;
    end;
  end;
end;

procedure TfrmPersonList.FormCreate(Sender: TObject);
begin
  FControllerPerson := TControllerPerson.Create(CdsSearch);
  FControllerPerson.Add(Self);
end;

procedure TfrmPersonList.FormShow(Sender: TObject);
begin
  FControllerPerson.ReadPeople;
end;

procedure TfrmPersonList.SpeedButton1Click(Sender: TObject);
var
  frmPersonRegister: TfrmPersonRegister;
begin
  frmPersonRegister := TfrmPersonRegister.Create;
  try
    frmPersonRegister.ShowModal;
    FControllerPerson.ReadPeople;
  finally
    FreeAndNil(frmPersonRegister);
  end;
end;

procedure TfrmPersonList.Update(AList: TList<TPersonDto>);
var
  Person: TPersonDto;
begin
  CdsSearch.EmptyDataSet;
  if AList.Count > 0 then
  begin
    for Person in AList do
    begin
      CdsSearch.Append;
      CdsSearch.FieldByName('Id').AsLargeInt      := Person.Id;
      CdsSearch.FieldByName('Nature').AsInteger   := Person.Nature;
      CdsSearch.FieldByName('Document').AsString  := Person.Document;
      CdsSearch.FieldByName('FirstName').AsString := Person.First_Name;
      CdsSearch.FieldByName('LastName').AsString  := Person.Last_Name;
      CdsSearch.FieldByName('Cep').AsString := Person.Cep;
      CdsSearch.Post;
    end;
  end;
end;

end.
