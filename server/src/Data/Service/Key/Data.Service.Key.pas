unit Data.Service.Key;

interface
uses Data.Service.Key.Interfaces;

type
TServiceKey = Class(TInterfacedObject, IServiceKey)
  private
    Class var FServiceKey: IServiceKey;
  public
    Class function Instance: IServiceKey;
    function NewPrimaryKey: Int64;
End;

implementation

uses
  System.SysUtils;

{ TServiceKey }

Class function TServiceKey.Instance: IServiceKey;
begin
  if not Assigned(FServiceKey) then
    FServiceKey := TServiceKey.Create;
  Result := FServiceKey;
end;

function TServiceKey.NewPrimaryKey: Int64;
var
  DateStr: String;
begin
  DateStr := FormatDateTime('dd/mm/yyyy hh:mm:ss:zz', Now);
  DateStr := StringReplace(DateStr,'/', '', [rfReplaceAll]);
  DateStr := StringReplace(DateStr,':', '', [rfReplaceAll]);
  DateStr := StringReplace(DateStr,' ', '', [rfReplaceAll]);
  DateStr := Concat(IntToStr(Random(10)),Trim(DateStr),IntToStr(Random(10)));
  Result := StrToInt64(DateStr);
end;

end.
