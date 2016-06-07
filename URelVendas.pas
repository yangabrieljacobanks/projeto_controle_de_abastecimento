unit URelVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls, ClipBrd, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RLReport;

type
  TFrmRelVendas = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Panel30: TPanel;
    DTINICIAL: TDateTimePicker;
    Label1: TLabel;
    DTFINAL: TDateTimePicker;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelVendas: TFrmRelVendas;

implementation

Uses URelVendasTotal;

{$R *.dfm}

procedure TFrmRelVendas.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmRelVendasTotal, frmRelVendasTotal);
  FrmRelVendasTotal.FDQueryRelatorio.ParamByName('datainicial').AsDate:= DTINICIAL.Date;
  FrmRelVendasTotal.FDQueryRelatorio.ParamByName('datafinal').AsDate:= DTFINAL.Date;
  FrmRelVendasTotal.FDQueryRelatorio.Open;
  FrmRelVendasTotal.FDQueryRelatorio.Last;
  FrmRelVendasTotal.FDQueryRelatorio.First;
  FrmRelVendasTotal.RLReport1.Preview;
end;

end.
