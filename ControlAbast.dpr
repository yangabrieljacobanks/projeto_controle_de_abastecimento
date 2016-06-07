program ControlAbast;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FrmMain},
  UCadasGasOle in 'UCadasGasOle.pas' {FrmCadasGasOle},
  UCadasImp in 'UCadasImp.pas' {FrmCadasImp},
  UDataModule in 'UDataModule.pas' {DataModule1: TDataModule},
  UVendaTC1 in 'UVendaTC1.pas' {FrmVendaTC1},
  UVendaTC2 in 'UVendaTC2.pas' {FrmVendaTC2},
  URelVendas in 'URelVendas.pas' {FrmRelVendas},
  URelVendasTotal in 'URelVendasTotal.pas' {FrmRelVendasTotal},
  USobre in 'USobre.pas' {FrmSobre};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrmSobre, FrmSobre);
  Application.Run;
end.
