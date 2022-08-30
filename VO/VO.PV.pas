unit VO.PV;

interface

uses Constant.PV;

type

  TCliente = class
  private
    FIDCLIENTE: Integer;
    FCODIGO: string;
    FNOME: string;
    FCIDADE: string;
    FUF: string;
    procedure SetIDCLIENTE(const Value: Integer);
    procedure SetCODIGO(const Value: string);
    procedure SetNOME(const Value: string);
    procedure SetCIDADE(const Value: string);
    procedure SetUF(const Value: string);
  public
    constructor Create;
    destructor Destroy;

    procedure Clear;

    property IDCLIENTE : Integer read FIDCLIENTE write SetIDCLIENTE;
    property CODIGO : string read FCODIGO write SetCODIGO;
    property NOME : string read FNOME write SetNOME;
    property CIDADE : string read FCIDADE write SetCIDADE;
    property UF : string read FUF write SetUF;
  end;

  TProduto = class
  private
    FIDPRODUTO: Integer;
    FCODIGO: string;
    FDESCRICAO: string;
    FPRECOVENDA: Double;
    FQUANTIDADE: Integer;
    FAUTOINCREM: Integer;
    procedure SetIDPRODUTO(const Value: Integer);
    procedure SetCODIGO(const Value: string);
    procedure SetDESCRICAO(const Value: string);
    procedure SetPRECOVENDA(const Value: Double);
    procedure SetQUANTIDADE(const Value: Integer);
    procedure SetAUTOINCREM(const Value: Integer);
  public
    constructor Create;
    destructor Destroy;

    procedure Clear;

    property IDPRODUTO : Integer read FIDPRODUTO write SetIDPRODUTO;
    property CODIGO : String read FCODIGO write SetCODIGO;
    property DESCRICAO : String read FDESCRICAO write SetDESCRICAO;
    property PRECOVENDA : Double read FPRECOVENDA write SetPRECOVENDA;
    property QUANTIDADE : Integer read FQUANTIDADE write SetQUANTIDADE;
    property AUTOINCREM : Integer read FAUTOINCREM write SetAUTOINCREM;
  end;

  TPedido = class
  private
    FSTATUS : Integer;
    FNUMPEDIDO : Integer;
    FVALORTOTAL: Double;

    procedure SetSTATUS(const Value: Integer);
    procedure SetNUMPEDIDO(const Value: Integer);
    procedure SetVALORTOTAL(const Value: Double);
  public
    constructor Create;
    destructor Destroy;

    procedure Clear;

    property STATUS : Integer read FSTATUS write SetSTATUS;
    property NUMPEDIDO : Integer read FNUMPEDIDO write SetNUMPEDIDO;
    property VALORTOTAL : Double read FVALORTOTAL write SetVALORTOTAL;
  end;
implementation

{ TCliente }

procedure TCliente.Clear;
begin
  IDCLIENTE := 0;
  CODIGO := '';
  NOME := '';
  CIDADE := '';
  UF := '';
end;

constructor TCliente.Create;
begin
  Clear;
end;

destructor TCliente.Destroy;
begin
end;

procedure TCliente.SetCIDADE(const Value: string);
begin
  FCIDADE := Value;
end;

procedure TCliente.SetCODIGO(const Value: string);
begin
  FCODIGO := Value;
end;

procedure TCliente.SetIDCLIENTE(const Value: Integer);
begin
  FIDCLIENTE := Value;
end;

procedure TCliente.SetNOME(const Value: string);
begin
  FNOME := Value;
end;

procedure TCliente.SetUF(const Value: string);
begin
  FUF := Value;
end;

{ TProduto }

procedure TProduto.Clear;
begin
  IDPRODUTO := 0;
  CODIGO := '';
  DESCRICAO := '';
  PRECOVENDA := 0;
  QUANTIDADE := 0;
  AUTOINCREM := 0;
end;

constructor TProduto.Create;
begin
  Clear;
end;

destructor TProduto.Destroy;
begin
end;

procedure TProduto.SetAUTOINCREM(const Value: Integer);
begin
  FAUTOINCREM := Value;
end;

procedure TProduto.SetCODIGO(const Value: string);
begin
  FCODIGO := Value;
end;

procedure TProduto.SetDESCRICAO(const Value: string);
begin
  FDESCRICAO := Value;
end;

procedure TProduto.SetIDPRODUTO(const Value: Integer);
begin
  FIDPRODUTO := Value;
end;

procedure TProduto.SetPRECOVENDA(const Value: Double);
begin
  FPRECOVENDA := Value;
end;

procedure TProduto.SetQUANTIDADE(const Value: Integer);
begin
  FQUANTIDADE := Value;
end;

{ TPedido }

procedure TPedido.Clear;
begin
  VALORTOTAL := 0;
  NUMPEDIDO := 0;
  STATUS := ST_DEFAULT;
end;

constructor TPedido.Create;
begin

end;

destructor TPedido.Destroy;
begin

end;

procedure TPedido.SetNUMPEDIDO(const Value: Integer);
begin
  FNUMPEDIDO := Value;
end;

procedure TPedido.SetSTATUS(const Value: Integer);
begin
  FSTATUS := Value;
end;

procedure TPedido.SetVALORTOTAL(const Value: Double);
begin
  FVALORTOTAL := Value;
end;

end.
