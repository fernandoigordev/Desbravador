unit Model.Person;

interface
uses Model.Person.Interfaces, System.Generics.Collections,
     IdHTTP, IdSSLOpenSSL, Dto.Person;

const
  BASE_URL = 'http://localhost:9000';
type
TModelPerson = Class(TInterfacedObject, IModelPerson)
  private
    FId: Int64;
    FNature: Integer;
    FDocument: String;
    FFirstName: String;
    FLastName: String;
    FCep: String;

    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  public
    Class function New: IModelPerson;
    Constructor Create;
    function Id(AValue: Int64): IModelPerson;overload;
    function Id: Int64;overload;
    function Nature(AValue: Integer):IModelPerson;overload;
    function Nature: Integer;overload;
    function Document(AValue: String): IModelPerson;overload;
    function Document: String;overload;
    function FirstName(AValue: String): IModelPerson;overload;
    function FirstName: String;overload;
    function LastName(AValue: String): IModelPerson;overload;
    function LastName: String;overload;
    function Cep(AValue: String): IModelPerson;overload;
    function Cep: String;overload;

    procedure CreatePerson;
    function ReadPeople: TList<TPersonDto>;
    procedure UpdatePerson;
    procedure DeletePerson;
End;

implementation

uses
  Vcl.Dialogs, REST.Json, System.Classes, System.SysUtils;

{ TModelPerson }

function TModelPerson.Cep: String;
begin
  Result := FCep;
end;

function TModelPerson.Cep(AValue: String): IModelPerson;
begin
  Result := Self;
  FCep := AValue;
end;

function TModelPerson.Document(AValue: String): IModelPerson;
begin
  Result := Self;
  FDocument := AValue;
end;

function TModelPerson.Document: String;
begin
  Result := FDocument;
end;

function TModelPerson.FirstName: String;
begin
  Result := FFirstName;
end;

function TModelPerson.FirstName(AValue: String): IModelPerson;
begin
  Result := Self;
  FFirstName := AValue;
end;

function TModelPerson.Id: Int64;
begin
  Result := FId;
end;

function TModelPerson.Id(AValue: Int64): IModelPerson;
begin
  Result := Self;
  FId := AValue;
end;

function TModelPerson.LastName: String;
begin
  Result := FLastName;
end;

function TModelPerson.LastName(AValue: String): IModelPerson;
begin
  Result := Self;
  FLastName := AValue;
end;

function TModelPerson.Nature(AValue: Integer): IModelPerson;
begin
  Result := Self;
  FNature := AValue;
end;

function TModelPerson.Nature: Integer;
begin
  Result := FNature;
end;

Class function TModelPerson.New: IModelPerson;
begin
  Result := TModelPerson.Create;
end;

constructor TModelPerson.Create;
begin
  FIdHTTP := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvTLSv1;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1];
  FIdHttp.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdHttp.Request.ContentType := 'application/json';
end;

procedure TModelPerson.CreatePerson;
var
  PersonDto: TPersonDto;
  JsonPerson: String;
begin
  PersonDto := TPersonDto.Create;
  try
    PersonDto.Id := FId;
    PersonDto.Nature := FNature;
    PersonDto.Document := FDocument;
    PersonDto.First_Name := FFirstName;
    PersonDto.Last_Name  := FLastName;
    PersonDto.Cep := FCep;

    JsonPerson := TJson.ObjectToJsonString(PersonDto);
    FIdHTTP.Post(Concat(BASE_URL, '/person'), TStringStream.Create(JsonPerson));
  finally
    PersonDto.Free;
  end;
end;

function TModelPerson.ReadPeople: TList<TPersonDto>;
var
  JsonPerson: String;
  List: TList<TPersonDto>;
begin
  JsonPerson := FIdHTTP.Get(Concat(BASE_URL, '/people'));
  if JsonPerson <> EmptyStr then
    List := TJson.JsonToObject<TList<TPersonDto>>(JsonPerson);

  Result := List;
end;

procedure TModelPerson.UpdatePerson;
var
  PersonDto: TPersonDto;
  JsonPerson: String;
begin
  PersonDto := TPersonDto.Create;
  try
    PersonDto.Id := FId;
    PersonDto.Nature := FNature;
    PersonDto.Document := FDocument;
    PersonDto.First_Name := FFirstName;
    PersonDto.Last_Name  := FLastName;
    PersonDto.Cep := FCep;

    JsonPerson := TJson.ObjectToJsonString(PersonDto);
    FIdHTTP.Put(Concat(BASE_URL, '/person'), TStringStream.Create(JsonPerson));
  finally
    PersonDto.Free;
  end;
end;

procedure TModelPerson.DeletePerson;
begin
  FIdHTTP.Delete(Concat(BASE_URL, '/person/', IntToStr(FId)));
end;

end.
