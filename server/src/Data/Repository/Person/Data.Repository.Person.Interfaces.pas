unit Data.Repository.Person.Interfaces;

interface
uses Domain.Abstraction.Person,
     Data.Service.ObserverAdress.Interfaces,
     System.Generics.Collections;

type
IRepositoryPerson = interface
  ['{4E21D1E8-2362-47A9-94B5-4C2A22093D8F}']
  procedure CreatePerson(APerson: TAbstractionPerson);
  procedure UpdatePerson(APerson: TAbstractionPerson);
  procedure DeletePerson(AId: Int64);
  function ReadPeople: TList<TAbstractionPerson>;

  procedure AddObserver(AValue: IObserverAdress);
end;

implementation

end.
