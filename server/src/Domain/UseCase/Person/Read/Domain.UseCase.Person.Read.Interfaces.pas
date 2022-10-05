unit Domain.UseCase.Person.Read.Interfaces;

interface
uses Domain.Abstraction.Person;

type
IUseCasePersonRead = interface
  ['{0E394F6B-1694-436F-BD0C-70AA067CADF6}']
  function Execute: String;
end;

implementation

end.
