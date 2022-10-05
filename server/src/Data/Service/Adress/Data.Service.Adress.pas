unit Data.Service.Adress;

interface
uses Data.Service.ObserverAdress.Interfaces,
     IdHTTP,
     FireDAC.Comp.Client,
     FireDAC.DApt,
     IdComponent,
     IdSSLOpenSSL,
     System.Classes;

Type
TUpdatePersonAdress = Class(TThread)
  private
    FAddressInformation: RAddressInformation;
    FQuery: TFDQuery;
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
  public
    Constructor Create(AddressInformation: RAddressInformation; AConnection: TFDConnection);
    procedure Execute;Override;
End;

TServiceAdress = Class(TInterfacedObject, IObserverAdress)
  private
    FConnection: TFDConnection;
  public
    Constructor Create(AConnection: TFDConnection);
    procedure Update(AValue: RAddressInformation);
End;

implementation

uses
  System.SysUtils,
  Domain.Abstraction.Viacep,
  REST.Json;

{ TServiceAdress }

constructor TServiceAdress.Create(AConnection: TFDConnection);
begin
  FConnection  := AConnection;
end;

procedure TServiceAdress.Update(AValue: RAddressInformation);
var
  UpdatePersonAdress: TUpdatePersonAdress;
begin
  UpdatePersonAdress := TUpdatePersonAdress.Create(AValue, FConnection);
  UpdatePersonAdress.Start;
end;

{ TUpdatePersonAdress }

constructor TUpdatePersonAdress.Create(AddressInformation: RAddressInformation; AConnection: TFDConnection);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FAddressInformation := AddressInformation;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := AConnection;
  FIdHTTP := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvSSLv2;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2, sslvSSLv2];
  FIdHttp.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdHttp.Request.ContentType := 'application/json';
  FIdHttp.HandleRedirects := True;
end;

procedure TUpdatePersonAdress.Execute;
var
  JsonViacep: String;
  AbstractionViacep: TAbstractionViacep;
begin
  inherited;
  JsonViacep := FIdHTTP.Get(Concat('https://viacep.com.br/ws/',FAddressInformation.Cep,'/json/'));
  if FIdHTTP.Response.ResponseCode = 200 then
    AbstractionViacep := TJson.JsonToObject<TAbstractionViacep>(JsonViacep);

  FQuery.Close;
  FQuery.SQL.Text := Concat('select * from endereco_integracao ei ',
                            'join endereco e on e.idendereco = ei.idendereco ',
                            'where e.idpessoa = :idpessoa');
  FQuery.ParamByName('idpessoa').AsLargeInt := FAddressInformation.PersonId;
  FQuery.Open;

  if FQuery.RecordCount > 0 then
  begin
    FQuery.Close;
    FQuery.SQL.Text := Concat('update endereco_integracao set dsuf=:dsuf, nmcidade=:nmcidade, nmbairro=:nmbairro,',
                              'nmlogradouro=:nmlogradouro, dscomplemento=:dscomplemento ',
                              'where idendereco=:idendereco');

    FQuery.ParamByName('dsuf').AsString := AbstractionViacep.Uf;
    FQuery.ParamByName('nmcidade').AsString := AbstractionViacep.Localidade;
    FQuery.ParamByName('nmbairro').AsString := AbstractionViacep.Bairro;
    FQuery.ParamByName('nmlogradouro').AsString := AbstractionViacep.Logradouro;
    FQuery.ParamByName('dscomplemento').AsString := AbstractionViacep.Complemento;
    FQuery.ParamByName('idendereco').AsLargeInt := FAddressInformation.AdreesId;
    FQuery.ExecSQL;
  end
  else
  begin
    FQuery.Close;
    FQuery.SQL.Text := Concat('insert into endereco_integracao(idendereco, dsuf, nmcidade, nmbairro, nmlogradouro, dscomplemento) ',
                              'values(:idendereco, :dsuf, :nmcidade, :nmbairro, :nmlogradouro, :dscomplemento)');

    FQuery.ParamByName('dsuf').AsString := AbstractionViacep.Uf;
    FQuery.ParamByName('nmcidade').AsString := AbstractionViacep.Localidade;
    FQuery.ParamByName('nmbairro').AsString := AbstractionViacep.Bairro;
    FQuery.ParamByName('nmlogradouro').AsString := AbstractionViacep.Logradouro;
    FQuery.ParamByName('dscomplemento').AsString := AbstractionViacep.Complemento;
    FQuery.ParamByName('idendereco').AsLargeInt := FAddressInformation.AdreesId;
    FQuery.ExecSQL;
  end;
end;

end.
