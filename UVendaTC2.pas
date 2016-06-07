unit UVendaTC2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmVendaTC2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    Panel4: TPanel;
    Image3: TImage;
    PageControl3: TPageControl;
    TabSheet5: TTabSheet;
    BtnQuantidadeA: TSpeedButton;
    BtnPrecoA: TSpeedButton;
    Panel7: TPanel;
    Image6: TImage;
    DATETC2A: TDateTimePicker;
    Panel27: TPanel;
    Panel28: TPanel;
    EDT_QuantidadeA: TMaskEdit;
    Panel29: TPanel;
    Panel30: TPanel;
    EDT_PERCTC2A: TMaskEdit;
    Panel31: TPanel;
    EDT_PRECOTOTAL2A: TMaskEdit;
    Panel32: TPanel;
    Panel33: TPanel;
    EDT_PRECOOLEOA: TMaskEdit;
    Panel34: TPanel;
    Panel35: TPanel;
    LblPrecoTC2A: TLabel;
    TabSheet6: TTabSheet;
    BtnQuantidadeB: TSpeedButton;
    BtnPrecoB: TSpeedButton;
    Panel8: TPanel;
    Image7: TImage;
    DATETC2B: TDateTimePicker;
    Panel36: TPanel;
    Panel37: TPanel;
    EDT_QuantidadeB: TMaskEdit;
    Panel38: TPanel;
    Panel39: TPanel;
    EDT_PERCTC2B: TMaskEdit;
    Panel40: TPanel;
    EDT_PRECOTOTAL2B: TMaskEdit;
    Panel41: TPanel;
    Panel42: TPanel;
    EDT_PRECOOLEOB: TMaskEdit;
    Panel43: TPanel;
    Panel44: TPanel;
    LblPrecoTC2B: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    EDT_VALOR_IMPTCA: TMaskEdit;
    Panel3: TPanel;
    Btn_GravaTC1A: TSpeedButton;
    Panel5: TPanel;
    EDT_VALOR_IMPTCB: TMaskEdit;
    Panel6: TPanel;
    SpeedButton1: TSpeedButton;
    Panel9: TPanel;
    FDQueryAux: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure BtnQuantidadeAClick(Sender: TObject);
    procedure BtnQuantidadeBClick(Sender: TObject);
    procedure BtnPrecoAClick(Sender: TObject);
    procedure BtnPrecoBClick(Sender: TObject);
    procedure Btn_GravaTC1AClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
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
  FrmVendaTC2: TFrmVendaTC2;

implementation

Uses UDataModule;

{$R *.dfm}

procedure TFrmVendaTC2.AbreQueryAux;
begin
  FDQueryAux.Open;
  FDQueryAux.Last;
  FDQueryAux.First;
end;

procedure TFrmVendaTC2.BtnPrecoAClick(Sender: TObject);
var
   quantidade, vlr_imposto: real;
begin
  quantidade:= 0;
  vlr_imposto:= 0;
  // Calcula a quantidade de Litros com base no valor que o cliente pede em R$ para abastecer
  quantidade:= StrToFloat(EDT_PRECOTOTAL2A.Text)/StrToFloat(EDT_PRECOOLEOA.Text);
  EDT_QuantidadeA.Text:= FloatToStr(quantidade);
  // Valor do Imposto
  vlr_imposto:= (StrToFloat(EDT_PERCTC2A.Text)/100) * StrToFloat(EDT_PRECOTOTAL2A.Text);
  EDT_VALOR_IMPTCA.Text:= FloatToStr(vlr_imposto);
end;

procedure TFrmVendaTC2.BtnPrecoBClick(Sender: TObject);
var
   quantidade, vlr_imposto: real;
begin
  quantidade:= 0;
  vlr_imposto:= 0;
  // Calcula a quantidade de Litros com base no valor que o cliente pede em R$ para abastecer
  quantidade:= StrToFloat(EDT_PRECOTOTAL2B.Text)/StrToFloat(EDT_PRECOOLEOB.Text);
  EDT_QuantidadeB.Text:= FloatToStr(quantidade);
  // Valor do Imposto
  vlr_imposto:= (StrToFloat(EDT_PERCTC2B.Text)/100) * StrToFloat(EDT_PRECOTOTAL2B.Text);
  EDT_VALOR_IMPTCB.Text:= FloatToStr(vlr_imposto);
end;

procedure TFrmVendaTC2.BtnQuantidadeAClick(Sender: TObject);
begin
  // Calcula o Preço conforme a quantidade do Oleo
  CalculaPrecoVersusQuantidadeA;
end;

procedure TFrmVendaTC2.BtnQuantidadeBClick(Sender: TObject);
begin
  // Calcula o Preço conforme a quantidade da gasolina
  CalculaPrecoVersusQuantidadeB;
end;

procedure TFrmVendaTC2.Btn_GravaTC1AClick(Sender: TObject);
begin
 // Grava a Venda no Banco de Dados
  LblPrecoTC2A.Caption:= 'Preço: R$ '+ EDT_PRECOTOTAL2A.Text;
  FechaeLimparQueryAux;
  FDQueryAux.SQL.Text:= 'INSERT INTO TB_VENDATC2 '+
              ' (PRECO, DATA, QUANTIDADE, PRECO_VENDA, PERCENTUAL_IMPOSTO, BOMBA_OLEO, VALOR_IMPOSTO) '+
  ' VALUES '  +
              ' ('+StringReplace(EDT_PRECOOLEOA.Text,',','.', [rfReplaceAll])+','+
              #39+FormatDateTime('YYYY-MM-DD', DATETC2A.DateTime)+#39+', '+StringReplace(EDT_QuantidadeA.Text,',','.', [rfReplaceAll])+', '+
              StringReplace(EDT_PRECOTOTAL2A.Text,',','.', [rfReplaceAll])+', '+
              StringReplace(EDT_PERCTC2A.Text,',','.', [rfReplaceAll])+', '+
              '1, '+StringReplace(EDT_VALOR_IMPTCA.Text,',','.', [rfReplaceAll])+')';
  FDQueryAux.ExecSQL;
  ShowMessage('Venda de Óleo efetuada com sucesso!!!');
end;

procedure TFrmVendaTC2.CalculaPrecoVersusQuantidadeA;
var
   preco, vlr_imposto: real;
begin
  preco:= 0;
  vlr_imposto:= 0;
  // Valor Total da Gasolina
  preco:= StrToFloat(EDT_PRECOOLEOA.Text)*StrToFloat(EDT_QuantidadeA.Text);
  EDT_PRECOTOTAL2A.Text:= FloatToStr(preco);
  // Valor do Imposto
  vlr_imposto:= (StrToFloat(EDT_PERCTC2A.Text)/100) * StrToFloat(EDT_PRECOTOTAL2A.Text);
  EDT_VALOR_IMPTCA.Text:= FloatToStr(vlr_imposto);
end;

procedure TFrmVendaTC2.CalculaPrecoVersusQuantidadeB;
var
   preco, vlr_imposto: real;
begin
  preco:= 0;
  vlr_imposto:= 0;
  // Valor Total da Gasolina
  preco:= StrToFloat(EDT_PRECOOLEOB.Text)*StrToFloat(EDT_QuantidadeB.Text);
  EDT_PRECOTOTAL2B.Text:= FloatToStr(preco);
  // Valor do Imposto
  vlr_imposto:= (StrToFloat(EDT_PERCTC2B.Text)/100) * StrToFloat(EDT_PRECOTOTAL2B.Text);
  EDT_VALOR_IMPTCB.Text:= FloatToStr(vlr_imposto);
end;

procedure TFrmVendaTC2.FechaeLimparQueryAux;
begin
  FDQueryAux.Close;
  FDQueryAux.SQL.Clear;
end;

procedure TFrmVendaTC2.FormCreate(Sender: TObject);
begin
  // Pega o valor do Oleo cadastrado no sistema
  FechaeLimparQueryAux;
  FDQueryAux.SQL.Text:= 'SELECT PRECO FROM TB_PRECOOLEO';
  AbreQueryAux;
  if FDQueryAux.RecordCount > 0 then
  begin
    EDT_PRECOOLEOA.EditText:= FDQueryAux.FieldByName('PRECO').AsString;
    EDT_PRECOOLEOB.EditText:= FDQueryAux.FieldByName('PRECO').AsString;
  end;
  FechaeLimparQueryAux;
  FDQueryAux.SQL.Text:= 'SELECT PERCENTUAL FROM TB_PERCIMPOSTO ';
  AbreQueryAux;
  if FDQueryAux.RecordCount > 0 then
  begin
    EDT_PERCTC2A.EditText:= FDQueryAux.FieldByName('PERCENTUAL').AsString;
    EDT_PERCTC2B.EditText:= FDQueryAux.FieldByName('PERCENTUAL').AsString;
  end;
  FechaeLimparQueryAux;
  // Seta a data para HOJE
  DATETC2A.Date:= Now;
  DATETC2B.Date:= Now;
end;

procedure TFrmVendaTC2.SpeedButton1Click(Sender: TObject);
begin
 // Grava a Venda no Banco de Dados
  LblPrecoTC2B.Caption:= 'Preço: R$ '+ EDT_PRECOTOTAL2B.Text;
  FechaeLimparQueryAux;
  FDQueryAux.SQL.Text:= 'INSERT INTO TB_VENDATC2 '+
              ' (PRECO, DATA, QUANTIDADE, PRECO_VENDA, PERCENTUAL_IMPOSTO, BOMBA_OLEO, VALOR_IMPOSTO) '+
  ' VALUES '  +
              ' ('+StringReplace(EDT_PRECOOLEOB.Text,',','.', [rfReplaceAll])+','+
              #39+FormatDateTime('YYYY-MM-DD', DATETC2B.DateTime)+#39+', '+StringReplace(EDT_QuantidadeB.Text,',','.', [rfReplaceAll])+', '+
              StringReplace(EDT_PRECOTOTAL2B.Text,',','.', [rfReplaceAll])+', '+
              StringReplace(EDT_PERCTC2B.Text,',','.', [rfReplaceAll])+', '+
              '2, '+StringReplace(EDT_VALOR_IMPTCB.Text,',','.', [rfReplaceAll])+')';
  FDQueryAux.ExecSQL;
  ShowMessage('Venda de Óleo efetuada com sucesso!!!');
end;

end.
