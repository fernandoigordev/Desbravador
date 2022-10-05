unit Controller.Person;

interface
uses Datasnap.DBClient, Observer.Person.Interfaces,
     System.Generics.Collections, Dto.Person;

type
TControllerPerson = Class(TInterfacedObject, ISubjectPerson)
  private
    FCds: TClientDataSet;
    FListObserver: TList<IObserverPerson>;
  public
    Constructor Create(AClientDataSet: TClientDataSet);
    procedure CreatePerson;
    procedure UpdatePerson;
    procedure ReadPeople;
    procedure DeletePerson;

    procedure Add(AObserver: IObserverPerson);
    procedure Notify(AList: TList<TPersonDto>);
End;

implementation

uses Model.Person.Interfaces,
     Model.Person;

{ TControllerPerson }

procedure TControllerPerson.Add(AObserver: IObserverPerson);
begin
  FListObserver.Add(AObserver);
end;

constructor TControllerPerson.Create(AClientDataSet: TClientDataSet);
begin
  FCds := AClientDataSet;
  FListObserver := TList<IObserverPerson>.Create;
end;

procedure TControllerPerson.CreatePerson;
begin
  TModelPerson.New
    .Nature(FCds.FieldByName('Nature').AsInteger)
    .Document(FCds.FieldByName('Document').AsString)
    .FirstName(FCds.FieldByName('FirstName').AsString)
    .LastName(FCds.FieldByName('LastName').AsString)
    .Cep(FCds.FieldByName('Cep').AsString)
    .CreatePerson;
end;

procedure TControllerPerson.DeletePerson;
begin
  TModelPerson.New
    .Id(FCds.FieldByName('Id').AsLargeInt)
    .DeletePerson;
end;

procedure TControllerPerson.Notify(AList: TList<TPersonDto>);
var
  Index: Integer;
begin
  for Index := 0 to Pred(FListObserver.Count) do
  begin
    FListObserver.Items[Index].Update(AList);
  end;
end;

procedure TControllerPerson.ReadPeople;
var
  List: TList<TPersonDto>;
begin
  List := TModelPerson.New
            .ReadPeople;
  Notify(List);
end;

procedure TControllerPerson.UpdatePerson;
begin
  TModelPerson.New
    .Id(FCds.FieldByName('Id').AsLargeInt)
    .Nature(FCds.FieldByName('Nature').AsInteger)
    .Document(FCds.FieldByName('Document').AsString)
    .FirstName(FCds.FieldByName('FirstName').AsString)
    .LastName(FCds.FieldByName('LastName').AsString)
    .Cep(FCds.FieldByName('Cep').AsString)
    .UpdatePerson;
end;

end.
