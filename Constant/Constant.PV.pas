unit Constant.PV;

interface

const

  ST_DEFAULT = 0;
  ST_NEW = 1;
  ST_DELETE = 2;
  ST_UPDATE = 3;

  SQL_INSERT_PEDIDO :string =
    ' INSERT INTO PEDIDO (IDCLIENTE, VALORTOTAL)'+
    ' VALUES( :IDCLIENTE, :VALORTOTAL );'+
    ' SELECT LAST_INSERT_ID() NUMPEDIDO;';

  SQL_UPDATE_PEDIDO :string =
    ' UPDATE PEDIDO SET IDCLIENTE = :IDCLIENTE, VALORTOTAL= :VALORTOTAL'+
    ' WHERE NUMPEDIDO = :NUMPEDIDO;';

  SQL_DELETE_PEDIDO :string =
    ' DELETE FROM PEDIDO'+
    ' WHERE NUMPEDIDO = :NUMPEDIDO;';

  SQL_INSERT_PEDIDOITEM :string =
    ' INSERT INTO PEDIDOITEM (NUMPEDIDO,IDPRODUTO, QUANTIDADE, VALORUNIT, VALORTOTAL)'+
    ' VALUES( :NUMPEDIDO, :IDPRODUTO, :QUANTIDADE, :VALORUNIT, :VALORTOTAL );';

  SQL_UPDATE_PEDIDOITEM :string =
    ' UPDATE PEDIDOITEM SET QUANTIDADE=:QUANTIDADE, VALORUNIT=:VALORUNIT, VALORTOTAL=:VALORTOTAL'+
    ' WHERE AUTOINCREM = :AUTOINCREM;';

  SQL_DELETE_PEDIDOITEM :string =
    ' DELETE FROM PEDIDOITEM'+
    ' WHERE AUTOINCREM = :AUTOINCREM;';

implementation

end.