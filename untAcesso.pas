unit untAcesso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, ComCtrls, Menus, StdCtrls, DB, DBCtrls, ExtCtrls,
  Buttons, Grids, DBGrids, Mask, ADODB;

type
  TFormAcesso = class(TFormPadrao)
    mmAcesso: TMainMenu;
    Sair1: TMenuItem;
    pnlCampos: TPanel;
    dbcbUsuario: TDBLookupComboBox;
    lblUsuario: TLabel;
    cbAcesso: TComboBox;
    lblAcesso: TLabel;
    pnlControl: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnRelatorio: TBitBtn;
    dbgAcesso: TDBGrid;
    btnAutorizar: TBitBtn;
    btnExcluir: TBitBtn;
    edtSenha: TLabeledEdit;
    edtLogin: TLabeledEdit;
    dbcbUsina: TDBLookupComboBox;
    lblUsina: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sair1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAutorizarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgAcessoCellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbcbUsinaClick(Sender: TObject);
    procedure dbcbUsinaKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure cbAcessoKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
  private
  function Validar: Boolean;
  function InsertSQL: Boolean;
  function Atualizar: Boolean;
  function FiltroSQL: Boolean;
  function PadraoSQL: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAcesso: TFormAcesso;

implementation

uses untUsuario, untDM, untLogin, untPrincipal, Math;

{$R *.dfm}

procedure TFormAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   PadraoSQL;
   Action := caFree;
end;

procedure TFormAcesso.Sair1Click(Sender: TObject);
begin
  inherited;
   if btnGravar.Enabled = True then
      begin
         MessageDlg('O registro não foi salvo.', mtInformation, [mbOK], 0);
         exit;
      end;
   if btnGravar.Enabled = False then
      Close;
end;

procedure TFormAcesso.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   
   dm.ADOusafone.IsolationLevel := ilReadCommitted;
   dbcbUsuario.Enabled := False;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
   dm.ADOQusuario.Open;
   dm.ADOQacesso.Open;
end;
//TO-DO FUNCAO VALIDAR
function TFormAcesso.Validar: Boolean;
begin
   Result := False;
   if Trim(dbcbUsuario.Text) = '' then
      begin
         MessageDlg('Selecione o usuário.', mtInformation, [mbOK], 0);
         dbcbUsuario.SetFocus;
         exit;
      end else
   if Trim(edtLogin.Text) = '' then
      begin
         MessageDlg('Digite o login.', mtInformation, [mbOK], 0);
         edtLogin.SetFocus;
         exit;
      end else
   if Trim(cbAcesso.Text) = '' then
      begin
         MessageDlg('Selecione o tipo de acesso.', mtInformation, [mbOK], 0);
         cbAcesso.SetFocus;
         exit;
      end else
   if Trim(edtSenha.Text) = '' then
      begin
         MessageDlg('Digite a senha do usuario.', mtInformation, [mbOK], 0);
         edtSenha.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormAcesso.btnAutorizarClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   InsertSQL;
   Atualizar;
   btnGravar.Enabled := True;
   btnCancelar.Enabled := True;
end;
//TO-DO INSERT SQL ACESSO
function TFormAcesso.InsertSQL: Boolean;
begin
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   begin
      dm.ADOQSQL.SQL.Clear;
      dm.ADOQSQL.SQL.Text := ('INSERT INTO acesso (cd_usina, cd_acesso, ds_login, cd_senha, cd_matricula, id_user) VALUES (:cd_usina, :cd_acesso, :ds_login, :cd_senha, :cd_matricula, :id_user)');
   end;
      dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUsina.KeyValue);
      dm.ADOQSQL.Parameters.ParamByName('cd_acesso').Value := cbAcesso.ItemIndex;
      dm.ADOQSQL.Parameters.ParamByName('ds_login').Value := edtLogin.Text;
      dm.ADOQSQL.Parameters.ParamByName('cd_senha').Value := edtSenha.Text;
      dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbUsuario.KeyValue);
      dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
      dm.ADOQSQL.ExecSQL;
end;

procedure TFormAcesso.btnGravarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.CommitTrans;
   dbcbUsina.KeyValue := -1;
   dbcbUsuario.KeyValue := -1;
   dbcbUsuario.Enabled := False;
   edtLogin.Clear;
   cbAcesso.ItemIndex := -1;
   edtSenha.Clear;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
   Atualizar;
   MessageDlg('Gravação concluida.', mtConfirmation, [mbOK], 0);
end;
//TO-DO FUNCAO DE ATUALIZACAO DA DBGACESSO
function TFormAcesso.Atualizar: Boolean;
begin
   dm.ADOQacesso.Close;
   dm.ADOQacesso.Open;
end;

procedure TFormAcesso.dbgAcessoCellClick(Column: TColumn);
begin
  inherited;
   dbcbUsina.KeyValue := dm.ADOQacesso.FieldByName('cd_usina').AsInteger;
   dbcbUsuario.KeyValue := dm.ADOQacesso.FieldByName('cd_matricula').AsInteger;
   edtLogin.Text := dm.ADOQacesso.FieldByName('ds_login').AsString;
   cbAcesso.ItemIndex := dm.ADOQacesso.FieldByName('cd_acesso').AsInteger;
//   edtSenha.Text := dm.ADOQacesso.FieldByName('cd_senha').AsString;
end;

procedure TFormAcesso.btnExcluirClick(Sender: TObject);
begin
  inherited;
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   if dbcbUsuario.Text = '' then
      begin
         exit;
      end else
   if MessageDlg('Deseja realmente excluir as informações?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM acesso WHERE cd_matricula = :cd_matricula');
         dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbUsuario.KeyValue);
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
      Atualizar;
      btnGravar.Enabled := True;
      btnCancelar.Enabled := True;
end;

procedure TFormAcesso.btnCancelarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.RollbackTrans;
   dbcbUsina.KeyValue := -1;
   dbcbUsuario.KeyValue := -1;
   dbcbUsuario.Enabled := False;
   edtLogin.Clear;
   cbAcesso.ItemIndex := -1;
   edtSenha.Clear;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
   Atualizar;
end;
//TO-DO FILTRO SQL USINA/USUARIO
function TFormAcesso.FiltroSQL: Boolean;
begin
   dm.ADOQusuario.SQL.Clear;
   dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, usina.cd_usina, usina.ds_usina ' +
                               '   FROM usuario, usina ' +
                               '   WHERE usuario.cd_usina = usina.cd_usina AND ' +
                               '         usina.cd_usina = :cd_usina ' +
                               '   ORDER BY ds_nome');
   dm.ADOQusuario.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUsina.KeyValue);
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;
end;

//TO-DO PADRAO SQL USUARIO
function TFormAcesso.PadraoSQL: Boolean;
begin
   dm.ADOQusuario.SQL.Clear;
   dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, usina.cd_usina, usina.ds_usina ' +
                               '   FROM usuario, usina ' +
                               '   WHERE usuario.cd_usina = usina.cd_usina ' +
                               '      ORDER BY ds_usina, cd_matricula, ds_nome');
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;
end;

procedure TFormAcesso.dbcbUsinaClick(Sender: TObject);
begin
  inherited;
   FiltroSQL;
   dbcbUsuario.Enabled := True;
end;

procedure TFormAcesso.dbcbUsinaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbUsuario.SetFocus;
end;

procedure TFormAcesso.dbcbUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtLogin.SetFocus;
end;

procedure TFormAcesso.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      cbAcesso.SetFocus;
end;

procedure TFormAcesso.cbAcessoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtSenha.SetFocus;
end;

procedure TFormAcesso.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnAutorizar.SetFocus; 
end;

end.
