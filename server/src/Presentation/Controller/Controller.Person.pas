unit Controller.Person;

interface
uses Horse,
     Data.Repository.Person.Interfaces,
     Data.Service.ObserverAdress.Interfaces;

Type
TControllerPerson = Class
  private
    Class var FControllerPerson: TControllerPerson;
    FRepositoryPerson: IRepositoryPerson;
    FObserverAdress: IObserverAdress;
  public
    Class function Instance: TControllerPerson;
    Constructor Create;
    procedure RegisterRoutes;
    procedure CreatePerson(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure UpdatePerson(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure DeletePerson(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure CreatePeople(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    procedure ReadPeople(Req: THorseRequest; Res: THorseResponse; Next: TProc);
End;

implementation
uses
     System.SysUtils,
     Data.Repository.DM,
     Data.Repository.Person.SqLite,
     Domain.UseCase.Person.Create.Interfaces,
     Domain.UseCase.Person.Create,
     Domain.UseCase.Person.Update.Interfaces,
     Domain.UseCase.Person.Update,
     Domain.UseCase.Person.Read.Interfaces,
     Domain.UseCase.Person.Read,
     Data.Service.Adress;

{ TControllerPessoa }

procedure TControllerPerson.ReadPeople(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  UseCasePersonRead: IUseCasePersonRead;
  JsonReturn: String;
begin
  try
    UseCasePersonRead := TUseCasePersonRead.Create(FRepositoryPerson);
    JsonReturn := UseCasePersonRead.Execute;
    Res.Status(200).Send(JsonReturn);
  except
    on E: Exception do
    begin
      Res.Status(500).Send(Concat('{"message":"',E.Message,'"}'));
    end;
  end;
end;

procedure TControllerPerson.RegisterRoutes;
begin
  THorse.Post('/person', CreatePerson);
  THorse.Put('/person', UpdatePerson);
  THorse.Delete('/person/:id', DeletePerson);
  THorse.Post('/people', CreatePeople);
  THorse.Get('/people', ReadPeople);
end;

procedure TControllerPerson.CreatePerson(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  UseCasePersonCreate: IUseCasePersonCreate;
  JsonReturn: String;
begin
  try
    UseCasePersonCreate := TUseCasePersonCreate.Create(FRepositoryPerson);
    JsonReturn := UseCasePersonCreate.Execute(Req.Body);
    Res.Status(201).Send(JsonReturn);
  Except
    on E: Exception do
    begin
      Res.Status(500).Send(Concat('{"message":"',E.Message,'"}'));
    end;
  end;
end;

procedure TControllerPerson.UpdatePerson(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  UseCasePersonUpdate: IUseCasePersonUpdate;
  JsonReturn: String;
begin
  try
    UseCasePersonUpdate := TUseCasePersonUpdate.Create(FRepositoryPerson);
    JsonReturn := UseCasePersonUpdate.Execute(Req.Body);
    Res.Status(200).Send(JsonReturn);
  Except
    on E: Exception do
    begin
      Res.Status(500).Send(Concat('{"message":"',E.Message,'"}'));
    end;
  end;
end;

procedure TControllerPerson.DeletePerson(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  try
    FRepositoryPerson.DeletePerson(Req.Params.Items['id'].ToInt64);
    Res.Status(200);
  Except
    on E: Exception do
    begin
      Res.Status(500).Send(Concat('{"message":"',E.Message,'"}'));
    end;
  end;
end;

constructor TControllerPerson.Create;
begin
  FRepositoryPerson := TRepositoryPersonSqLite.Create(TDM.GetInstance.FDConnection1);
  FObserverAdress := TServiceAdress.Create(TDM.GetInstance.FDConnection1);
  FRepositoryPerson.AddObserver(FObserverAdress);
end;

class function TControllerPerson.Instance: TControllerPerson;
begin
  if Not Assigned(FControllerPerson) then
    FControllerPerson := TControllerPerson.Create;

  Result := FControllerPerson;
end;

procedure TControllerPerson.CreatePeople(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  //Recebe a req
  //passa para o Model Criar
  //Retorna a resposta
  Res.Status(201).Send('{"Método": "CriarPessoas"}');
end;

end.
