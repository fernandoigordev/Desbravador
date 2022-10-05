object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 367
  Width = 484
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=sQLite')
    Left = 48
    Top = 40
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 160
    Top = 48
  end
end
