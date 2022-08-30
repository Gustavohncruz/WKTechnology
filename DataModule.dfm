object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 411
  Width = 534
  object fdConn: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Password=28Rf#Iom1x&j*)9'
      'Database=db_wktechnology'
      'Server=127.0.0.1'
      'UseSSL=False'
      'User_Name=gustavo')
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    Left = 48
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 160
    Top = 40
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\ADM\Desktop\WK Technology\exe\libmysql.dll'
    Left = 320
    Top = 40
  end
  object fdqCliente: TFDQuery
    Connection = fdConn
    SQL.Strings = (
      'SELECT * FROM CLIENTE')
    Left = 40
    Top = 120
    object fdqClienteIDCLIENTE: TFDAutoIncField
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object fdqClienteCODIGO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Size = 10
    end
    object fdqClienteNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object fdqClienteCIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 100
    end
    object fdqClienteUF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF'
      Origin = 'UF'
      Size = 2
    end
    object fdqClienteVALORTOTAL: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'VALORTOTAL'
    end
  end
  object fdqProduto: TFDQuery
    Connection = fdConn
    SQL.Strings = (
      'SELECT * FROM PRODUTO')
    Left = 136
    Top = 120
    object fdqProdutoIDPRODUTO: TFDAutoIncField
      FieldName = 'IDPRODUTO'
      Origin = 'IDPRODUTO'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object fdqProdutoCODIGO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      Size = 10
    end
    object fdqProdutoDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 100
    end
    object fdqProdutoPRECOVENDA: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PRECOVENDA'
      Origin = 'PRECOVENDA'
      Precision = 14
      Size = 2
    end
  end
  object fdqPedido: TFDQuery
    AfterOpen = fdqPedidoAfterOpen
    Connection = fdConn
    SQL.Strings = (
      'SELECT P.*,'
      '  C.CODIGO,  C.NOME,  C.CIDADE,  C.UF'
      'FROM PEDIDO P'
      'JOIN CLIENTE C ON P.IDCLIENTE=C.IDCLIENTE'
      'WHERE P.NUMPEDIDO=:NUMPEDIDO')
    Left = 40
    Top = 200
    ParamData = <
      item
        Name = 'NUMPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object fdqPedidoNUMPEDIDO: TFDAutoIncField
      FieldName = 'NUMPEDIDO'
      Origin = 'NUMPEDIDO'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object fdqPedidoEMISSAO: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'EMISSAO'
      Origin = 'EMISSAO'
    end
    object fdqPedidoIDCLIENTE: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'IDCLIENTE'
      Origin = 'IDCLIENTE'
    end
    object fdqPedidoVALORTOTAL: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALORTOTAL'
      Origin = 'VALORTOTAL'
      Precision = 14
      Size = 2
    end
    object fdqPedidoCODIGO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object fdqPedidoNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object fdqPedidoCIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object fdqPedidoUF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF'
      Origin = 'UF'
      ProviderFlags = []
      ReadOnly = True
      Size = 2
    end
  end
  object fdqPedidoItem: TFDQuery
    Connection = fdConn
    SQL.Strings = (
      'SELECT PI.*,'
      'P.CODIGO, P.DESCRICAO, P.PRECOVENDA'
      'FROM PEDIDOITEM PI'
      'JOIN PRODUTO P ON PI.IDPRODUTO=P.IDPRODUTO'
      'WHERE PI.NUMPEDIDO=:NUMPEDIDO')
    Left = 120
    Top = 208
    ParamData = <
      item
        Name = 'NUMPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object fdqPedidoItemAUTOINCREM: TFDAutoIncField
      FieldName = 'AUTOINCREM'
      Origin = 'AUTOINCREM'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object fdqPedidoItemNUMPEDIDO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'NUMPEDIDO'
      Origin = 'NUMPEDIDO'
    end
    object fdqPedidoItemIDPRODUTO: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'IDPRODUTO'
      Origin = 'IDPRODUTO'
    end
    object fdqPedidoItemQUANTIDADE: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
    end
    object fdqPedidoItemVALORUNIT: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALORUNIT'
      Origin = 'VALORUNIT'
      Precision = 14
      Size = 2
    end
    object fdqPedidoItemVALORTOTAL: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Total'
      FieldName = 'VALORTOTAL'
      Origin = 'VALORTOTAL'
      Precision = 14
      Size = 2
    end
    object fdqPedidoItemCODIGO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = []
      ReadOnly = True
      Size = 10
    end
    object fdqPedidoItemDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object fdqPedidoItemPRECOVENDA: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PRECOVENDA'
      Origin = 'PRECOVENDA'
      ProviderFlags = []
      ReadOnly = True
      Precision = 14
      Size = 2
    end
  end
  object fdmItens: TFDMemTable
    AfterClose = fdmItensAfterClose
    BeforePost = fdmItensBeforePost
    Filtered = True
    Filter = 'STATUS <>2'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 136
    Top = 288
    object fdmItensIDPRODUTO: TFDAutoIncField
      FieldName = 'IDPRODUTO'
      Origin = 'IDPRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere]
      IdentityInsert = True
    end
    object fdmItensDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Produto'
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 100
    end
    object fdmItensQUANTIDADE: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
    end
    object fdmItensVALORUNIT: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALORUNIT'
      Origin = 'VALORUNIT'
      DisplayFormat = '###,##0.00'
      Precision = 14
      Size = 2
    end
    object fdmItensVALORTOTAL: TBCDField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Valor Total'
      FieldName = 'VALORTOTAL'
      Origin = 'VALORTOTAL'
      DisplayFormat = '###,##0.00'
      Precision = 14
      Size = 2
    end
    object fdmItensSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
    object fdmItensAUTOINCREM: TIntegerField
      FieldName = 'AUTOINCREM'
    end
  end
end
