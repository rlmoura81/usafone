unit untPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, Menus, ComCtrls, jpeg, ExtCtrls, StdCtrls;

type
  TFormPrincipal = class(TFormPadrao)
    mmPrincipal: TMainMenu;
    Sair1: TMenuItem;
    imgPrincipal: TImage;
    Agenda1: TMenuItem;
    Sobre1: TMenuItem;
    Cadastro1: TMenuItem;
    Cidade1: TMenuItem;
    Unidade1: TMenuItem;
    Usurio1: TMenuItem;
    Operadora1: TMenuItem;
    Marca1: TMenuItem;
    Modelo1: TMenuItem;
    Estoque1: TMenuItem;
    Aparelhos1: TMenuItem;
    CHIPs1: TMenuItem;
    ListadeTelefones1: TMenuItem;
    CriarAgenda1: TMenuItem;
    Config1: TMenuItem;
    Movimentao1: TMenuItem;
    Acesso1: TMenuItem;
    Senha1: TMenuItem;
    lblUser: TLabel;
    imgLogo: TImage;
    Atualizar1: TMenuItem;
    Gastos1: TMenuItem;
    BlackBerry1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure Cidade1Click(Sender: TObject);
    procedure Unidade1Click(Sender: TObject);
    procedure Usurio1Click(Sender: TObject);
    procedure Operadora1Click(Sender: TObject);
    procedure Marca1Click(Sender: TObject);
    procedure Modelo1Click(Sender: TObject);
    procedure Aparelhos1Click(Sender: TObject);
    procedure CHIPs1Click(Sender: TObject);
    procedure ListadeTelefones1Click(Sender: TObject);
    procedure CriarAgenda1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure Movimentao1Click(Sender: TObject);
    procedure Acesso1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Senha1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure lblUserClick(Sender: TObject);
    procedure lblUserMouseEnter(Sender: TObject);
    procedure lblUserMouseLeave(Sender: TObject);
    procedure Atualizar1Click(Sender: TObject);
    procedure Gastos1Click(Sender: TObject);
    procedure BlackBerry1Click(Sender: TObject);
  private
     sts: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses untCidade, untUnidade, untUsuario, untOperadora, untMarca, untModelo,
  untAparelhos, untChip, untAgenda, untListaTelefone, untEstoque,
  untAcesso, untLogin, untSenha, untGasto, untBlackberry;

{$R *.dfm}

procedure TFormPrincipal.Sair1Click(Sender: TObject);
begin
  inherited;
   if MessageDlg('Encerrar o Usafone?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      Application.Terminate;
end;

procedure TFormPrincipal.Cidade1Click(Sender: TObject);
begin
  inherited;
   FormCidade := TFormCidade.Create(Application);
   FormCidade.ShowModal;
end;

procedure TFormPrincipal.Unidade1Click(Sender: TObject);
begin
  inherited;
   FormUnidade := TFormUnidade.Create(Application);
   FormUnidade.ShowModal;
end;

procedure TFormPrincipal.Usurio1Click(Sender: TObject);
begin
  inherited;
   FormUsuario := TFormUsuario.Create(Application);
   FormUsuario.ShowModal;
end;

procedure TFormPrincipal.Operadora1Click(Sender: TObject);
begin
  inherited;
   FormOperadora := TFormOperadora.Create(Application);
   FormOperadora.ShowModal;
end;

procedure TFormPrincipal.Marca1Click(Sender: TObject);
begin
  inherited;
   FormMarca := TFormMarca.Create(Application);
   FormMarca.ShowModal;
end;

procedure TFormPrincipal.Modelo1Click(Sender: TObject);
begin
  inherited;
   FormModelo := TFormModelo.Create(Application);
   FormModelo.ShowModal;
end;

procedure TFormPrincipal.Aparelhos1Click(Sender: TObject);
begin
  inherited;
   FormAparelhos := TFormAparelhos.Create(Application);
   FormAparelhos.ShowModal;
end;

procedure TFormPrincipal.CHIPs1Click(Sender: TObject);
begin
  inherited;
   FormChip := TFormChip.Create(Application);
   FormChip.ShowModal;
end;

procedure TFormPrincipal.ListadeTelefones1Click(Sender: TObject);
begin
  inherited;
   FormListaTelefone := TFormListaTelefone.Create(Application);
   FormListaTelefone.sts := 1;
   FormListaTelefone.ShowModal;
end;

procedure TFormPrincipal.CriarAgenda1Click(Sender: TObject);
begin
  inherited;
   FormAgenda := TFormAgenda.Create(Application);
   FormAgenda.ShowModal;
end;

procedure TFormPrincipal.Sobre1Click(Sender: TObject);
begin
  inherited;
   MessageDlg('USAFONE'#13'v 1.0' +
               #13'PH.info e USACUCAR' +
               #13'------------------------------------------' +
               #13'Desenvolvedor: ' +
               #13'   Raphael Lúcio Moura' +
               #13'   Analista de Sistema Trainee' +
               #13'------------------------------------------' +
               #13'Agradecimentos: ' +
               #13'   Jefferson Barison, Sergio Galinari.'
                  , mtInformation, [mbOK], 0);
end;

procedure TFormPrincipal.Movimentao1Click(Sender: TObject);
begin
  inherited;
   FormEstoque := TFormEstoque.Create(Application);
   FormEstoque.ShowModal;
end;

procedure TFormPrincipal.Acesso1Click(Sender: TObject);
begin
  inherited;
   FormAcesso := TFormAcesso.Create(Application);
   FormAcesso.ShowModal;
end;

procedure TFormPrincipal.Gastos1Click(Sender: TObject);
begin
  inherited;
   FormGasto := TFormGasto.Create(Application);
   FormGasto.ShowModal;
   end;

//TO-DO: CONTROLE DO MENU.
procedure TFormPrincipal.FormShow(Sender: TObject);
var op_menu: Integer;
begin
  inherited;
   op_menu := FormLogin.ac;
   if op_menu = 1 then
      begin
         mmPrincipal.Items[3][0].Enabled := False;
      end else
   if op_menu = 2 then
      begin
         mmPrincipal.Items[0].Enabled := False;
         mmPrincipal.Items[1].Enabled := False;
         mmPrincipal.Items[2][0].Enabled := False;
         mmPrincipal.Items[2][1].Enabled := False;
         mmPrincipal.Items[2][2].Enabled := False;
         mmPrincipal.Items[3][0].Enabled := False;
      end else
   if op_menu = 3 then
      begin
         mmPrincipal.Items[0].Enabled := False;
         mmPrincipal.Items[1].Enabled := False;
         mmPrincipal.Items[2][0].Enabled := False;
         mmPrincipal.Items[2][1].Enabled := False;
         mmPrincipal.Items[2][2].Enabled := False;
         mmPrincipal.Items[3][0].Enabled := False;
         mmPrincipal.Items[3][2].Enabled := False;
      end;
   lblUser.Caption := 'USUÁRIO: ' + FormLogin.nm_user;
end;

procedure TFormPrincipal.Senha1Click(Sender: TObject);
begin
  inherited;
   FormSenha := TFormSenha.Create(Application);
   FormSenha.ShowModal;
end;

procedure TFormPrincipal.BlackBerry1Click(Sender: TObject);
begin
  inherited;
   FormBlackberry := TFormBlackberry.Create(Application);
   FormBlackberry.ShowModal;
end;

procedure TFormPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   if sts = False then
      exit
   else
   if MessageDlg('Encerrar o Usafone?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         Application.Terminate;
      end else
         exit;
end;

procedure TFormPrincipal.FormActivate(Sender: TObject);
begin
  inherited;
   FormLogin.Hide;
end;

procedure TFormPrincipal.lblUserClick(Sender: TObject);
begin
  inherited;
   if MessageDlg('Fazer logoff de ' + FormLogin.nm_user + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         FormLogin.Show;
         sts := False;
         FormPrincipal.Close;
      end else
         exit;
end;

procedure TFormPrincipal.lblUserMouseEnter(Sender: TObject);
begin
  inherited;
   lblUser.Font.Color := clRed;
   lblUser.Cursor := crHandPoint;
end;

procedure TFormPrincipal.lblUserMouseLeave(Sender: TObject);
begin
  inherited;
   lblUser.Cursor := crDefault;
   lblUser.Font.Color := clBlack;
end;

procedure TFormPrincipal.Atualizar1Click(Sender: TObject);
begin
  inherited;
   WinExec('\\USA9FS\VOL1\SOL\FONTES\US\Delphi\usafone\atualiza_usafone.bat',SW_SHOWNORMAL);
   Application.Terminate;
end;

end.
