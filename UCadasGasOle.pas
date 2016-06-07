unit UCadasGasOle;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmCadasGasOle = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel33: TPanel;
    EDTPRECOGASOL: TMaskEdit;
    Panel34: TPanel;
    Panel5: TPanel;
    EDTPRECOOLEO: TMaskEdit;
    Panel6: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    FDQueryGASOL: TFDQuery;
    FDQueryOleo: TFDQuery;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    procedure FechaeLimparQueryGasol;
    procedure AtribueTextoGasol(texto: string);
    procedure AbreQueryGasol;
    procedure DeletaRegistrosGasolina;
    procedure ExecutaQueryGasol;
    procedure FechaeLimparQueryOleo;
    procedure AtribueTextoOleo(texto: string);
    procedure AbreQueryOleo;
    procedure DeletaRegistrosOleo;
    procedure ExecutaQueryOleo;
  public
    { Public declarations }
  end;

var
  FrmCadasGasOle: TFrmCadasGasOle;

implementation

Uses UDataModule;

{$R *.dfm}

procedure TFrmCadasGasOle.AbreQueryGasol;
begin
  FDQueryGASOL.Open;
  FDQueryGASOL.Last;
  FDQueryGASOL.First;
end;

procedure TFrmCadasGasOle.AbreQueryOleo;
begin
  FDQueryOleo.Open;
  FDQueryOleo.Last;
  FDQueryOleo.First;
end;

procedure TFrmCadasGasOle.AtribueTextoGasol(texto: string);
begin
  FDQueryGASOL.SQL.Text:= texto;
end;

procedure TFrmCadasGasOle.AtribueTextoOleo(texto: string);
begin
  FDQueryOleo.SQL.Text:= texto;
end;

procedure TFrmCadasGasOle.DeletaRegistrosGasolina;
begin
  FechaeLimparQueryGasol;
  AtribueTextoGasol('DELETE FROM TB_PRECOGASOL');
  ExecutaQueryGasol;
end;

procedure TFrmCadasGasOle.DeletaRegistrosOleo;
begin
  FechaeLimparQueryOleo;
  AtribueTextoOleo('DELETE FROM TB_PRECOOLEO');
  ExecutaQueryOleo;
end;

procedure TFrmCadasGasOle.ExecutaQueryGasol;
begin
  FDQueryGASOL.ExecSQL;
end;

procedure TFrmCadasGasOle.ExecutaQueryOleo;
begin
  FDQueryOleo.ExecSQL;
end;

procedure TFrmCadasGasOle.FechaeLimparQueryGasol;
begin
  FDQueryGASOL.Close;
  FDQueryGASOL.SQL.Clear;
end;

procedure TFrmCadasGasOle.FechaeLimparQueryOleo;
begin
  FDQueryOleo.Close;
  FDQueryOleo.SQL.Clear;
end;

procedure TFrmCadasGasOle.FormCreate(Sender: TObject);
begin
  FechaeLimparQueryGasol;
  AtribueTextoGasol('SELECT * FROM TB_PRECOGASOL');
  AbreQueryGasol;
  EDTPRECOGASOL.EditText:= FDQueryGASOL.fieldByname('PRECO').AsString;

  FechaeLimparQueryOleo;
  AtribueTextoOleo('SELECT * FROM TB_PRECOOLEO');
  AbreQueryOleo;
  EDTPRECOOLEO.EditText:= FDQueryOleo.fieldByname('PRECO').AsString;
end;

procedure TFrmCadasGasOle.SpeedButton1Click(Sender: TObject);
begin
  if DataModule1.FDConnection.Connected = True then
  begin
    FechaeLimparQueryGasol;
    AtribueTextoGasol('SELECT * FROM TB_PRECOGASOL');
    AbreQueryGasol;
    if FDQueryGASOL.RecordCount > 0 then
      DeletaRegistrosGasolina;
    FechaeLimparQueryGasol;
    AtribueTextoGasol('INSERT INTO TB_PRECOGASOL (PRECO) VALUES ('+StringReplace(EDTPRECOGASOL.EditText,',','.', [rfReplaceAll])+')');
    ExecutaQueryGasol;
    ShowMessage('O Preço da Gasolina foi gravado com sucesso!!!');
  end;
end;

procedure TFrmCadasGasOle.SpeedButton2Click(Sender: TObject);
begin
  if DataModule1.FDConnection.Connected = True then
  begin
    FechaeLimparQueryOleo;
    AtribueTextoOleo('SELECT * FROM TB_PRECOOLEO');
    AbreQueryOleo;
    if FDQueryOleo.RecordCount > 0 then
      DeletaRegistrosOleo;
    FechaeLimparQueryOleo;
    AtribueTextoOleo('INSERT INTO TB_PRECOOLEO (PRECO) VALUES ('+StringReplace(EDTPRECOOLEO.EditText,',','.', [rfReplaceAll])+')');
    ExecutaQueryOleo;
    ShowMessage('O Preço do Óleo Diesel foi gravado com sucesso!!!');
  end;
end;

end.
