unit Domain.UseCase.Person.Create.Interfaces;

interface

type
  IUseCasePersonCreate = interface
    ['{C2A10DFD-9572-4758-82F0-3DFDC32E021B}']
    function Execute(AJson: String): String;
  end;

implementation

end.
