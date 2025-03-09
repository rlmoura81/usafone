unit untGasto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, Menus, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Grids, DBGrids, Buttons, Mask, ADODB;

type
  TFormGasto = class(TFormPadrao)
    pnlCampos: TPanel;
    mmGasto: TMainMenu;
    Voltar1: TMenuItem;
    dbcbUnidade: TDBLookupComboBox;
    lblUnidade: TLabel;
    lblNumero: TLabel;
    mkEditDataref: TMaskEdit;
    Label1: TLabel;
    dbcbNumero: TDBLookupComboBox;
    btnInserir: TBitBtn;
    lblValor: TLabel;
    dbgGasto: TDBGrid;
    pnlControl: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnRelatorio: TBitBtn;
    edtValor: TEdit;
    btnExcluir: TBitBtn;
    procedure dbcbUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure mkEditDatarefKeyPress(Sender: TObject; var Key: Char);
    procedure mkeditValorKeyPress(Sender: TObject; var Key: Char);
    procedure btnInserirKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Voltar1Click(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure dbcbUnidadeClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure mkEditDatarefExit(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure dbgGastoCellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
  private
     va_data :String;
     function Validar: Boolean;
     function SQLPadrao: Boolean;
     function SQLInsert: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGasto: TFormGasto;

implementation

uses untDM, untPrincipal, DB, untRelGasto, untLogin;

{$R *.dfm}

procedure TFormGasto.dbcbUnidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      mkEditDataref.SetFocus;
end;

procedure TFormGasto.dbcbNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtValor.SetFocus;
end;

procedure TFormGasto.mkEditDatarefKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   dbcbNumero.Enabled := True;
   if key = #13 then
      dbcbNumero.SetFocus;
end;

procedure TFormGasto.mkeditValorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnInserir.SetFocus;
end;

procedure TFormGasto.btnInserirKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnInserir.Click;
end;
//TO-DO FUNCAO VALIDAR GASTOS
function TFormGasto.Validar: Boolean;
begin
   Result := False;
   if Trim(dbcbUnidade.Text) = '' then
      begin
         MessageDlg('Selecione a unidade.', mtInformation, [mbOK], 0);
         dbcbUnidade.SetFocus;
         exit;
      end else
   if StrToDate(mkEditDataref.Text) > Now then
      begin
         MessageDlg('Data superior ao dia atual.', mtInformation, [mbOK], 0);
         mkEditDataref.SetFocus;
         exit;
      end else
   if Trim(dbcbNumero.Text) = '' then
      begin
         MessageDlg('Selecione o número.', mtInformation, [mbOK], 0);
         dbcbNumero.SetFocus;
         exit;
      end else
   if Trim(edtValor.Text) = '' then
      begin
         MessageDlg('Digite o valor.', mtInformation, [mbOK], 0);
         edtValor.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormGasto.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   dm.ADOusafone.IsolationLevel := ilReadCommitted;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
   btnRelatorio.Enabled := False;
   dbcbNumero.Enabled := False;
   dm.ADOQgasto.Close;
   dm.ADOQchip.Close;
   dbcbUnidade.SetFocus;
end;

procedure TFormGasto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;
   SQLPadrao;
end;

procedure TFormGasto.Voltar1Click(Sender: TObject);
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

procedure TFormGasto.btnInserirClick(Sender: TObject);
begin
  inherited;
//TO-DO INSERT GASTO
   if not Validar then
      exit;
   SQLInsert;

   dbcbNumero.KeyValue := -1;
   edtValor.Clear;
   dbcbNumero.SetFocus;
end;

procedure TFormGasto.dbcbUnidadeClick(Sender: TObject);
begin
  inherited;
   dm.ADOQagenda.SQL.Clear;
   dm.ADOQagenda.SQL.Text := ('SELECT usuario.ds_nome, agenda.cd_matricula, agenda.cd_numero FROM agenda, usina, usuario' +
                              '   WHERE agenda.cd_usina = usina.cd_usina AND' +
                              '         usuario.cd_matricula = agenda.cd_matricula AND' +
                              '         usina.cd_usina = :cd_usina' +
                              '   ORDER BY agenda.cd_numero');
   dm.ADOQagenda.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQagenda.Close;
   dm.ADOQagenda.Open;
end;
//TO-DO PADRAO SQL
function TFormGasto.SQLPadrao: Boolean;
begin
//TO-DO PADRAO AGENDA
   dm.ADOQagenda.SQL.Clear;
   dm.ADOQagenda.SQL.Text := ('select usuario.ds_nome, agenda.cd_numero, chip.cd_pin2, operadora.ds_operadora, marca.ds_marca, agenda.cd_aparelho, modelo.ds_modelo' +
                              '   from usina, agenda, usuario, modelo, aparelho, operadora, chip, marca' +
                              '   where agenda.cd_usina = usina.cd_usina and' +
                              '         agenda.cd_matricula = usuario.cd_matricula and' +
                              '         agenda.cd_aparelho = aparelho.cd_aparelho and' +
                              '         aparelho.cd_modelo = modelo.cd_modelo and' +
                              '         aparelho.cd_marca = marca.cd_marca and' +
                              '         aparelho.cd_operadora = operadora.cd_operadora and' +
                              '         agenda.cd_numero = chip.cd_numero' +
                              '   order by usuario.ds_nome');
   dm.ADOQagenda.Close;
   //dm.ADOQagenda.Open;
end;

procedure TFormGasto.btnGravarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.CommitTrans;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
   dm.ADOQgasto.Close;

   dbcbUnidade.KeyValue := -1;
   mkEditDataref.Clear;
   dbcbNumero.KeyValue := -1;
   edtValor.Clear;
   dbcbNumero.Enabled := False;
   btnRelatorio.Enabled := False;
   dbcbUnidade.SetFocus;
end;

procedure TFormGasto.btnCancelarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.RollbackTrans;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
   dm.ADOQgasto.Close;

   dbcbUnidade.KeyValue := -1;
   mkEditDataref.Clear;
   dbcbNumero.KeyValue := -1;
   edtValor.Clear;
   dbcbNumero.Enabled := False;
   btnRelatorio.Enabled := False;
   dbcbUnidade.SetFocus;
end;

function TFormGasto.SQLInsert: Boolean;
begin
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   try
//      va_data :=  ('01/'+mkEditDataref.Text);
      dm.ADOQSQL.SQL.Text := ('INSERT INTO gasto (cd_usina, cd_numero, dt_referencia, vl_mes, id_user)' +
                              '   VALUES (:cd_usina, :cd_numero, :dt_referencia, :vl_mes, :id_user)');
      dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
      dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := StrToFloat(dbcbNumero.KeyValue);
      dm.ADOQSQL.Parameters.ParamByName('dt_referencia').Value := StrToDate(mkEditDataref.Text);
//      dm.ADOQSQL.Parameters.ParamByName('dt_referencia').Value := StrToDate(va_data);
      dm.ADOQSQL.Parameters.ParamByName('vl_mes').Value := StrToFloat(edtValor.Text);
      dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
      dm.ADOQSQL.ExecSQL;
      dm.ADOQgasto.Close;
      dm.ADOQgasto.Open;

      btnGravar.Enabled := True;
      btnCancelar.Enabled := True;

   Except
      MessageDlg('Já existe valor para a data ' + mkEditDataref.Text, mtError, [mbOK], 0);
   end;
end;

procedure TFormGasto.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnInserir.SetFocus;
end;

procedure TFormGasto.mkEditDatarefExit(Sender: TObject);
begin
  inherited;
   try
      StrToDate(mkEditDataref.Text);
   except
      MessageDlg('Data inválida', mtError, [mbOK], 0);
      mkEditDataref.SetFocus;
      exit;
   end;
   dm.ADOQgasto.SQL.Clear;
   dm.ADOQgasto.SQL.Text := ('SELECT usuario.ds_nome, gasto.cd_numero, gasto.dt_referencia, gasto.vl_mes' +
                             '   FROM gasto, usuario, agenda' +
                             '   WHERE usuario.cd_matricula = agenda.cd_matricula AND ' +
                             '      usuario.cd_usina = agenda.cd_usina AND ' +
                             '      gasto.cd_numero = agenda.cd_numero AND ' +
                             '      gasto.dt_referencia = :dt_referencia AND ' +
                             '      gasto.cd_usina = agenda.cd_usina AND ' +
                             '      agenda.cd_usina = :cd_usina' +
                             '   ORDER BY cd_numero');
   dm.ADOQgasto.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQgasto.Parameters.ParamByName('dt_referencia').Value := StrToDate(mkEditDataref.Text);
   dm.ADOQgasto.Close;
   dm.ADOQgasto.Open;
   
   if btnRelatorio.Enabled = False then
   btnRelatorio.Enabled := True;
end;

procedure TFormGasto.edtValorExit(Sender: TObject);
var vl:String;
begin
  inherited;
   if StrToFloatDef(edtValor.Text, -1) = -1 then
      begin
         MessageDlg('Somente números.', mtError, [mbOK], 0);
         edtValor.SetFocus;
         exit;
      end else
   if StrToFloat(edtValor.Text) < 0 then
      begin
         MessageDlg('Valor menor que zero(0) não permitido.', mtError, [mbOK], 0);
         edtValor.SetFocus;
         exit;
      end;
   //edtValor.Text := FormatFloat('R$ #,##0.00',StrToFloat(edtValor.Text));
end;

procedure TFormGasto.dbgGastoCellClick(Column: TColumn);
begin
  inherited;
   dbcbNumero.KeyValue := dm.ADOQgasto.FieldByName('cd_numero').AsString;
   edtValor.Text := dm.ADOQgasto.FieldByName('vl_mes').AsString;
end;

procedure TFormGasto.btnExcluirClick(Sender: TObject);
begin
  inherited;
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   dm.ADOQSQL.SQL.Text := ('DELETE FROM gasto WHERE dt_referencia = :dt_referencia AND cd_numero = :cd_numero');
   dm.ADOQSQL.Parameters.ParamByName('dt_referencia').Value := StrToDate(mkEditDataref.Text);
   dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := StrToFloat(dbcbNumero.KeyValue);
   dm.ADOQSQL.ExecSQL;
   dm.ADOQgasto.Close;
   dm.ADOQgasto.Open;
   btnGravar.Enabled := True;
   btnCancelar.Enabled := True;
   MessageDlg('Exclusão efetuada com sucesso.', mtInformation, [mbOK],0);
   dbcbNumero.KeyValue := -1;
   edtValor.Clear;
   dbcbNumero.SetFocus;
end;

procedure TFormGasto.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   if dbcbUnidade.Text = '' then
      begin
         MessageDlg('Selecione a unidade.', mtInformation, [mbOK], 0);
         dbcbUnidade.SetFocus;
         exit;
      end;
      dm.ADOQgasto.Open;
      dm.ADOQusuario.Open;
      dm.ADOQusina.Open;
      dm.ADOQagenda.Open;
      FormRelGasto := TFormRelGasto.Create(Application);
      FormRelGasto.rlrRelatorio.Preview();
end;

end.
