program Desbravador_Client;

uses
  Vcl.Forms,
  View.Person.List in 'src\View\Person\View.Person.List.pas' {frmPersonList},
  View.Person.Register in 'src\View\Person\View.Person.Register.pas' {frmPersonRegister},
  Model.Person.Interfaces in 'src\Model\Person\Model.Person.Interfaces.pas',
  Model.Person in 'src\Model\Person\Model.Person.pas',
  Controller.Person in 'src\Controller\Controller.Person.pas',
  Dto.Person in 'src\Dto\Dto.Person.pas',
  Observer.Person.Interfaces in 'src\Observer\Person\Observer.Person.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPersonList, frmPersonList);
  Application.Run;
end.
