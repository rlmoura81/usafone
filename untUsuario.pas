unit untUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, Menus, ComCtrls, StdCtrls, ExtCtrls, Grids,
  DBGrids, Buttons, DBCtrls;

type
  TFormUsuario = class(TFormPadrao)
    mmUsuario: TMainMenu;
    Voltar1: TMenuItem;
    dbgUsuario: TDBGrid;
    pnlCampos: TPanel;
    pnlControl: TPanel;
    edtMatricula: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCargo: TLabeledEdit;
    dbcbUnidade: TDBLookupComboBox;
    lblUnidade: TLabel;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnRelatorio: TBitBtn;
    Novo1: TMenuItem;
    edtLocalizarUsuario: TEdit;
    btnLocalizar: TBitBtn;
    procedure Voltar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtMatriculaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMatriculaExit(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCargoKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgUsuarioCellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure dbcbUnidadeClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure edtLocalizarUsuarioKeyPress(Sender: TObject; var Key: Char);
  private
  function Validar: Boolean;
  function InsertSQL: Boolean;
  function Atualizar:Boolean;
  function Formnovo: Boolean;
  function SQLPadrao: Boolean;
  function SQLLocalizarUsuario: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUsuario: TFormUsuario;

implementation

uses untDM, DB, untRelUsuario, untLogin, untPrincipal;

{$R *.dfm}

procedure TFormUsuario.Voltar1Click(Sender: TObject);
begin
  inherited;
   close;
end;

procedure TFormUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;
   SQLPadrao;
end;

procedure TFormUsuario.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   tag := 1;
   dbcbUnidade.SetFocus;
end;

procedure TFormUsuario.edtMatriculaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      edtNome.SetFocus;
end;

procedure TFormUsuario.edtMatriculaExit(Sender: TObject);
begin
  inherited;
   if Trim(edtMatricula.Text) = '' then
      begin
         exit;
      end else
   if StrToIntDef(edtMatricula.Text, -1) = -1 then
      begin
         MessageDlg('Somente números.', mtError, [mbOK], 0);
         edtMatricula.SetFocus;
         exit;
      end;
end;

procedure TFormUsuario.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtCargo.SetFocus;
end;

procedure TFormUsuario.edtCargoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if btnGravar.Enabled = False then
         exit
      else
   if key = #13 then
      btnGravar.SetFocus;
end;

procedure TFormUsuario.dbcbUnidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtMatricula.SetFocus;
end;
//TO-DO VALIDAR FORMULARIO USUARIO
function TFormUsuario.Validar: Boolean;
begin
   Result := False;
   if trim(edtMatricula.Text) = '' then
      begin
         MessageDlg('Digite a matrícula.', mtInformation, [mbOK], 0);
         edtMatricula.SetFocus;
         exit;
      end else
   if trim(edtNome.Text) = '' then
      begin
         MessageDlg('Digite o nome do usuário.', mtInformation, [mbOK], 0);
         edtNome.SetFocus;
         exit;
      end else
   if trim(edtCargo.Text) = '' then
      begin
         MessageDlg('Digite o cargo/função do usuário.', mtInformation, [mbOK], 0);
         edtCargo.SetFocus;
         exit;
      end else
   if trim(dbcbUnidade.Text) = '' then
      begin
         MessageDlg('Selecione a unidade.', mtInformation, [mbOK], 0);
         dbcbUnidade.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormUsuario.btnGravarClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   InsertSQL;
   if tag = 1 then
      MessageDlg('Usuário cadastrado com sucesso.', mtInformation, [mbOK], 0);
   if tag = 2 then
      MessageDlg('Usuário alterado com sucesso.', mtInformation, [mbOK], 0);
   Formnovo;
end;
//TO-DO FUNCAO ATUALIZAR GRID USUARIO
function TFormUsuario.Atualizar: Boolean;
begin
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;
end;
//TO-DO FUNCAO INSERTSQL USUÁRIO
function TFormUsuario.InsertSQL: Boolean;
begin
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO usuario (cd_matricula, ds_nome, ds_cargo, cd_usina, id_user)' +
                                 '   VALUES (:cd_matricula, :ds_nome, :ds_cargo, :cd_usina, :id_user)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE usuario SET ds_nome = :ds_nome, ds_cargo = :ds_cargo, id_user = :id_user' +
                                 '   WHERE cd_matricula = :cd_matricula AND' +
                                 '         cd_usina = :cd_usina');
      end;
   dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := edtMatricula.Text;
   dm.ADOQSQL.Parameters.ParamByName('ds_nome').Value := edtNome.Text;
   dm.ADOQSQL.Parameters.ParamByName('ds_cargo').Value := edtCargo.Text;
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   Atualizar;
   btnGravar.Enabled := False;
end;

procedure TFormUsuario.dbgUsuarioCellClick(Column: TColumn);
begin
  inherited;
   tag := 2;
   btnGravar.Enabled := True;
   edtMatricula.Text := dm.ADOQusuario.FieldByName('cd_matricula').AsString;
   edtNome.Text := dm.ADOQusuario.FieldByName('ds_nome').AsString;
   edtCargo.Text := dm.ADOQusuario.FieldByName('ds_cargo').AsString;
   dbcbUnidade.KeyValue := dm.ADOQusuario.FieldByName('cd_usina').AsInteger;
end;

procedure TFormUsuario.btnExcluirClick(Sender: TObject);
begin
  inherited;
   if MessageDlg('Deseja realmente excluir as informações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM usuario WHERE cd_matricula = :cd_matricula');
         dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := edtMatricula.Text;
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
   Atualizar;
   Formnovo;
end;
//TO-DO FUNCAO DE LIMPAR FORMULARIO
function TFormUsuario.Formnovo: Boolean;
begin
   edtMatricula.Clear;
   edtNome.Clear;
   edtCargo.Clear;
   dbcbUnidade.KeyValue := -1;
   btnGravar.Enabled := True;
   dbcbUnidade.SetFocus;
   Tag := 1;
   edtLocalizarUsuario.Clear;
   SQLPadrao;
end;

procedure TFormUsuario.Novo1Click(Sender: TObject);
begin
  inherited;
   Formnovo;
end;

procedure TFormUsuario.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   dm.ADOQusuario.Open;
   FormRelUsuario := TFormRelUsuario.Create(Application);
   FormRelUsuario.rlrRelatorio.Preview();
end;

procedure TFormUsuario.dbcbUnidadeClick(Sender: TObject);
begin
  inherited;
   dm.ADOQusuario.SQL.Clear;
   dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, usina.cd_usina, usina.ds_usina ' +
                               '   FROM usuario, usina ' +
                               '   WHERE usuario.cd_usina = usina.cd_usina AND ' +
                               '         usina.cd_usina = :cd_usina ' +
                               '   ORDER BY ds_usina, cd_matricula, ds_nome');
   dm.ADOQusuario.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;

   edtMatricula.Clear;
   edtNome.Clear;
   edtCargo.Clear;
   btnGravar.Enabled := True;
   dbcbUnidade.SetFocus;
   Tag := 1;
   edtLocalizarUsuario.Clear;
end;

//TO-DO DBGRID PADRAO USUARIO
function TFormUsuario.SQLPadrao: Boolean;
begin
   dm.ADOQusuario.SQL.Clear;
   dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, usina.cd_usina, usina.ds_usina ' +
                               '   FROM usuario, usina ' +
                               '   WHERE usuario.cd_usina = usina.cd_usina ' +
                               '      ORDER BY ds_usina, cd_matricula, ds_nome');
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;
end;

//TO-DO SQL LOCALIZAR USUARIO;
function TFormUsuario.SQLLocalizarUsuario: Boolean;
begin
   dm.ADOQusuario.SQL.Clear;
   dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, usina.cd_usina, usina.ds_usina ' +
                               '   FROM usuario, usina ' +
                               '   WHERE usuario.cd_usina = usina.cd_usina AND ' +
                               '      usuario.ds_nome LIKE :ds_nome' +
                               '   ORDER BY ds_usina, cd_matricula, ds_nome');
   dm.ADOQusuario.Parameters.ParamByName('ds_nome').Value := '%'+edtLocalizarUsuario.Text+'%';
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;
end;

procedure TFormUsuario.btnLocalizarClick(Sender: TObject);
begin
  inherited;
   if trim(edtLocalizarUsuario.Text) = '' then
      begin
         MessageDlg('Digite o nome a ser localizado.', mtInformation, [mbOK], 0);
         edtLocalizarUsuario.SetFocus;
         exit;
      end;
   SQLLocalizarUsuario;

   edtMatricula.Clear;
   edtNome.Clear;
   edtCargo.Clear;
   dbcbUnidade.KeyValue := -1;
   btnGravar.Enabled := True;
   dbcbUnidade.SetFocus;
   Tag := 1;
end;

procedure TFormUsuario.edtLocalizarUsuarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      btnLocalizar.Click;
end;

end.
