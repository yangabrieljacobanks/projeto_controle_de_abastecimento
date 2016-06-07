unit UVendaTC1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmVendaTC1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    Image2: TImage;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    BtnQuantidadeA: TSpeedButton;
    BtnPrecoA: TSpeedButton;
    Panel5: TPanel;
    Image4: TImage;
    DATETC1A: TDateTimePicker;
    Panel9: TPanel;
    Panel10: TPanel;
    EDT_QuantidadeA: TMaskEdit;
    Panel11: TPanel;
    Panel12: TPanel;
    EDT_PERCTC1A: TMaskEdit;
    Panel13: TPanel;
    EDT_PRECOTOTAL1A: TMaskEdit;
    Panel14: TPanel;
    Panel15: TPanel;
    EDT_PRECOGASOLA: TMaskEdit;
    Panel16: TPanel;
    Panel17: TPanel;
    LblPrecoTC1A: TLabel;
    TabSheet4: TTabSheet;
    BtnQuantidadeB: TSpeedButton;
    BtnPrecoB: TSpeedButton;
    Panel6: TPanel;
    Image5: TImage;
    Panel18: TPanel;
    EDT_PRECOGASOLB: TMaskEdit;
    Panel19: TPanel;
    Panel20: TPanel;
    DATETC1B: TDateTimePicker;
    Panel21: TPanel;
    EDT_QuantidadeB: TMaskEdit;
    Panel22: TPanel;
    Panel23: TPanel;
    EDT_PERCTC1B: TMaskEdit;
    Panel24: TPanel;
    EDT_PRECOTOTAL1B: TMaskEdit;
    Panel25: TPanel;
    Panel26: TPanel;
    LblPrecoTC1B: TLabel;
    Btn_GravaTC1A: TSpeedButton;
    FDQueryAux: TFDQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    EDT_VALOR_IMPTCA: TMaskEdit;
    Panel4: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    EDT_VALOR_IMPTCB: TMaskEdit;
    Panel27: TPanel;
    Btn_GravaTC1B: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnQuantidadeAClick(Sender: TObject);
    procedure BtnPrecoAClick(Sender: TObject);
    procedure Btn_GravaTC1AClick(Sender: TObject);
    procedure Btn_GravaTC1BClick(Sender: TObject);
    procedure BtnQuantidadeBClick(Sender: TObject);
    procedure BtnPrecoBClick(Sender: TObject);
  private
    { Private declarations }
    procedure FechaeLimparQueryAux;
    procedure AbreQueryAux;
    procedure CalculaPrecoVersusQuantidadeA;
    procedure CalculaPrecoVersusQuantidadeB;
  public
    { Public declarations }
  end;

var
  FrmVendaTC1: TFrmVendaTC1;

implementation

Uses UDataModule;

{$R *.dfm}

procedure TFrmVendaTC1.BtnQuantidadeAClick(Sender: TObject);
begin
  // Calcula o Preço conforme a quantidade da gasolina
  CalculaPrecoVersusQuantidadeA;
end;

procedure TFrmVendaTC1.BtnQuantidadeBClick(Sender: TObject);
begin
  // Calcula o Preço conforme a quantidade da gasolina
  CalculaPrecoVersusQuantidadeB;
end;

procedure TFrmVendaTC1.Btn_GravaTC1AClick(Sender: TObject);
begin
 // Grava a Venda no Banco de Dados
  LblPrecoTC1A.Caption:= 'Preço: R$ '+ EDT_PRECOTOTAL1A.Text;
  FechaeLimparQueryAux;
  FDQueryAux.SQL.Text:= 'INSERT INTO TB_VENDATC1 '+
              ' (PRECO, DATA, QUANTIDADE, PRECO_VENDA, PERCENTUAL_IMPOSTO, BOMBA_GASOL, VALOR_IMPOSTO) '+
  ' VALUES '  +
              ' ('+StringReplace(EDT_PRECOGASOLA.Text,',','.', [rfReplaceAll])+','+
              #39+FormatDateTime('YYYY-MM-DD', DATETC1A.DateTime)+#39+', '+StringReplace(EDT_QuantidadeA.Text,',','.', [rfReplaceAll])+', '+
              StringReplace(EDT_PRECOTOTAL1A.Text,',','.', [rfReplaceAll])+', '+
              StringReplace(EDT_PERCTC1A.Text,',','.', [rfReplaceAll])+', '+
              '1, '+StringReplace(EDT_VALOR_IMPTCA.Text,',','.', [rfReplaceAll])+')';
  FDQueryAux.ExecSQL;
  ShowMessage('Venda de Gasolina efetuada com sucesso!!!');
end;

procedure TFrmVendaTC1.Btn_GravaTC1BClick(Sender: TObject);
begin
 // Grava a Venda no Banco de Dados
  LblPrecoTC1B.Caption:= 'Preço: R$ '+ EDT_PRECOTOTAL1B.Text;
  FechaeLimparQueryAux;
  FDQueryAux.SQL.Text:= 'INSERT INTO TB_VENDATC1 '+
              ' (PRECO, DATA, QUANTIDADE, PRECO_VENDA, PERCENTUAL_IMPOSTO, BOMBA_GASOL, VALOR_IMPOSTO) '+
  ' VALUES '  +
              ' ('+StringReplace(EDT_PRECOGASOLB.Text,',','.', [rfReplaceAll])+','+
              #39+FormatDateTime('YYYY-MM-DD', DATETC1B.DateTime)+#39+', '+StringReplace(EDT_QuantidadeB.Text,',','.', [rfReplaceAll])+', '+
              StringReplace(EDT_PRECOTOTAL1B.Text,',','.', [rfReplaceAll])+', '+
              StringReplace(EDT_PERCTC1B.Text,',','.', [rfReplaceAll])+', '+
              '2, '+StringReplace(EDT_VALOR_IMPTCB.Text,',','.', [rfReplaceAll])+')';
  FDQueryAux.ExecSQL;
  ShowMessage('Venda de Gasolina efetuada com sucesso!!!');
end;

procedure TFrmVendaTC1.CalculaPrecoVersusQuantidadeA;
var
   preco, vlr_imposto: real;
begin
  preco:= 0;
  vlr_imposto:= 0;
  // Valor Total da Gasolina
  preco:= StrToFloat(EDT_PRECOGASOLA.Text)*StrToFloat(EDT_QuantidadeA.Text);
  EDT_PRECOTOTAL1A.Text:= FloatToStr(preco);
  // Valor do Imposto
  vlr_imposto:= (StrToFloat(EDT_PERCTC1A.Text)/100) * StrToFloat(EDT_PRECOTOTAL1A.Text);
  EDT_VALOR_IMPTCA.Text:= FloatToStr(vlr_imposto);
end;

procedure TFrmVendaTC1.CalculaPrecoVersusQuantidadeB;
var
   preco, vlr_imposto: real;
begin
  preco:= 0;
  vlr_imposto:= 0;
  // Valor Total da Gasolina
  preco:= StrToFloat(EDT_PRECOGASOLB.Text)*StrToFloat(EDT_QuantidadeB.Text);
  EDT_PRECOTOTAL1B.Text:= FloatToStr(preco);
  // Valor do Imposto
  vlr_imposto:= (StrToFloat(EDT_PERCTC1B.Text)/100) * StrToFloat(EDT_PRECOTOTAL1B.Text);
  EDT_VALOR_IMPTCB.Text:= FloatToStr(vlr_imposto);
end;

procedure TFrmVendaTC1.FechaeLimparQueryAux;
begin
  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
end;

procedure TFrmVendaTC1.FormCreate(Sender: TObject);
begin
  // Pega o valor da Gasolina cadastrado no sistema
  FechaeLimparQueryAux;
  FDQueryAux.SQL.Text:= 'SELECT PRECO FROM TB_PRECOGASOL';
  AbreQueryAux;
  if FDQueryAux.RecordCount > 0 then
  begin
    EDT_PRECOGASOLA.EditText:= FDQueryAux.FieldByName('PRECO').AsString;
    EDT_PRECOGASOLB.EditText:= FDQueryAux.FieldByName('PRECO').AsString;
  end;
  FechaeLimparQueryAux;
  FDQueryAux.SQL.Text:= 'SELECT PERCENTUAL FROM TB_PERCIMPOSTO ';
  AbreQueryAux;
  if FDQueryAux.RecordCount > 0 then
  begin
    EDT_PERCTC1A.EditText:= FDQueryAux.FieldByName('PERCENTUAL').AsString;
    EDT_PERCTC1B.EditText:= FDQueryAux.FieldByName('PERCENTUAL').AsString;
  end;
  FechaeLimparQueryAux;
  // Seta a data para HOJE
  DATETC1A.Date:= Now;
  DATETC1B.Date:= Now;
end;

procedure TFrmVendaTC1.AbreQueryAux;
begin
  FDQueryAux.Open;
  FDQueryAux.Last;
  FDQueryAux.First;
end;

procedure TFrmVendaTC1.BtnPrecoAClick(Sender: TObject);
var
   quantidade, vlr_imposto: real;
begin
  quantidade:= 0;
  vlr_imposto:= 0;
  // Calcula a quantidade de Litros com base no valor que o cliente pede em R$ para abastecer
  quantidade:= StrToFloat(EDT_PRECOTOTAL1A.Text)/StrToFloat(EDT_PRECOGASOLA.Text);
  EDT_QuantidadeA.Text:= FloatToStr(quantidade);
  // Valor do Imposto
  vlr_imposto:= (StrToFloat(EDT_PERCTC1A.Text)/100) * StrToFloat(EDT_PRECOTOTAL1A.Text);
  EDT_VALOR_IMPTCA.Text:= FloatToStr(vlr_imposto);
end;

procedure TFrmVendaTC1.BtnPrecoBClick(Sender: TObject);
var
   quantidade, vlr_imposto: real;
begin
  quantidade:= 0;
  vlr_imposto:= 0;
  // Calcula a quantidade de Litros com base no valor que o cliente pede em R$ para abastecer
  quantidade:= StrToFloat(EDT_PRECOTOTAL1B.Text)/StrToFloat(EDT_PRECOGASOLB.Text);
  EDT_QuantidadeB.Text:= FloatToStr(quantidade);
  // Valor do Imposto
  vlr_imposto:= (StrToFloat(EDT_PERCTC1B.Text)/100) * StrToFloat(EDT_PRECOTOTAL1B.Text);
  EDT_VALOR_IMPTCB.Text:= FloatToStr(vlr_imposto);
end;

end.
