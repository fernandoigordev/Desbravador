unit Data.Repository.DM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Class var FDM: TDM;
  public
    { Public declarations }
    Class Function GetInstance: TDM;
  end;

implementation
uses VCl.Forms;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.DriverName := 'sQLite';
  FDConnection1.Params.Database := Concat(ExtractFileDir(Application.ExeName), '\dataBase.sqlite');
  FDConnection1.LoginPrompt := False;
  FDConnection1.Connected := True;
end;

class function TDM.GetInstance: TDM;
begin
  if Not Assigned(FDM) then
    FDM := TDM.Create(nil);
  Result := FDM;
end;

end.
