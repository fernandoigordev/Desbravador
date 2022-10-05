unit Domain.UseCase.Person.Create;

interface
uses Domain.UseCase.Person.Create.Interfaces,
     Domain.Abstraction.Person,
     Data.Repository.Person.Interfaces,
     REST.Json;

type
TUseCasePersonCreate = Class(TInterfacedObject, IUseCasePersonCreate)
  private
    FRepositoryPerson: IRepositoryPerson;
  public
    Constructor Create(ARepositoryPerson: IRepositoryPerson);
    function Execute(AJson: String): String;
End;

implementation

uses
  System.SysUtils, Data.Service.Key;

{ TUseCasePersonCreate }

constructor TUseCasePersonCreate.Create(ARepositoryPerson: IRepositoryPerson);
begin
  FRepositoryPerson := ARepositoryPerson;
end;

function TUseCasePersonCreate.Execute(AJson: String): String;
var
  Person: TAbstractionPerson;
begin
  try
    Person := TJson.JsonToObject<TAbstractionPerson>(AJson);
    Person.Id := TServiceKey.Instance.NewPrimaryKey;
    Person.Registration_Date := Now;
    FRepositoryPerson.CreatePerson(Person);
    Result := TJson.ObjectToJsonString(Person);
  except
    on E: Exception do
    begin
      raise Exception.Create(Concat('Erro ao converter Json em pessoa: ', E.Message));
    end;
  end;
end;

end.
