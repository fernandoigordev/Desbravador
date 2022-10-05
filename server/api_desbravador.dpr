program api_desbravador;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Controller.Person in 'src\Presentation\Controller\Controller.Person.pas',
  Domain.Abstraction.Person in 'src\Domain\Abstraction\Domain.Abstraction.Person.pas',
  Data.Repository.DM in 'src\Data\Repository\Data.Repository.DM.pas' {DM: TDataModule},
  Data.Service.Key.Interfaces in 'src\Data\Service\Key\Data.Service.Key.Interfaces.pas',
  Data.Service.Key in 'src\Data\Service\Key\Data.Service.Key.pas',
  Domain.UseCase.Person.Create.Interfaces in 'src\Domain\UseCase\Person\Create\Domain.UseCase.Person.Create.Interfaces.pas',
  Domain.UseCase.Person.Create in 'src\Domain\UseCase\Person\Create\Domain.UseCase.Person.Create.pas',
  Data.Repository.Person.Interfaces in 'src\Data\Repository\Person\Data.Repository.Person.Interfaces.pas',
  Data.Repository.Person.SqLite in 'src\Data\Repository\Person\Data.Repository.Person.SqLite.pas',
  Domain.UseCase.Person.Update.Interfaces in 'src\Domain\UseCase\Person\Update\Domain.UseCase.Person.Update.Interfaces.pas',
  Domain.UseCase.Person.Update in 'src\Domain\UseCase\Person\Update\Domain.UseCase.Person.Update.pas',
  Data.Service.Adress in 'src\Data\Service\Adress\Data.Service.Adress.pas',
  Domain.Abstraction.Viacep in 'src\Domain\Abstraction\Domain.Abstraction.Viacep.pas',
  Data.Service.ObserverAdress.Interfaces in 'src\Data\Service\Adress\Data.Service.ObserverAdress.Interfaces.pas',
  Domain.UseCase.Person.Read.Interfaces in 'src\Domain\UseCase\Person\Read\Domain.UseCase.Person.Read.Interfaces.pas',
  Domain.UseCase.Person.Read in 'src\Domain\UseCase\Person\Read\Domain.UseCase.Person.Read.pas';

begin
  try
    TControllerPerson.Instance.RegisterRoutes;
    THorse.Listen(9000);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
