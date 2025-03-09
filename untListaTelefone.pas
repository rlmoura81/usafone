unit untListaTelefone;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, ComCtrls, Menus, StdCtrls, ADODB, DBCtrls, ExtCtrls,
  Buttons, Mask, Grids, DBGrids;

type
  TFormListaTelefone = class(TFormPadrao)
    mmListaTelefone: TMainMenu;
    Voltar1: TMenuItem;
    pnlCampos: TPanel;
    dbcbUnidade: TDBLookupComboBox;
    lblUnidade: TLabel;
    dbcbFuncionario: TDBLookupComboBox;
    lblFuncionario: TLabel;
    pnlTelefone: TPanel;
    lblNumero: TLabel;
    mkedtNumero: TMaskEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    btnInserir: TBitBtn;
    dbgListaTelefone: TDBGrid;
    pnlControl: TPanel;
    btnGravar: TBitBtn;
    btnExcluirNumero: TBitBtn;
    btnExcluir: TBitBtn;
    btnRelatorio: TBitBtn;
    lblregistro: TLabel;
    btnPin2: TBitBtn;
    edtNumero: TLabeledEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Voltar1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbcbUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbFuncionarioKeyPress(Sender: TObject; var Key: Char);
    procedure mkedtNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure btnInserirClick(Sender: TObject);
    procedure mkedtNumeroExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbcbUnidadeExit(Sender: TObject);
    procedure dbcbFuncionarioClick(Sender: TObject);
    procedure dbcbUnidadeClick(Sender: TObject);
    procedure btnExcluirNumeroClick(Sender: TObject);
    procedure dbgListaTelefoneCellClick(Column: TColumn);
    procedure btnRelatorioClick(Sender: TObject);
    procedure btnPin2Click(Sender: TObject);
    procedure dbgListaTelefoneKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
     qtde: Integer;
  function Validar: Boolean;
  function Atualizar: Boolean;
  function InsertSQL: Boolean;
  function DeleteSQL: Boolean;
  function PadraoSQL: Boolean;
  function FiltroSQL: Boolean;
  function CountSQL: Boolean;
  function Acesso: Boolean;
    { Private declarations }
  public
     sts: Integer;
    { Public declarations }
  end;

var
  FormListaTelefone: TFormListaTelefone;

implementation

uses untDM, DB, untRelListaTelefone, untLogin, untPrincipal, untAgenda;

{$R *.dfm}

procedure TFormListaTelefone.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   if sts = 0 then
      FormAgenda.Show;
   if sts = 1 then
      FormPrincipal.Show;
   Action := caFree;
   PadraoSQL;
end;

procedure TFormListaTelefone.Voltar1Click(Sender: TObject);
begin
  inherited;
if btnGravar.Enabled = True then
      begin
         if MessageDlg('As alterações não foram salvas.'#13'Sair sem salvar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            close;
      end;
   if btnGravar.Enabled = False then
      Close;
end;

procedure TFormListaTelefone.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   tag := 1;
   Acesso;
   dm.ADOQlistafone.Close;
   dbgListaTelefone.Enabled := False;
   dbcbUnidade.SetFocus;
   dbcbFuncionario.Enabled := False;
   btnGravar.Enabled := False;
   btnExcluir.Enabled := False;
   dm.ADOusafone.IsolationLevel := ilReadCommitted;
end;

procedure TFormListaTelefone.dbcbUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbFuncionario.SetFocus;
end;

procedure TFormListaTelefone.dbcbFuncionarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      mkedtNumero.SetFocus;
end;

procedure TFormListaTelefone.mkedtNumeroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      edtNome.SetFocus;
end;

procedure TFormListaTelefone.edtNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      btnInserir.SetFocus;
end;
//TO-DO VALIDAR FORMULÁRIO LISTATELEFONE
function TFormListaTelefone.Validar: Boolean;
begin
   Result := False;
   if trim(dbcbUnidade.Text) = '' then
      begin
         MessageDlg('Selecione a unidade.', mtInformation, [mbOK], 0);
         dbcbUnidade.SetFocus;
         exit;
      end else
   if trim(dbcbFuncionario.Text) = '' then
      begin
         MessageDlg('Selecione o funcionário.', mtInformation, [mbOK], 0);
         dbcbFuncionario.SetFocus;
         exit;
      end else
   if trim(mkedtNumero.Text) = '' then
      begin
         MessageDlg('Digite o número do telefone.', mtInformation, [mbOK], 0);
         mkedtNumero.SetFocus;
         exit;
      end else
   if trim(edtNome.Text) = '' then
      begin
         MessageDlg('Digite o nome do telefone.', mtInformation, [mbOK], 0);
         edtNome.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormListaTelefone.btnInserirClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   MessageDlg('Telefone cadastrado.', mtInformation, [mbOK], 0);
   CountSQL;
   {if qtde = 20 then
      begin
         MessageDlg('Já existe vinte números cadastrados.', mtError, [mbOK], 0);
         exit;
      end else}
      begin
         InsertSQL;
         CountSQL;
         lblregistro.Caption := 'Registro: ' + IntToStr(qtde);
         mkedtNumero.Clear;
         edtNome.Clear;
         mkedtNumero.SetFocus;
      end;
   if btnGravar.Enabled = False then
      btnGravar.Enabled := True;
   if btnExcluir.Enabled = False then
      btnExcluir.Enabled := True;
end;

procedure TFormListaTelefone.mkedtNumeroExit(Sender: TObject);
var text: String;
begin
  inherited;
   text := trim(mkedtNumero.Text);
   if mkedtNumero.Text = '' then
      begin
         exit;
      end else
   if Length(text) <> 10 then
      begin
         MessageDlg('Número inválido.'#13'Número de telefone deve ter 10 dígitos.', mtError, [mbOK], 0);
         mkedtNumero.SetFocus;
         exit;
      end;
end;
//TO-DO INSERT LISTAFONE
function TFormListaTelefone.InsertSQL: Boolean;
begin
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO listafone (cd_usina, cd_matricula, cd_numero, ds_nome, id_user)' +
                                 '   VALUES (:cd_usina, :cd_matricula, :cd_numero, :ds_nome, :id_user)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE listafone SET cd_numero = :cd_numero, ds_nome = :ds_nome, id_user = :id_user' +
                                 '   WHERE cd_matricula = :cd_matricula AND' +
                                 '         cd_usina = :cd_usina');
      end;
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbFuncionario.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := mkedtNumero.Text;
   dm.ADOQSQL.Parameters.ParamByName('ds_nome').Value := edtNome.Text;
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   Atualizar;
end;
//TO-DO ATUALIZAR GRID
function TFormListaTelefone.Atualizar: Boolean;
begin
   dm.ADOQlistafone.Close;
   dm.ADOQlistafone.Open;
end;

procedure TFormListaTelefone.btnGravarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.CommitTrans;
   Atualizar;
   MessageDlg('Lista salva com sucesso.', mtInformation, [mbOK], 0);
   btnGravar.Enabled := False;
   btnExcluir.Enabled := False;
   //dbcbUnidade.KeyValue := -1;
   //dbcbFuncionario.KeyValue := -1;
   mkedtNumero.Clear;
   edtNome.Clear;
end;

procedure TFormListaTelefone.btnExcluirClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.RollbackTrans;
   Atualizar;
   btnGravar.Enabled := False;
   btnExcluir.Enabled := False;
   //dbcbUnidade.KeyValue := -1;
   //dbcbFuncionario.KeyValue := -1;
   mkedtNumero.Clear;
   edtNome.Clear;
end;
//TO-DO FILTRO SQL FUNCIONARIO
function TFormListaTelefone.FiltroSQL: Boolean;
begin
   dm.ADOQusuario.SQL.Clear;
   dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome' +
                               '   FROM usuario, usina ' +
                               '   WHERE usuario.cd_usina = usina.cd_usina AND' +
                               '      usina.cd_usina = :cd_usina' +
                               '   ORDER BY usuario.ds_nome');
   dm.ADOQusuario.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;
end;

procedure TFormListaTelefone.dbcbUnidadeExit(Sender: TObject);
begin
  inherited;
   if dbcbUnidade.Text = '' then
      exit;
   FiltroSQL;
end;
//TO-DO PADRAO SQL USUARIO/FUNCIONARIO
function TFormListaTelefone.PadraoSQL: Boolean;
begin
   dm.ADOQusuario.SQL.Clear;
   dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, usina.cd_usina, usina.ds_usina' +
                               '   FROM usuario, usina' +
                               '   WHERE usuario.cd_usina = usina.cd_usina' +
                               '   ORDER BY ds_usina, ds_nome');
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;

end;
//TO-DO FILTRO SQL LISTAFUNCIONARIO
procedure TFormListaTelefone.dbcbFuncionarioClick(Sender: TObject);
begin
  inherited;
   dm.ADOQlistafone.SQL.Clear;
   dm.ADOQlistafone.SQL.Text := ('SELECT rownum col, a.* FROM (SELECT listafone.ds_nome, listafone.cd_numero' +
                                 '   FROM listafone, usuario, usina' +
                                 '   WHERE usuario.cd_matricula = listafone.cd_matricula AND' +
                                 '      listafone.cd_usina = usina.cd_usina AND' +
                                 '      usuario.cd_usina = usina.cd_usina AND' +
                                 '      usuario.cd_usina = :cd_usina AND' +
                                 '      usuario.cd_matricula = :cd_matricula' +
                                 '   ORDER BY listafone.ds_nome) a');
   dm.ADOQlistafone.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQlistafone.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbFuncionario.KeyValue);
   dm.ADOQlistafone.Open;
   dbgListaTelefone.Enabled := True;
   CountSQL;

   //EXIVE NUMERO:
   dm.ADOQSQL.SQL.Clear;
   dm.ADOQSQL.SQL.Text := ('SELECT cd_numero FROM agenda ' +
                           '   WHERE cd_matricula = :cd_matricula AND' +
                           '      cd_usina = :cd_usina');
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbFuncionario.KeyValue);
   dm.ADOQSQL.Open;
   edtNumero.Text := dm.ADOQSQL.FieldByName('cd_numero').AsString;
   lblregistro.Caption := 'Registro: ' + IntToStr(qtde);
end;

procedure TFormListaTelefone.dbcbUnidadeClick(Sender: TObject);
begin
  inherited;
   dbcbFuncionario.Enabled := True;
   dbcbFuncionario.KeyValue := -1;
   edtNumero.Clear;
   dm.ADOQlistafone.Close; 
end;
//TO-DO COUNT SQL LISTAFONE
function TFormListaTelefone.CountSQL: Boolean;
begin
   dm.ADOQSQL.SQL.Clear;
   dm.ADOQSQL.SQL.Text := ('SELECT COUNT(listafone.cd_numero) cd_qtde' +
                           '   FROM listafone, usuario, usina' +
                           '   WHERE usuario.cd_matricula = listafone.cd_matricula AND' +
                           '      listafone.cd_usina = usina.cd_usina AND' +
                           '      usuario.cd_usina = usina.cd_usina AND' +
                           '      usina.cd_usina = :cd_usina AND' +
                           '      usuario.cd_matricula = :cd_matricula');
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbFuncionario.KeyValue);
   dm.ADOQSQL.Open;
   qtde := dm.ADOQSQL.FieldByName('cd_qtde').AsInteger;
end;
//TO-DO DELETE SQL LISTAFONE
function TFormListaTelefone.DeleteSQL: Boolean;
begin
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   if (trim(mkedtNumero.Text) = '') and (Trim(edtNome.Text) = '') then
      begin
         exit;
      end else
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM listafone WHERE cd_numero = :cd_numero AND' +
                                 '   cd_usina = :cd_usina AND' +
                                 '   cd_matricula = :cd_matricula');
         dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := mkedtNumero.Text;
         dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
         dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbFuncionario.KeyValue);
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido.', mtInformation, [mbOK], 0);
      end;
   Atualizar;
   if btnGravar.Enabled = False then
      btnGravar.Enabled := True;
   if btnExcluir.Enabled = False then
      btnExcluir.Enabled := True;
end;

procedure TFormListaTelefone.btnExcluirNumeroClick(Sender: TObject);
begin
  inherited;
   DeleteSQL;
   CountSQL;
   lblregistro.Caption := 'Registro: ' + IntToStr(qtde);
end;

procedure TFormListaTelefone.dbgListaTelefoneCellClick(Column: TColumn);
begin
  inherited;
   mkedtNumero.Text := dm.ADOQlistafone.FieldByName('cd_numero').AsString;
   edtNome.Text := dm.ADOQlistafone.FieldByName('ds_nome').AsString;
end;

procedure TFormListaTelefone.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   if (Trim(dbcbUnidade.Text) = '') AND (trim(dbcbFuncionario.Text) = '') then
      begin
         MessageDlg('Selecione o funcionário.', mtInformation, [mbOK], 0);
         Exit;
      end else
      begin
         dm.ADOQlistafone.Open;
         FormRelListaTelefone := TFormRelListaTelefone.Create(Application);
         FormRelListaTelefone.rlrRelatorio.Preview();
      end;
end;

procedure TFormListaTelefone.btnPin2Click(Sender: TObject);
var PIN2, MAT: String;

begin
  inherited;
   if dbcbFuncionario.Text = '' then
      begin
         MessageDlg('Usuário não selecionado.',mtInformation, [mbOK], 0);
         exit;
      end;
           dm.ADOQSQL.SQL.Clear;
           dm.ADOQSQL.SQL.Text := ('SELECT chip.cd_pin2 as pin2, usuario.cd_matricula as mat FROM usuario, chip, agenda, usina' +
                                   '   WHERE chip.cd_numero = agenda.cd_numero AND' +
                                   '      chip.cd_usina = usina.cd_usina AND' +
                                   '      usuario.cd_usina = usina.cd_usina AND' +
                                   '      agenda.cd_matricula = usuario.cd_matricula AND' +
                                   '      usina.cd_usina = :cd_usina AND' +
                                   '      usuario.cd_matricula = :cd_matricula');
           dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbFuncionario.KeyValue);
           dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
           dm.ADOQSQL.Open;
   MAT := dm.ADOQSQL.FieldByName('mat').AsString;
   PIN2 := dm.ADOQSQL.FieldBYName('pin2').AsString;
   MessageDlg('PIN2: '+MAT+PIN2,mtInformation, [mbOK], 0);
end;

function TFormListaTelefone.Acesso: Boolean;
begin
   {if FormLogin.ac = 2 then
      begin
         btnInserir.Enabled := False;
         btnExcluirNumero.Enabled := False;
         btnGravar.Enabled := False;
         btnExcluir.Enabled := False;
         btnPin2.Enabled := False;
      end;}
end;

procedure TFormListaTelefone.dbgListaTelefoneKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
mkedtNumero.Text := dm.ADOQlistafone.FieldByName('cd_numero').AsString;
   edtNome.Text := dm.ADOQlistafone.FieldByName('ds_nome').AsString;
end;

end.
