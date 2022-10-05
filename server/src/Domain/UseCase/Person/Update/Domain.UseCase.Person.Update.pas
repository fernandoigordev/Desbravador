unit Domain.UseCase.Person.Update;

interface
uses Domain.UseCase.Person.Update.Interfaces,
     Domain.Abstraction.Person,
     Data.Repository.Person.Interfaces,
     REST.Json;

type
TUseCasePersonUpdate = Class(TInterfacedObject, IUseCasePersonUpdate)
  private
    FRepositoryPerson: IRepositoryPerson;
  public
    Constructor Create(ARepositoryPerson: IRepositoryPerson);
    function Execute(AJson: String): String;
End;

implementation

uses
  System.SysUtils;

{ TUseCasePersonCreate }

constructor TUseCasePersonUpdate.Create(ARepositoryPerson: IRepositoryPerson);
begin
  FRepositoryPerson := ARepositoryPerson;
end;

function TUseCasePersonUpdate.Execute(AJson: String): String;
var
  Person: TAbstractionPerson;
begin
  try
    Person := TJson.JsonToObject<TAbstractionPerson>(AJson);
    FRepositoryPerson.UpdatePerson(Person);
    Result := TJson.ObjectToJsonString(Person);
  except
    on E: Exception do
    begin
      raise Exception.Create(Concat('Erro ao converter Json em pessoa: ', E.Message));
    end;
  end;
end;

end.
