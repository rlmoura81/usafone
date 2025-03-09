unit untEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, ComCtrls, Menus, Grids, DBGrids, ExtCtrls,
  StdCtrls, Buttons, DB, Mask, DBCtrls, ADODB;

type
  TFormEstoque = class(TFormPadrao)
    mmEstoque: TMainMenu;
    Voltar1: TMenuItem;
    pnlCampos: TPanel;
    dbgEstoque: TDBGrid;
    pnlControlGeral: TPanel;
    pnlControl: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnRelatorio: TBitBtn;
    dsAparelhos: TDataSource;
    edtCodigo: TLabeledEdit;
    edtOperadora: TLabeledEdit;
    edtMarca: TLabeledEdit;
    edtModelo: TLabeledEdit;
    edtQtde: TLabeledEdit;
    edtNumNF: TLabeledEdit;
    edtData: TMaskEdit;
    lblDtNF: TLabel;
    edtQtdeRetirada: TLabeledEdit;
    edtDataRetirada: TMaskEdit;
    lblDtRetirada: TLabel;
    dbcbUsuario: TDBLookupComboBox;
    lblUsuarioRetirada: TLabel;
    btnRegistrar: TBitBtn;
    procedure Voltar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnRegistrarClick(Sender: TObject);
    procedure edtQtdeRetiradaKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdeRetiradaExit(Sender: TObject);
    procedure edtDataRetiradaKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure dbgEstoqueCellClick(Column: TColumn);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
  private
  function Validar: Boolean;
  function InsertSQL: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEstoque: TFormEstoque;

implementation

uses untDM, untAcesso, untRelEstoque, untLogin, untPrincipal;

{$R *.dfm}

procedure TFormEstoque.Voltar1Click(Sender: TObject);
begin
  inherited;
   if btnGravar.Enabled = True then
      begin
         MessageDlg('O registro não foi salvo.', mtInformation, [mbOK], 0);
         exit;
      end;
   if btnGravar.Enabled = False then
      close;
end;

procedure TFormEstoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;

   //TO-DO PADRAO SQL ACESSO
   begin
      dm.ADOQacesso.SQL.Clear;
      dm.ADOQacesso.SQL.Text := 'select usuario.ds_nome, usuario.cd_matricula, acesso.cd_acesso' +
                                '   from usuario, acesso' +
                                '   where acesso.cd_matricula = usuario.cd_matricula and ' +
                                '      acesso.cd_matricula = acesso.cd_matricula' +
                                '   order by usuario.ds_nome'
   end;

end;

procedure TFormEstoque.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   dm.ADOusafone.IsolationLevel := ilReadCommitted;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
   dm.ADOQaparelho.Open;
   dm.ADOQacesso.Open;
   edtDataRetirada.Text := DateToStr(Now);
   edtQtdeRetirada.SetFocus;

   //TO-DO FILTRO SQL ACESSO ADM
   begin
      dm.ADOQacesso.Close;
      dm.ADOQacesso.SQL.Clear;
      dm.ADOQacesso.SQL.Text := 'SELECT usuario.ds_nome, usuario.cd_matricula, acesso.cd_acesso ' +
                                '   FROM usuario, acesso ' +
                                '   WHERE acesso.cd_acesso = 0 and ' +
                                '      acesso.cd_matricula = usuario.cd_matricula and ' +
                                '      acesso.cd_matricula = acesso.cd_matricula ' +
                                '   ORDER BY usuario.ds_nome';
      dm.ADOQacesso.Open;
   end;

end;
//TO-DO VALIDAR RETIRADA
function TFormEstoque.Validar: Boolean;
begin
   Result := False;
   if trim(edtCodigo.Text) = '' then
      begin
         MessageDlg('Selecione o aparelho a ser retirado.', mtInformation, [mbOK], 0);
         dbgEstoque.SetFocus;
         exit;
      end else
   if trim(edtQtdeRetirada.Text) = '' then
      begin
         MessageDlg('Digite a quantidade a ser retirada.', mtInformation, [mbOK], 0);
         edtQtdeRetirada.SetFocus;
         exit;
      end else
   if StrToDate(edtDataRetirada.Text) > Now then
      begin
         MessageDlg('Data inválida.'#13'Digite a data da retirada.', mtInformation, [mbOK], 0);
         edtDataRetirada.SetFocus;
         exit;
      end else
   if trim(dbcbUsuario.Text) = '' then
      begin
         MessageDlg('Selecione o usuario.', mtInformation, [mbOK], 0);
         dbcbUsuario.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormEstoque.btnRegistrarClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   if StrToInt(edtQtde.Text) = 0 then
      begin
         MessageDlg('Não há aparelhos disponíveis.', mtWarning, [mbOK], 0);
         exit;
      end else
      begin
         InsertSQL;
      end;
end;

procedure TFormEstoque.edtQtdeRetiradaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      edtDataRetirada.SetFocus;
end;

procedure TFormEstoque.edtQtdeRetiradaExit(Sender: TObject);
begin
  inherited;
   if trim(edtQtdeRetirada.Text) = '' then
      begin
         exit;
      end else
   if StrToInt(edtQtdeRetirada.Text) <= 0 then
      begin
         MessageDlg('Quantidade inválida.', mtError, [mbOK], 0);
         edtQtdeRetirada.SetFocus;
         exit;
      end else
   if StrToIntDef(edtQtdeRetirada.Text, -1) = -1 then
      begin
         MessageDlg('Somente números.', mtError, [mbOK], 0);
         edtQtdeRetirada.SetFocus;
         exit;
      end;
end;

procedure TFormEstoque.edtDataRetiradaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbUsuario.SetFocus;
end;

procedure TFormEstoque.dbcbUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnRegistrar.SetFocus;
end;

procedure TFormEstoque.dbgEstoqueCellClick(Column: TColumn);
begin
  inherited;
   edtCodigo.Text := dm.ADOQaparelho.FieldByName('cd_aparelho').AsString;
   edtMarca.Text := dm.ADOQaparelho.FieldByName('ds_marca').AsString;
   edtModelo.Text := dm.ADOQaparelho.FieldByName('ds_modelo').AsString;
   edtOperadora.Text := dm.ADOQaparelho.FieldByName('ds_operadora').AsString;
   edtQtde.Text := dm.ADOQaparelho.FieldByName('qtde').AsString;
   edtNumNF.Text := dm.ADOQaparelho.FieldByName('nota_fiscal').AsString;
   edtData.Text := dm.ADOQaparelho.FieldByName('dt_data').AsString;
end;
//TO-DO INSERT SQL ESTOQUE
function TFormEstoque.InsertSQL: Boolean;
begin
   if StrToInt(edtQtdeRetirada.Text) > StrToInt(edtQtde.Text) then
      begin
         MessageDlg('Quantidade a ser retirada não disponivel.', mtError, [mbOK], 0);
         edtQtdeRetirada.SetFocus;
         exit;
      end;
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO estoque (cd_estoque, cd_aparelho, cd_matricula, qtde, ds_data, id_user)' +
                                 '   VALUES (s_estoque.nextval, :cd_aparelho, :cd_matricula, :qtde, :ds_data)');
      end;
         dm.ADOQSQL.Parameters.ParamByName('cd_aparelho').Value := edtCodigo.Text;
         dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbUsuario.KeyValue);
         dm.ADOQSQL.Parameters.ParamByName('qtde').Value := edtQtdeRetirada.Text;
         dm.ADOQSQL.Parameters.ParamByName('ds_data').Value := StrToDate(edtDataRetirada.Text);
         dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
         dm.ADOQSQL.ExecSQL;
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE aparelho SET qtde = qtde - :qtde WHERE cd_aparelho = :cd_aparelho, id_user = :id_user');
         dm.ADOQSQL.Parameters.ParamByName('qtde').Value := edtQtdeRetirada.Text;
         dm.ADOQSQL.Parameters.ParamByName('cd_aparelho').Value := edtCodigo.Text;
         dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
         dm.ADOQSQL.ExecSQL;
      end;
      btnGravar.Enabled := True;
      btnCancelar.Enabled := True;
      //limpa campos do pnlCampos
      edtCodigo.Clear;
      edtOperadora.Clear;
      edtMarca.Clear;
      edtModelo.Clear;
      edtQtde.Clear;
      edtNumNF.Clear;
      edtData.Clear;
      //atualiza dbgAparelho
      dm.ADOQaparelho.Close;
      dm.ADOQaparelho.Open;
      //limpa campos do pnlControl
      edtQtdeRetirada.Clear;
      edtDataRetirada.Clear;
      dbcbUsuario.KeyValue := -1;
end;

procedure TFormEstoque.btnGravarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.CommitTrans;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
   //atualiza dbgAparelho
   dm.ADOQaparelho.Close;
   dm.ADOQaparelho.Open;
end;

procedure TFormEstoque.btnCancelarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.RollbackTrans;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
   //atualiza dbgAparelho
   dm.ADOQaparelho.Close;
   dm.ADOQaparelho.Open;
end;

procedure TFormEstoque.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   dm.ADOQestoque.Close;
   dm.ADOQestoque.Open;
   FormRelEstoque := TFormRelEstoque.Create(Application);
   FormRelEstoque.rlrRelatorio.Preview();
end;

end.
