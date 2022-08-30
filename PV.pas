unit PV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.DBLookup,
  VO.PV, FireDAC.Comp.Client;

type
  TfrmPV = class(TForm)
    pnlTop: TPanel;
    pnlClient: TPanel;
    sbPV: TStatusBar;
    edCliente: TEdit;
    lblCliente: TLabel;
    GroupBox1: TGroupBox;
    lblProduto: TLabel;
    edProduto: TEdit;
    lblQuantidade: TLabel;
    edQuantidade: TEdit;
    lblValor: TLabel;
    edValor: TEdit;
    dbgProduto: TDBGrid;
    btnGravar: TBitBtn;
    BtnSair: TBitBtn;
    dsItens: TDataSource;
    btnAddItens: TBitBtn;
    btnCarregar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure edClienteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbgProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edQuantidadeExit(Sender: TObject);
    procedure edValorExit(Sender: TObject);
    procedure btnAddItensClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure dsItensDataChange(Sender: TObject; Field: TField);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    Cliente: TCliente;
    Produto: TProduto;

    procedure HabiitaBotoes;
    procedure ClearObjCliente(Sender: TObject);
    procedure ClearObjProduto(Sender: TObject);
    procedure PreencherObjCliente(fdqTemp:TFDQuery);
    procedure PreencherObjProduto(fdqTemp:TFDQuery;Qtde:Integer=0);
    procedure KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState; fdqTemp:TFDQuery);
    procedure Refrash;
    function InputPedido: Boolean;
    procedure AddProduto(Status: integer);
  public
    { Public declarations }
  end;

var
  frmPV: TfrmPV;

implementation

uses DataModule, Constant.PV;

{$R *.dfm}

procedure TfrmPV.AddProduto(Status: integer);
begin
  DM.fdmItens.Insert;
  DM.fdmItensIDPRODUTO.AsInteger := Produto.IDPRODUTO;
  DM.fdmItensDESCRICAO.AsString := Produto.DESCRICAO;
  DM.fdmItensQUANTIDADE.AsInteger := Produto.QUANTIDADE;
  DM.fdmItensVALORUNIT.AsFloat := Produto.PRECOVENDA;
  DM.fdmItensSTATUS.AsInteger := Status;
  DM.fdmItensAUTOINCREM.AsInteger := Produto.AUTOINCREM;
  DM.fdmItens.Post;
end;

procedure TfrmPV.btnAddItensClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;

    AddProduto(ST_NEW);

    ClearObjProduto(nil);
    HabiitaBotoes;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPV.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPV.btnCancelarClick(Sender: TObject);
begin
  if InputPedido = False then
    Exit;

  try
    Screen.Cursor := crHourGlass;
    try
      DM.fdConn.StartTransaction;

      DM.fdConn.ExecSQL(SQL_DELETE_PEDIDO,[DM.fdqPedidoNUMPEDIDO.AsInteger]);
      DM.fdConn.Commit;

      Application.MessageBox(PChar('Pedido '+IntToStr(DM.fdqPedidoNUMPEDIDO.AsInteger)+
        ' excluído com sucesso.'), 'Informação', MB_OK + MB_ICONINFORMATION);

      Refrash;
    except
      on e:Exception do
      begin
        DM.fdConn.Rollback;
        Application.MessageBox(PChar('Erro ao excluir pedido. Tente novamente.'+#13+#10+
          e.Message), 'Erro', MB_OK + MB_ICONERROR);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPV.btnCarregarClick(Sender: TObject);
begin
  if InputPedido = False then
    Exit;

  Refrash;

  try
    Screen.Cursor := crHourGlass;
    DM.fdmItens.DisableControls;

    PreencherObjCliente(DM.fdqPedido);
    DM.Pedido.NUMPEDIDO := DM.fdqPedidoNUMPEDIDO.AsInteger;
    DM.Pedido.STATUS := ST_UPDATE;

    while not DM.fdqPedidoItem.Eof do
    begin
      PreencherObjProduto(DM.fdqPedidoItem, DM.fdqPedidoItemQUANTIDADE.AsInteger);
      AddProduto(ST_DEFAULT);
      ClearObjProduto(nil);
      DM.fdqPedidoItem.Next;
    end;
  finally
    DM.fdmItens.EnableControls;
    Screen.Cursor := crDefault;
    HabiitaBotoes;
  end;
end;

procedure TfrmPV.btnGravarClick(Sender: TObject);
var nNumPedido: Integer;
begin
  try
    Screen.Cursor := crHourGlass;
    DM.fdmItens.DisableControls;
    DM.fdmItens.Filtered := False;
    try
      DM.fdConn.StartTransaction;

      if DM.Pedido.STATUS <> ST_UPDATE then
      begin
        nNumPedido := DM.fdConn.ExecSQLScalar(SQL_INSERT_PEDIDO,[Cliente.IDCLIENTE,
          DM.Pedido.VALORTOTAL]);
      end
      else
      begin
        nNumPedido := DM.Pedido.NUMPEDIDO;

        DM.fdConn.ExecSQL(SQL_UPDATE_PEDIDO,[Cliente.IDCLIENTE,
          DM.Pedido.VALORTOTAL,DM.Pedido.NUMPEDIDO]);
      end;

      DM.fdmItens.First;
      while not DM.fdmItens.Eof do
      begin

        case DM.fdmItensSTATUS.AsInteger of
          ST_NEW:
          begin
            DM.fdConn.ExecSQL( SQL_INSERT_PEDIDOITEM,[nNumPedido,
              DM.fdmItensIDPRODUTO.AsInteger,DM.fdmItensQUANTIDADE.AsInteger,
              DM.fdmItensVALORUNIT.AsFloat,DM.fdmItensVALORTOTAL.AsFloat]);
          end;
          ST_UPDATE:
          begin
            DM.fdConn.ExecSQL( SQL_UPDATE_PEDIDOITEM,[DM.fdmItensQUANTIDADE.AsInteger,
              DM.fdmItensVALORUNIT.AsFloat,DM.fdmItensVALORTOTAL.AsFloat,
              DM.fdmItensAUTOINCREM.AsInteger]);
          end;
          ST_DELETE:
          begin
            if DM.fdmItensAUTOINCREM.AsInteger > 0 then
              DM.fdConn.ExecSQL( SQL_DELETE_PEDIDOITEM,[DM.fdmItensAUTOINCREM.AsInteger]);
          end;
        end;

        DM.fdmItens.Next;
      end;

      DM.fdConn.Commit;

      Application.MessageBox(PChar('Pedido '+IntToStr(nNumPedido)+' salvo com sucesso.'),
        'Informação', MB_OK + MB_ICONINFORMATION);

      Refrash;
    except
      on e:Exception do
      begin
        DM.fdConn.Rollback;
        Application.MessageBox(PChar('Erro ao gravar pedido. Tente novamente.'+#13+#10+
        e.Message), 'Erro', MB_OK + MB_ICONERROR);
      end;
    end;
  finally
    DM.fdmItens.Filtered := True;
    DM.fdmItens.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPV.ClearObjCliente(Sender: TObject);
begin
  Cliente.Clear;

  if Sender = nil then
    edCliente.Clear;
end;

procedure TfrmPV.ClearObjProduto(Sender: TObject);
begin
  Produto.Clear;
  edQuantidade.Clear;
  edValor.Clear;

  if Sender = nil then
    edProduto.Clear;
end;

procedure TfrmPV.dbgProdutoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var h: THandle;
begin
 if DM.fdmItens.IsEmpty then
    Exit;

  case Key of
    VK_RETURN :
    begin
      DM.fdmItens.Edit;
    end;
    VK_DELETE :
    begin
      if Application.MessageBox(PChar('Deseja realmente deletar o produto "'+DM.fdmItensDESCRICAO.AsString+'" ?'), 'Pergunta', MB_YESNO +
        MB_ICONQUESTION + MB_DEFBUTTON1) = IDYES then
      begin
        DM.fdmItens.Edit;
        DM.fdmItensSTATUS.AsInteger := ST_DELETE;
        DM.fdmItens.Post;
      end;
    end;
  end;
end;

procedure TfrmPV.dsItensDataChange(Sender: TObject; Field: TField);
begin
  dbgProduto.ReadOnly := not (DM.fdmItens.State = dsEdit);
  HabiitaBotoes;

  sbPV.Panels[0].Text := 'Quantidade de Registros: '+ IntToStr( DM.fdmItens.RecordCount );
  sbPV.Panels[1].Text := 'Valor Total dos Produtos: '+ FloatToStr( DM.Pedido.VALORTOTAL );
end;

procedure TfrmPV.edClienteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key = VK_BACK) and (TEdit(Sender).Text <> '')) then
    Exit;

  if TEdit(Sender) = edCliente then
    KeyUp(Sender, Key, Shift, DM.fdqCliente)
  else
    KeyUp(Sender, Key, Shift, DM.fdqProduto);
end;

procedure TfrmPV.edQuantidadeExit(Sender: TObject);
begin
  Produto.QUANTIDADE := StrToIntDef( edQuantidade.Text,1);
end;

procedure TfrmPV.edValorExit(Sender: TObject);
begin
  Produto.PRECOVENDA := StrToFloatDef( edValor.Text,0);
end;

procedure TfrmPV.FormCreate(Sender: TObject);
begin
  Cliente := TCliente.Create;
  Produto := TProduto.Create;
end;

procedure TfrmPV.HabiitaBotoes;
begin
  if not (Assigned( Cliente ) and Assigned( Produto )) then
    Exit;

  btnGravar.Enabled := ((Cliente.IDCLIENTE > 0) and ( DM.fdmItens.RecordCount > 0));
  btnAddItens.Enabled := ( Produto.IDPRODUTO > 0);
  btnCarregar.Enabled := (Cliente.IDCLIENTE = 0) ;
  btnCancelar.Enabled := (Cliente.IDCLIENTE = 0) ;
end;

function TfrmPV.InputPedido: Boolean;
var cPedido: string;
begin
  Result := False;

  InputQuery('Informe o número do Pedido','Pedido', cPedido);

  if Trim(cPedido) = '' then
  begin
    Application.MessageBox(PChar('Nenhum número de pedido foi informado.'), 'Informação', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  DM.fdqPedido.Close;
  DM.fdqPedido.Params.ParamByName('NUMPEDIDO').AsInteger := StrToIntDef( cPedido, 0);
  DM.fdqPedido.Open;

  if DM.fdqPedido.IsEmpty then
  begin
    Application.MessageBox(PChar('Nenhum pedido encontrado.'), 'Informação', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  Result := True;
end;

procedure TfrmPV.KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState;
  fdqTemp: TFDQuery);
var
  i : Integer;
  Start : Integer;
  CampoPesquisa: string;
begin
  if TEdit(Sender) = edCliente then
  begin
    ClearObjCliente(Sender);
    CampoPesquisa := 'NOME';
  end
  else
  begin
    ClearObjProduto(Sender);
    CampoPesquisa := 'DESCRICAO';
  end;

  if Trim(TEdit(Sender).Text) <> '' then
  begin
    if fdqTemp.Locate(CampoPesquisa,TEdit(Sender).Text,[loCaseInsensitive, loPartialKey]) then
    begin
      Start := Length(TEdit(Sender).Text);

      for i := Length(TEdit(Sender).Text) + 1 to Length( fdqTemp.FieldByName(CampoPesquisa).AsString) do
        TEdit(Sender).Text := TEdit(Sender).Text + fdqTemp.FieldByName(CampoPesquisa).AsString[i];

      TEdit(Sender).SelStart := Start;
      TEdit(Sender).SelLength := Length(TEdit(Sender).Text);

      if TEdit(Sender) = edCliente then
        PreencherObjCliente(DM.fdqCliente)
      else
        PreencherObjProduto(DM.fdqProduto);
    end;
  end;

  HabiitaBotoes;
end;

procedure TfrmPV.PreencherObjCliente(fdqTemp:TFDQuery);
begin
  Cliente.IDCLIENTE := fdqTemp.FieldByName('IDCLIENTE').AsInteger;
  Cliente.CODIGO := fdqTemp.FieldByName('CODIGO').AsString;
  Cliente.NOME := fdqTemp.FieldByName('NOME').AsString;
  Cliente.CIDADE := fdqTemp.FieldByName('CIDADE').AsString;
  Cliente.UF := fdqTemp.FieldByName('UF').AsString;

  if Cliente.NOME <> '' then
    edCliente.Text := Cliente.NOME;
end;

procedure TfrmPV.PreencherObjProduto(fdqTemp:TFDQuery; Qtde:Integer=0);
begin
  Produto.IDPRODUTO := fdqTemp.FieldByName('IDPRODUTO').AsInteger;
  Produto.CODIGO := fdqTemp.FieldByName('CODIGO').AsString;
  Produto.DESCRICAO := fdqTemp.FieldByName('DESCRICAO').AsString;
  Produto.PRECOVENDA := fdqTemp.FieldByName('PRECOVENDA').AsFloat;

  if Qtde = 0 then
  begin
    Produto.QUANTIDADE := StrToIntDef( edQuantidade.Text,1);

    if StrToIntDef( edQuantidade.Text, 0) < 1 then
    edQuantidade.Text := '1';

  if Trim(edValor.Text) = '' then
    edValor.Text := FloatToStr( Produto.PRECOVENDA);
  end
  else
  begin
    Produto.QUANTIDADE := Qtde;
    Produto.AUTOINCREM := fdqTemp.FieldByName('AUTOINCREM').AsInteger;
  end;
end;

procedure TfrmPV.Refrash;
begin
  DM.fdmItens.Close;
  DM.fdmItens.Open;
  ClearObjCliente(nil);
  ClearObjProduto(nil);
  HabiitaBotoes;
end;

end.
