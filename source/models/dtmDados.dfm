object dtm_Dados: Tdtm_Dados
  OldCreateOrder = False
  Height = 150
  Width = 327
  object fdConexao: TFDConnection
    Params.Strings = (
      'Database=base_teste'
      'User_Name=root'
      'Password=123456'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object FDQuery1: TFDQuery
    Connection = fdConexao
    Left = 32
    Top = 80
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 120
    Top = 16
  end
end
