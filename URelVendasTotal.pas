unit URelVendasTotal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Vcl.Imaging.pngimage,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TFrmRelVendasTotal = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    RLImage1: TRLImage;
    FDQueryRelatorio: TFDQuery;
    DSRelatorio: TDataSource;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLBand6: TRLBand;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel6: TRLLabel;
    DBGrid1: TDBGrid;
    FDQueryRelatorioDATA: TDateField;
    FDQueryRelatorioTANQUE: TStringField;
    FDQueryRelatorioBOMBAS: TStringField;
    FDQueryRelatorioPRECO: TCurrencyField;
    RLDBResult1: TRLDBResult;
  private
    { Private declarations }
  public
    { Public declarations }
    datainicial, datafinal: string;
  end;

var
  FrmRelVendasTotal: TFrmRelVendasTotal;

implementation

Uses UDataModule;

{$R *.dfm}

end.
