unit Data.Service.ObserverAdress.Interfaces;

interface

type
RAddressInformation = record
  PersonId, AdreesId: Int64;
  Cep: String
end;

IObserverAdress = interface
  ['{0EEF90A4-0EE2-467E-876D-B81707605544}']
  procedure Update(AValue: RAddressInformation);
end;

ISubjectAdress = interface
  ['{66E15719-B6D0-4533-A6B6-CD119927338F}']
  procedure Add(AValue: IObserverAdress);
  procedure Notify(AValue: RAddressInformation);
end;

implementation

end.
