object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 378
  Width = 480
  object FDConnection: TFDConnection
    Params.Strings = (
      'Password=masterkey'
      'User_Name=SYSDBA'
      'Database=db_controlcomb'
      'Server=localhost'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 184
    Top = 88
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 184
    Top = 144
  end
  object FDPhysFBDriver: TFDPhysFBDriverLink
    Left = 184
    Top = 200
  end
end
