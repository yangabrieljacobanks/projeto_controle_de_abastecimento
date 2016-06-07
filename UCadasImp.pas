unit UCadasImp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmCadasImp = class(TForm)
    Panel3: TPanel;
    Image2: TImage;
    Panel1: TPanel;
    Panel30: TPanel;
    EDTPERCIMPOSTO: TMaskEdit;
    SpeedButton1: TSpeedButton;
    Panel2: TPanel;
    FDQueryImposto: TFDQuery;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure FechaeLimparQueryImposto;
    procedure AtribueTextoImposto(texto: string);
    procedure AbreQueryImposto;
    procedure DeletaRegistrosImposto;
    procedure ExecutaQueryImposto;
  public
    { Public declarations }
  end;

var
  FrmCadasImp: TFrmCadasImp;

implementation

Uses UDataModule;

{$R *.dfm}

procedure TFrmCadasImp.AbreQueryImposto;
begin
  FDQueryImposto.Open;
  FDQueryImposto.Last;
  FDQueryImposto.First;
end;

procedure TFrmCadasImp.AtribueTextoImposto(texto: string);
begin
  FDQueryImposto.SQL.Text:= texto;
end;

procedure TFrmCadasImp.DeletaRegistrosImposto;
begin
  FechaeLimparQueryImposto;
  AtribueTextoImposto('DELETE FROM TB_PERCIMPOSTO');
  ExecutaQueryImposto;
end;

procedure TFrmCadasImp.ExecutaQueryImposto;
begin
  FDQueryImposto.ExecSQL;
end;

procedure TFrmCadasImp.FechaeLimparQueryImposto;
begin
  FDQueryImposto.Close;
  FDQueryImposto.SQL.Clear;
end;

procedure TFrmCadasImp.FormCreate(Sender: TObject);
begin
  FechaeLimparQueryImposto;
  AtribueTextoImposto('SELECT * FROM TB_PERCIMPOSTO');
  AbreQueryImposto;
  EDTPERCIMPOSTO.EditText:= FDQueryImposto.fieldByname('PERCENTUAL').AsString;
end;

procedure TFrmCadasImp.SpeedButton1Click(Sender: TObject);
begin
  if DataModule1.FDConnection.Connected = True then
  begin
    FechaeLimparQueryImposto;
    AtribueTextoImposto('SELECT * FROM TB_PERCIMPOSTO');
    AbreQueryImposto;
    if FDQueryImposto.RecordCount > 0 then
      DeletaRegistrosImposto;
    FechaeLimparQueryImposto;
    AtribueTextoImposto('INSERT INTO TB_PERCIMPOSTO (PERCENTUAL) VALUES ('+StringReplace(EDTPERCIMPOSTO.EditText,',','.', [rfReplaceAll])+')');
    ExecutaQueryImposto;
    ShowMessage('A Porcentagem do Imposto foi gravada com sucesso!!!');
  end;
end;

end.
