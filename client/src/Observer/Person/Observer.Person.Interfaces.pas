unit Observer.Person.Interfaces;

interface
uses Dto.Person, System.Generics.Collections;

type

IObserverPerson = interface
  ['{BE0A30FF-6B08-4435-9583-FFB33731EB46}']
  procedure Update(AList: TList<TPersonDto>);
end;

ISubjectPerson = interface
  ['{D7F97273-FDB1-4521-BC5D-1FDB49466DAF}']
  procedure Add(AObserver: IObserverPerson);
  procedure Notify(AList: TList<TPersonDto>);
end;

implementation

end.
