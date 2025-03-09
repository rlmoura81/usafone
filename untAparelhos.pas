unit untAparelhos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, ComCtrls, Menus, StdCtrls, ADODB, DBCtrls, ExtCtrls,
  Mask, Buttons, Grids, DBGrids;

type
  TFormAparelhos = class(TFormPadrao)
    mmAparelhos: TMainMenu;
    Voltar1: TMenuItem;
    pnlCampos: TPanel;
    edtCodigo: TLabeledEdit;
    dbcbMarca: TDBLookupComboBox;
    lblMarca: TLabel;
    dbcbModelo: TDBLookupComboBox;
    lblModelo: TLabel;
    edtQuantidade: TEdit;
    lblQuantidade: TLabel;
    mkEditDataNF: TMaskEdit;
    lblDataNF: TLabel;
    pnlControl: TPanel;
    btnInserir: TBitBtn;
    btnExcluirAparelho: TBitBtn;
    dbgAparelhos: TDBGrid;
    btnAlterar: TBitBtn;
    pnlControlGeral: TPanel;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnRelatorio: TBitBtn;
    dbcbOperadora: TDBLookupComboBox;
    lblOperadora: TLabel;
    Novo1: TMenuItem;
    procedure Voltar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbcbMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbModeloKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumNtFiscalKeyPress(Sender: TObject; var Key: Char);
    procedure btnInserirClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtNumNtFiscalExit(Sender: TObject);
    procedure dbcbMarcaExit(Sender: TObject);
    procedure dbcbMarcaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbcbOperadoraKeyPress(Sender: TObject; var Key: Char);
    procedure dbgAparelhosCellClick(Column: TColumn);
    procedure btnExcluirAparelhoClick(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure dbcbOperadoraClick(Sender: TObject);
  private
  function Validar: Boolean;
  function InsertSQL: Boolean;
  function FiltroSQL: Boolean;
  function Atualizar: Boolean;
  function Formnovo: Boolean;
  function TravaCampos: Boolean;
  function PadraoSQL: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAparelhos: TFormAparelhos;

implementation

uses untDM, untModelo, DB, untRelAparelho, untLogin, untPrincipal;

{$R *.dfm}

procedure TFormAparelhos.Voltar1Click(Sender: TObject);
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

procedure TFormAparelhos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;
   FormModelo.PadraoSQL;
   PadraoSQL;
end;

procedure TFormAparelhos.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   Formnovo;
   btnGravar.Enabled := False;
   btnExcluir.Enabled := False;
   btnAlterar.Enabled := False;
   btnExcluirAparelho.Enabled := False;
   dm.ADOusafone.IsolationLevel := ilReadCommitted;   
end;

procedure TFormAparelhos.dbcbMarcaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if (key = #13) and (dbcbModelo.Enabled = True) then
      dbcbModelo.SetFocus;
end;

procedure TFormAparelhos.dbcbModeloKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      edtQuantidade.SetFocus;
end;

procedure TFormAparelhos.edtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      mkEditDataNF.SetFocus;
end;

procedure TFormAparelhos.edtNumNtFiscalKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      mkEditDataNF.SetFocus;
end;
//TO-DO VALIDAR FORMULARIO APARELHOS
function TFormAparelhos.Validar: Boolean;
begin
   Result := False;
   if trim(dbcbOperadora.Text) = '' then
      begin
         MessageDlg('Selecione a operadora.', mtInformation, [mbOK], 0);
         dbcbOperadora.SetFocus;
      end else
   if trim(dbcbMarca.Text) = '' then
      begin
         MessageDlg('Selecione a marca.', mtInformation, [mbOK], 0);
         dbcbMarca.SetFocus;
         exit;
      end else
   if trim(dbcbModelo.Text) = '' then
      begin
         MessageDlg('Selecione o modelo.', mtInformation, [mbOK], 0);
         dbcbModelo.SetFocus;
         exit;
      end else
   if trim(edtQuantidade.Text) = '' then
      begin
         MessageDlg('Digite a quantidade.', mtInformation, [mbOK], 0);
         edtQuantidade.SetFocus;
         exit;
      end else
   if StrToDate(mkEditDataNF.Text) > Now then
      begin
         MessageDlg('Data inválida.'#13'Digite a data da nota.', mtInformation, [mbOK], 0);
         mkEditDataNF.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormAparelhos.btnInserirClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   InsertSQL;
   MessageDlg('Aparelho cadastrado com sucesso.', mtInformation, [mbOK], 0);
   Formnovo;
   if btnGravar.Enabled = False then
      btnGravar.Enabled := True;
   if btnExcluir.Enabled = False then
      btnExcluir.Enabled := True;
end;

procedure TFormAparelhos.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
   if Trim(edtQuantidade.Text) = '' then
      begin
         exit;
      end else
   if StrToIntDef(edtQuantidade.Text, -1) = -1 then
      begin
         MessageDlg('Somente números.', mtError, [mbOK], 0);
         edtQuantidade.SetFocus;
         exit;
      end;
end;

procedure TFormAparelhos.edtNumNtFiscalExit(Sender: TObject);
begin
  inherited;

end;
//TO-DO FILTRO SQL MODELO
function TFormAparelhos.FiltroSQL: Boolean;
begin
   dm.ADOQmodelo.SQL.Clear;
   dm.ADOQmodelo.SQL.Text := ('SELECT modelo.*, marca.* FROM modelo, marca' +
                              '   WHERE modelo.cd_marca = marca.cd_marca AND' +
                              '         marca.cd_marca = :cd_marca' +
                              '   ORDER BY ds_modelo');
   dm.ADOQmodelo.Parameters.ParamByName('cd_marca').Value := StrToInt(dbcbMarca.KeyValue);
   dm.ADOQmodelo.Close;
   dm.ADOQmodelo.Open;
end;

procedure TFormAparelhos.dbcbMarcaExit(Sender: TObject);
begin
  inherited;
   if trim(dbcbMarca.Text) = '' then
      begin
         exit;
      end else
   FiltroSQL;
end;

procedure TFormAparelhos.dbcbMarcaClick(Sender: TObject);
begin
  inherited;
   dbcbModelo.Enabled := True;
   dbcbOperadora.Enabled := True;
   edtQuantidade.Enabled := True;
end;
//TO-DO INSERTSQL APARELHOS
function TFormAparelhos.InsertSQL: Boolean;
begin
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO aparelho (cd_aparelho, qtde, dt_data, cd_marca, cd_modelo, cd_operadora, id_user)' +
                                 '   VALUES (s_aparelho.nextval, :qtde, :dt_data, :cd_marca, :cd_modelo, :cd_operadora, :id_user)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE aparelho SET qtde = :qtde, dt_data = :dt_data, cd_marca = :cd_marca, cd_modelo = :cd_modelo, cd_operadora = :cd_operadora, id_user = :id_user' +
                                 '   WHERE cd_aparelho = :cd_aparelho');
         dm.ADOQSQL.Parameters.ParamByName('cd_aparelho').Value := edtCodigo.Text;
      end;
   dm.ADOQSQL.Parameters.ParamByName('qtde').Value := edtQuantidade.Text;
   dm.ADOQSQL.Parameters.ParamByName('dt_data').Value := StrToDate(mkEditDataNF.Text);
   dm.ADOQSQL.Parameters.ParamByName('cd_operadora').Value := StrToInt(dbcbOperadora.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_marca').Value := StrToInt(dbcbMarca.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_modelo').Value := StrToInt(dbcbModelo.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   Atualizar;
end;

procedure TFormAparelhos.btnAlterarClick(Sender: TObject);
begin
  inherited;
   tag := 2;
   InsertSQL;
   MessageDlg('Aparelho alterado com sucesso.', mtInformation, [mbOK], 0);
   Formnovo;
   if btnGravar.Enabled = False then
      btnGravar.Enabled := True;
   if btnExcluir.Enabled = False then
      btnExcluir.Enabled := True;
end;

procedure TFormAparelhos.dbcbOperadoraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbMarca.SetFocus;
end;

procedure TFormAparelhos.dbgAparelhosCellClick(Column: TColumn);
begin
  inherited;
   TravaCampos;
   dm.ADOQmodelo.SQL.Clear;
   dm.ADOQmodelo.SQL.Text := ('SELECT modelo.cd_modelo, marca.cd_marca, marca.ds_marca, modelo.ds_modelo' +
                              '   FROM modelo, marca' +
                              '   WHERE modelo.cd_marca = marca.cd_marca' +
                              '   ORDER BY cd_modelo');
   dm.ADOQmodelo.Close;
   dm.ADOQmodelo.Open;

   edtCodigo.Text := dm.ADOQaparelho.FieldByName('cd_aparelho').AsString;
   dbcbMarca.KeyValue := dm.ADOQaparelho.FieldByName('cd_marca').AsString;
   dbcbModelo.KeyValue := dm.ADOQaparelho.FieldByName('cd_modelo').AsInteger;
   dbcbOperadora.KeyValue := dm.ADOQaparelho.FieldByName('cd_operadora').AsInteger;
   edtQuantidade.Text := dm.ADOQaparelho.FieldByName('qtde').AsString;
   mkEditDataNF.Text := dm.ADOQaparelho.FieldByName('dt_data').AsString;
   FiltroSQL;
end;

procedure TFormAparelhos.btnExcluirAparelhoClick(Sender: TObject);
begin
  inherited;
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   if edtCodigo.Text = '' then
      begin
         exit;
      end else
   if MessageDlg('Deseja realmente excluir as informações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM aparelho WHERE cd_aparelho = :cd_aparelho');
         dm.ADOQSQL.Parameters.ParamByName('cd_aparelho').Value := edtCodigo.Text;
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
   Atualizar;
   if btnGravar.Enabled = False then
      btnGravar.Enabled := True;
   if btnExcluir.Enabled = False then
      btnExcluir.Enabled := True;
end;
//TO-DO FUNCAO ATUALIZAR GRID APARELHO
function TFormAparelhos.Atualizar: Boolean;
begin
   dm.ADOQaparelho.Close;
   dm.ADOQaparelho.Open;
end;
//TO-DO FUNCAO FORMNOVO APARELHO
function TFormAparelhos.Formnovo: Boolean;
begin
   tag := 1;
   dbcbOperadora.SetFocus;
   edtCodigo.Clear;
   dbcbMarca.KeyValue := -1;
   dbcbModelo.KeyValue := -1;
   dbcbOperadora.KeyValue := -1;
   edtQuantidade.Clear;
   dbcbModelo.Enabled := False;
   edtQuantidade.Enabled := False;
   mkEditDataNF.Text := DateToStr(Now);
end;

procedure TFormAparelhos.Novo1Click(Sender: TObject);
begin
  inherited;
   Formnovo;
   PadraoSQL;
end;

procedure TFormAparelhos.btnGravarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.CommitTrans;
   Atualizar;
   btnGravar.Enabled := False;
   btnExcluir.Enabled := False;
   PadraoSQL;
end;

procedure TFormAparelhos.btnExcluirClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.RollbackTrans;
   Atualizar;
   btnGravar.Enabled := False;
   btnExcluir.Enabled := False;
end;
//TO-DO FUNCAO PARA DESTRAVAR CAMPOS E BOTOES
function TFormAparelhos.TravaCampos: Boolean;
begin
//ATIVACAO DOS CAMPOS
   dbcbModelo.Enabled := True;
   dbcbOperadora.Enabled := True;
   edtQuantidade.Enabled := True;

//ATIVACAO DOS BOTOES
   btnAlterar.Enabled := True;
   btnExcluirAparelho.Enabled := True;
end;

procedure TFormAparelhos.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   if dbcbOperadora.Text = '' then
      begin
         MessageDlg('Selecione a operadora.', mtInformation, [mbOK], 0);
         dbcbOperadora.SetFocus;
         exit;
      end;
         dm.ADOQaparelho.Open;
         FormRelAparelhos := TFormRelAparelhos.Create(Application);
         FormRelAparelhos.rlrRelatorio.Preview();
end;

procedure TFormAparelhos.dbcbOperadoraClick(Sender: TObject);
begin
  inherited;
//FILTRO APARELHO POR OPERADORA
   dm.ADOQaparelho.SQL.Clear;
   dm.ADOQaparelho.SQL.Text := ('SELECT aparelho.cd_aparelho, aparelho.cd_modelo, aparelho.cd_operadora, marca.cd_marca, marca.ds_marca, modelo.ds_modelo, operadora.ds_operadora, aparelho.qtde, aparelho.dt_data' +
                                '   FROM aparelho, marca, modelo, operadora' +
                                '   WHERE aparelho.cd_modelo = modelo.cd_modelo and' +
                                '         modelo.cd_marca = marca.cd_marca and' +
                                '         aparelho.cd_operadora = operadora.cd_operadora and' +
                                '         operadora.cd_operadora = :cd_operadora' +
                                '   ORDER BY marca.ds_marca, modelo.ds_modelo');
   dm.ADOQaparelho.Parameters.ParamByName('cd_operadora').Value := StrToInt(dbcbOperadora.KeyValue);
   dm.ADOQaparelho.Close;
   dm.ADOQaparelho.Open;
end;
//FUNCAO PADRAO SQL APARELHOS
function TFormAparelhos.PadraoSQL: Boolean;
begin
   dm.ADOQaparelho.SQL.Clear;
   dm.ADOQaparelho.SQL.Text := ('SELECT aparelho.cd_aparelho, aparelho.cd_modelo, aparelho.cd_operadora, marca.cd_marca, marca.ds_marca, modelo.ds_modelo, operadora.ds_operadora, aparelho.qtde, aparelho.dt_data' +
                                '   FROM aparelho, marca, modelo, operadora' +
                                '   WHERE aparelho.cd_modelo = modelo.cd_modelo and' +
                                '      modelo.cd_marca = marca.cd_marca and' +
                                '      aparelho.cd_operadora = operadora.cd_operadora' +
                                '   ORDER BY marca.ds_marca, modelo.ds_modelo');
   dm.ADOQaparelho.Close;
   dm.ADOQaparelho.Open;
end;

end.
