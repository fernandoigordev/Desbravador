unit Dto.Person;

interface

type
TPersonDto = Class
  private
    FId: Int64;
    FNature: Integer;
    FDocument: String;
    FFirst_Name: String;
    FLast_Name: String;
    FCep: String;
  public
    property Id: Int64 read FId write FId;
    property Nature: Integer read FNature write FNature;
    property Document: String read FDocument write FDocument;
    property First_Name: String read FFirst_Name write FFirst_Name;
    property Last_Name: String read FLast_Name write FLast_Name;
    property Cep: String read FCep write FCep;
End;

implementation

end.
