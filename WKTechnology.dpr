program WKTechnology;

uses
  Vcl.Forms,
  DataModule in 'DataModule.pas' {DM: TDataModule},
  PV in 'PV.pas' {frmPV},
  VO.PV in 'VO\VO.PV.pas',
  Constant.PV in 'Constant\Constant.PV.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPV, frmPV);
  Application.Run;
end.
