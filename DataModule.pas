unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.MySQL, FireDAC.Comp.UI, VO.PV;

type
  TDM = class(TDataModule)
    fdConn: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    fdqCliente: TFDQuery;
    fdqProduto: TFDQuery;
    fdqProdutoIDPRODUTO: TFDAutoIncField;
    fdqProdutoCODIGO: TStringField;
    fdqProdutoDESCRICAO: TStringField;
    fdqProdutoPRECOVENDA: TBCDField;
    fdqClienteIDCLIENTE: TFDAutoIncField;
    fdqClienteCODIGO: TStringField;
    fdqClienteNOME: TStringField;
    fdqClienteCIDADE: TStringField;
    fdqClienteUF: TStringField;
    fdqPedido: TFDQuery;
    fdqPedidoItem: TFDQuery;
    fdqPedidoNUMPEDIDO: TFDAutoIncField;
    fdqPedidoEMISSAO: TDateTimeField;
    fdqPedidoIDCLIENTE: TIntegerField;
    fdqPedidoVALORTOTAL: TBCDField;
    fdqPedidoItemAUTOINCREM: TFDAutoIncField;
    fdqPedidoItemNUMPEDIDO: TIntegerField;
    fdqPedidoItemIDPRODUTO: TIntegerField;
    fdqPedidoItemQUANTIDADE: TIntegerField;
    fdqPedidoItemVALORUNIT: TBCDField;
    fdqPedidoItemVALORTOTAL: TBCDField;
    fdmItens: TFDMemTable;
    fdmItensIDPRODUTO: TFDAutoIncField;
    fdmItensDESCRICAO: TStringField;
    fdmItensQUANTIDADE: TIntegerField;
    fdmItensVALORUNIT: TBCDField;
    fdmItensVALORTOTAL: TBCDField;
    fdmItensSTATUS: TIntegerField;
    fdqClienteVALORTOTAL: TFloatField;
    fdmItensAUTOINCREM: TIntegerField;
    fdqPedidoItemCODIGO: TStringField;
    fdqPedidoItemDESCRICAO: TStringField;
    fdqPedidoItemPRECOVENDA: TBCDField;
    fdqPedidoCODIGO: TStringField;
    fdqPedidoNOME: TStringField;
    fdqPedidoCIDADE: TStringField;
    fdqPedidoUF: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure fdmItensBeforePost(DataSet: TDataSet);
    procedure fdmItensAfterClose(DataSet: TDataSet);
    procedure fdqPedidoAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }

  public
    { Public declarations }
    Pedido : TPedido;
  end;

var
  DM: TDM;

implementation

uses Winapi.Windows,Forms, Constant.PV;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  try
    fdConn.Connected := True;
  except
    on e: Exception do
    begin
      Application.MessageBox(PWideChar('Desculpe-me mas, não foi possível conectar-se ao banco de dados.'+#13+#10+
      e.Message),'Erro',MB_ICONERROR+MB_OK);

      Exit;
    end;
  end;

  fdqCliente.Open;
  fdqProduto.Open;
  fdmItens.CreateDataSet;

  Pedido := TPedido.Create;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  if fdqCliente.Active then
    fdqCliente.Close;

  if fdqProduto.Active then
    fdqProduto.Close;

  if fdmItens.Active then
    fdmItens.Close;

  fdConn.Connected := False;
end;

procedure TDM.fdmItensAfterClose(DataSet: TDataSet);
begin
  Pedido.Clear;
end;

procedure TDM.fdmItensBeforePost(DataSet: TDataSet);
begin
  fdmItensVALORTOTAL.AsFloat := (fdmItensQUANTIDADE.AsInteger * fdmItensVALORUNIT.AsFloat);

  if fdmItensSTATUS.AsInteger <> ST_DELETE then
    Pedido.VALORTOTAL := Pedido.VALORTOTAL + fdmItensVALORTOTAL.AsFloat;

  if fdmItensSTATUS.AsInteger = ST_DEFAULT then
    fdmItensSTATUS.AsInteger := ST_UPDATE;
end;

procedure TDM.fdqPedidoAfterOpen(DataSet: TDataSet);
begin
  fdqPedidoItem.Close;
  fdqPedidoItem.Params.ParamByName('NUMPEDIDO').AsInteger := fdqPedidoNUMPEDIDO.AsInteger;
  fdqPedidoItem.Open;
end;

end.
