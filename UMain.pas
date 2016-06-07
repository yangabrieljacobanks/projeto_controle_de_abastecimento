unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.Buttons, Vcl.Menus;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Vendas1: TMenuItem;
    anquedeCombustvel11: TMenuItem;
    anquedeCombustvel21: TMenuItem;
    Preo1: TMenuItem;
    Imposto1: TMenuItem;
    Sistema1: TMenuItem;
    Sobre: TMenuItem;
    Sair2: TMenuItem;
    Relatrios1: TMenuItem;
    Vendas2: TMenuItem;
    procedure Preo1Click(Sender: TObject);
    procedure Imposto1Click(Sender: TObject);
    procedure anquedeCombustvel11Click(Sender: TObject);
    procedure anquedeCombustvel21Click(Sender: TObject);
    procedure Vendas2Click(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure SobreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses UCadasGasOle, UCadasImp, UVendaTC1, UVendaTC2, URelVendas, USobre;

procedure TFrmMain.anquedeCombustvel11Click(Sender: TObject);
begin
  Application.CreateForm(TFrmVendaTC1, FrmVendaTC1);
  FrmVendaTC1.ShowModal;
end;

procedure TFrmMain.anquedeCombustvel21Click(Sender: TObject);
begin
  Application.CreateForm(TFrmVendaTC2, FrmVendaTC2);
  FrmVendaTC2.ShowModal;
end;

procedure TFrmMain.Imposto1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadasImp, FrmCadasImp);
  FrmCadasImp.ShowModal;
end;

procedure TFrmMain.Preo1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmCadasGasOle, FrmCadasGasOle);
  FrmCadasGasOle.ShowModal;
end;

procedure TFrmMain.SobreClick(Sender: TObject);
begin
  Application.CreateForm(TFrmSobre, FrmSobre);
  FrmSobre.ShowModal;
end;

procedure TFrmMain.Sair2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.Vendas2Click(Sender: TObject);
begin
  Application.CreateForm(TFrmRelVendas, FrmRelVendas);
  FrmRelVendas.ShowModal;
end;

end.
