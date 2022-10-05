unit Domain.UseCase.Person.Read;

interface
uses Domain.UseCase.Person.Read.Interfaces,
     Data.Repository.Person.Interfaces,
     Domain.Abstraction.Person,
     REST.Json, System.Generics.Collections;

type
TUseCasePersonRead = Class(TInterfacedObject, IUseCasePersonRead)
  private
    FRepositoryPerson: IRepositoryPerson;
  public
    Constructor Create(ARepositoryPerson: IRepositoryPerson);
    function Execute: String;
End;

implementation

{ TUseCasePersonRead }

constructor TUseCasePersonRead.Create(ARepositoryPerson: IRepositoryPerson);
begin
  FRepositoryPerson := ARepositoryPerson;
end;

function TUseCasePersonRead.Execute: String;
var
  List: TList<TAbstractionPerson>;
begin
  Result := '{}';
  List := FRepositoryPerson.ReadPeople;
  if Assigned(List) then
    Result := TJson.ObjectToJsonString(List);
end;

end.
