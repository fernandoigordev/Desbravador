unit Data.Repository.Person.SqLite;

interface
uses Data.Repository.Person.Interfaces,
     Domain.Abstraction.Person,
     FireDAC.Comp.Client, FireDAC.DApt,
     Data.Service.ObserverAdress.Interfaces, System.Generics.Collections;

Type
TRepositoryPersonSqLite = Class(TInterfacedObject, IRepositoryPerson, ISubjectAdress)
  private
    FQuery: TFDQuery;
    FList: TList<IObserverAdress>;

    procedure Add(AValue: IObserverAdress);
    procedure Notify(AValue: RAddressInformation);
  public
    Constructor Create(AConnection: TFDConnection);
    Destructor Destroy;override;
    procedure CreatePerson(APerson: TAbstractionPerson);
    procedure UpdatePerson(APerson: TAbstractionPerson);
    procedure DeletePerson(AId: Int64);
    function ReadPeople: TList<TAbstractionPerson>;

    procedure AddObserver(AValue: IObserverAdress);
End;

implementation

uses
  System.SysUtils, Data.Service.Key;

{ TRepositoryPersonSqLite }

procedure TRepositoryPersonSqLite.Add(AValue: IObserverAdress);
begin
  FList.Add(AValue);
end;

procedure TRepositoryPersonSqLite.Notify(AValue: RAddressInformation);
var
  Index: Integer;
begin
  if FList.Count > 0 then
  begin
    for Index := 0 to Pred(FList.Count) do
      FList.Items[Index].Update(AValue);
  end;
end;

function TRepositoryPersonSqLite.ReadPeople: TList<TAbstractionPerson>;
var
  List: TList<TAbstractionPerson>;
  Index: Integer;
begin
  List := TList<TAbstractionPerson>.Create;
  FQuery.Close;
  FQuery.SQL.Text := Concat('select p.*,e.dscep from pessoa p ',
                            'join endereco e on e.idpessoa = p.idpessoa');
  FQuery.Open;

  if FQuery.RecordCount > 0 then
  begin
    FQuery.First;
    while not FQuery.Eof do
    begin
      Index := List.Add(TAbstractionPerson.Create);
      List.Items[Index].Id := FQuery.FieldByName('idpessoa').AsLargeInt;
      List.Items[Index].Nature := FQuery.FieldByName('flnatureza').AsInteger;
      List.Items[Index].Document := FQuery.FieldByName('dsdocumento').AsString;
      List.Items[Index].First_Name := FQuery.FieldByName('nmprimeiro').AsString;
      List.Items[Index].Last_Name := FQuery.FieldByName('nmsegundo').AsString;
      List.Items[Index].Registration_Date := FQuery.FieldByName('dtregistro').AsDateTime;
      List.Items[Index].Cep := FQuery.FieldByName('dscep').AsString;

      FQuery.Next;
    end;
  end;
  Result := List;
end;

procedure TRepositoryPersonSqLite.AddObserver(AValue: IObserverAdress);
begin
  Add(AValue);
end;

constructor TRepositoryPersonSqLite.Create(AConnection: TFDConnection);
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
  FList := TList<IObserverAdress>.Create;
end;

procedure TRepositoryPersonSqLite.CreatePerson(APerson: TAbstractionPerson);
var
  AddressInformation: RAddressInformation;
begin
  FQuery.Connection.StartTransaction;
  try
    FQuery.Close;
    FQuery.SQL.Text := Concat('insert into pessoa(idpessoa, flnatureza, dsdocumento, nmprimeiro, nmsegundo, dtregistro) ',
                              'values(:idpessoa, :flnatureza, :dsdocumento, :nmprimeiro, :nmsegundo, :dtregistro)');

    FQuery.ParamByName('idpessoa').AsLargeInt   := APerson.Id;
    FQuery.ParamByName('flnatureza').AsInteger  := APerson.Nature;
    FQuery.ParamByName('dsdocumento').AsString  := APerson.Document;
    FQuery.ParamByName('nmprimeiro').AsString   := APerson.First_Name;
    FQuery.ParamByName('nmsegundo').AsString    := APerson.Last_Name;
    FQuery.ParamByName('dtregistro').AsDateTime := APerson.Registration_Date;
    FQuery.ExecSQL;

    FQuery.Close;
    FQuery.SQL.Text := Concat('insert into endereco(idendereco, idpessoa, dscep) ',
                              'values(:idendereco, :idpessoa, :dscep)');
    FQuery.ParamByName('idendereco').AsLargeInt   := TServiceKey.Instance.NewPrimaryKey;
    FQuery.ParamByName('idpessoa').AsLargeInt  := APerson.Id;
    FQuery.ParamByName('dscep').AsString  := APerson.Cep;
    FQuery.ExecSQL;
    FQuery.Connection.Commit;

    AddressInformation.PersonId := APerson.Id;
    AddressInformation.AdreesId := FQuery.ParamByName('idendereco').AsLargeInt;
    AddressInformation.Cep := APerson.Cep;
    Notify(AddressInformation);
  Except
    on E: Exception do
    begin
      FQuery.Connection.Rollback;
      raise E;
    end;
  end;
end;

procedure TRepositoryPersonSqLite.DeletePerson(AId: Int64);
begin
  try
    FQuery.Close;
    FQuery.SQL.Text := 'delete from pessoa where idpessoa=:idpessoa';
    FQuery.ParamByName('idpessoa').AsLargeInt := AId;
    FQuery.ExecSQL;
  Except
    on E: Exception do
    begin
      raise E;
    end;
  end;
end;

destructor TRepositoryPersonSqLite.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TRepositoryPersonSqLite.UpdatePerson(APerson: TAbstractionPerson);
var
  AddressInformation: RAddressInformation;
begin
  FQuery.Connection.StartTransaction;
  try
    FQuery.Close;
    FQuery.SQL.Text := Concat('update pessoa set flnatureza=:flnatureza, dsdocumento=:dsdocumento, ',
                              'nmprimeiro=:nmprimeiro, nmsegundo=:nmsegundo ',
                              'where idpessoa=:idpessoa');

    FQuery.ParamByName('idpessoa').AsLargeInt   := APerson.Id;
    FQuery.ParamByName('flnatureza').AsInteger  := APerson.Nature;
    FQuery.ParamByName('dsdocumento').AsString  := APerson.Document;
    FQuery.ParamByName('nmprimeiro').AsString   := APerson.First_Name;
    FQuery.ParamByName('nmsegundo').AsString    := APerson.Last_Name;
    FQuery.ExecSQL;

    FQuery.Close;
    FQuery.SQL.Text := 'select * from endereco where idpessoa=:idpessoa';
    FQuery.ParamByName('idpessoa').AsLargeInt  := APerson.Id;
    FQuery.Open;
    if FQuery.RecordCount > 0 then
    begin
      FQuery.Edit;
      FQuery.FieldByName('dscep').AsString := APerson.Cep;
      FQuery.Post;

      AddressInformation.PersonId := APerson.Id;
      AddressInformation.AdreesId := FQuery.FieldByName('idendereco').AsLargeInt;
      AddressInformation.Cep := APerson.Cep;
    end;

    FQuery.Connection.Commit;
    Notify(AddressInformation);
  Except
    on E: Exception do
    begin
      FQuery.Connection.Rollback;
      raise E;
    end;
  end;
end;

end.
