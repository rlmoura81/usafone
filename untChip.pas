unit untChip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, Menus, ComCtrls, ADODB, DBCtrls, ExtCtrls, StdCtrls,
  Mask, Buttons, Grids, DBGrids;

type
  TFormChip = class(TFormPadrao)
    mmChip: TMainMenu;
    Voltar1: TMenuItem;
    pnlCampos: TPanel;
    mkedtNumero: TMaskEdit;
    lblNumero: TLabel;
    edtIMEI: TLabeledEdit;
    edtPin2: TLabeledEdit;
    dbcbOperadora: TDBLookupComboBox;
    lblOperadora: TLabel;
    dbcbUnidade: TDBLookupComboBox;
    lblUnidade: TLabel;
    pnlControl: TPanel;
    btnInserir: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluirChip: TBitBtn;
    dbgChip: TDBGrid;
    pnlControlGeral: TPanel;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnRelatorio: TBitBtn;
    Novo1: TMenuItem;
    mkedtNumeroLocalizar: TMaskEdit;
    btnLocalizar: TBitBtn;
    cbStatus: TComboBox;
    lblstatus: TLabel;
    btnUsuario: TBitBtn;
    lblLinhasUnidade: TLabel;
    lblLinhasAtivas: TLabel;
    lblTotalLinhas: TLabel;
    lblTotalAtivas: TLabel;
    procedure Voltar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbcbUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure mkedtNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure edtIMEIKeyPress(Sender: TObject; var Key: Char);
    procedure edtPin2KeyPress(Sender: TObject; var Key: Char);
    procedure dbcbOperadoraKeyPress(Sender: TObject; var Key: Char);
    procedure btnInserirClick(Sender: TObject);
    procedure edtIMEIExit(Sender: TObject);
    procedure edtPin2Exit(Sender: TObject);
    procedure mkedtNumeroExit(Sender: TObject);
    procedure dbgChipCellClick(Column: TColumn);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnExcluirChipClick(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure dbcbUnidadeExit(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure dbcbUnidadeClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure cbStatusKeyPress(Sender: TObject; var Key: Char);
    procedure cbStatusClick(Sender: TObject);
    procedure mkedtNumeroLocalizarKeyPress(Sender: TObject; var Key: Char);
    procedure btnUsuarioClick(Sender: TObject);
  private
  function Validar: Boolean;
  function TravaBotoes: Boolean;
  function InsertSQL: Boolean;
  function FiltroSQL: Boolean;
  function PadraoSQL: Boolean;
  function Atualizar: Boolean;
  function Formnovo: Boolean;
  function LinhasUnidade: Boolean;
  function LinhasTotal: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormChip: TFormChip;

implementation

uses untDM, DB, untRelChip, untLogin, untPrincipal;

{$R *.dfm}

procedure TFormChip.Voltar1Click(Sender: TObject);
begin
  inherited;
   if btnGravar.Enabled = True then
      begin
         if MessageDlg('As alterações não foram salvas.'#13'Sair sem salvar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            close;
      end;
   if btnGravar.Enabled = False then
      close;
end;

procedure TFormChip.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   action := caFree;
   PadraoSQL;
end;

procedure TFormChip.dbcbUnidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      cbStatus.SetFocus;
end;

procedure TFormChip.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   tag := 1;
   dbcbUnidade.SetFocus;
   cbStatus.Enabled := False;
   TravaBotoes;
   dm.ADOusafone.IsolationLevel := ilReadCommitted;
   PadraoSQL;
   LinhasTotal;
end;

procedure TFormChip.mkedtNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtIMEI.SetFocus;
end;

procedure TFormChip.edtIMEIKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtPin2.SetFocus;
end;

procedure TFormChip.edtPin2KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbOperadora.SetFocus;
end;

procedure TFormChip.dbcbOperadoraKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnInserir.SetFocus;
end;
//TO-DO VALIDAR FORMULARIO CHIP's
function TFormChip.Validar: Boolean;
begin
   Result := False;
   if Trim(dbcbUnidade.Text) = '' then
      begin
         MessageDlg('Selecione a unidade.', mtInformation, [mbOK], 0);
         dbcbUnidade.SetFocus;
         exit;
      end else
   if trim(mkedtNumero.Text) = '' then
      begin
         MessageDlg('Digite o numero do telefone.', mtInformation, [mbOK], 0);
         mkedtNumero.SetFocus;
         exit;
      end else
   if trim(edtIMEI.Text) = '' then
      begin
         MessageDlg('Digite o IMEI do chip.', mtInformation, [mbOK], 0);
         edtIMEI.SetFocus;
         exit;
      end else
   if trim(dbcbOperadora.Text) = '' then
      begin
         MessageDlg('Selecione a operadora.', mtInformation, [mbOK], 0);
         dbcbOperadora.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormChip.btnInserirClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   MessageDlg('CHIP cadastrado.', mtInformation, [mbOK], 0);
   InsertSQL;
   LinhasUnidade;
   LinhasTotal;
   Formnovo;
   if btnGravar.Enabled = False then
      btnGravar.Enabled := True;
   if btnExcluir.Enabled = False then
      btnExcluir.Enabled := True;
end;

procedure TFormChip.edtIMEIExit(Sender: TObject);
var text: String;
begin
  inherited;
   text := edtIMEI.Text;
   if trim(edtIMEI.Text) = '' then
      begin
         exit;
      end else
   if StrToFloatDef(edtIMEI.Text, -1) = -1 then
      begin
         MessageDlg('Somente números.', mtError, [mbOK], 0);
         edtIMEI.SetFocus;
         exit;
      end else
   if Length(text) <> 20 then
      begin
         MessageDlg('Número IMEI inválido.'#13'Digite o IMEI com 20 dígitos.', mtError, [mbOK], 0);
         edtIMEI.SetFocus;
         exit;
      end;
end;

procedure TFormChip.edtPin2Exit(Sender: TObject);
var text: String;
begin
  inherited;
   text := edtPin2.Text;
   if trim(edtPin2.Text) = '' then
      begin
         exit;
      end else
   if StrToIntDef(edtPin2.Text, -1) = -1 then
      begin
         MessageDlg('Somente números.', mtError, [mbOK], 0);
         edtPin2.SetFocus;
         exit;
      end else
   if Length(text) <> 4 then
      begin
         MessageDlg('Número PIN2 inválido.'#13'Digite o PIN2 com 4 dígitos.', mtError, [mbOK], 0);
         edtPin2.SetFocus;
         exit;
      end;
end;

procedure TFormChip.mkedtNumeroExit(Sender: TObject);
var text:String;
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
//TO-DO FUNCAO PARA TRAVAR OS BOTOES
function TFormChip.TravaBotoes: Boolean;
begin
   btnAlterar.Enabled := False;
   btnExcluirChip.Enabled := False;
   btnGravar.Enabled := False;
   btnExcluir.Enabled := False;
end;
//TO-DO INSERT CHIP
function TFormChip.InsertSQL: Boolean;
begin
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO chip (cd_usina, cd_numero, cd_imei, cd_pin2, cd_operadora, id_user, st_chip)' +
                                 '   VALUES (:cd_usina, :cd_numero, :cd_imei, :cd_pin2, :cd_operadora, :id_user, :st_chip)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE chip SET cd_imei = :cd_imei, cd_pin2 = :cd_pin2, cd_usina = :cd_usina, cd_operadora = :cd_operadora, id_user = :id_user, st_chip = :st_chip' +
                                 '   WHERE cd_numero = :cd_numero');
      end;
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := mkedtNumero.Text;
   dm.ADOQSQL.Parameters.ParamByName('cd_imei').Value := edtIMEI.Text;
   dm.ADOQSQL.Parameters.ParamByName('cd_pin2').Value := edtPin2.Text;
   dm.ADOQSQL.Parameters.ParamByName('cd_operadora').Value := StrToInt(dbcbOperadora.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.Parameters.ParamByName('st_chip').Value := cbStatus.Text[1];
   dm.ADOQSQL.ExecSQL;
   Atualizar;
end;
//TO-DO ATUALIZAR GRID CHIP
function TFormChip.Atualizar: Boolean;
begin
   dm.ADOQchip.Close;
   dm.ADOQchip.Open;
end;

procedure TFormChip.dbgChipCellClick(Column: TColumn);
begin
  inherited;
   dbcbUnidade.KeyValue := dm.ADOQchip.FieldByName('cd_usina').AsString;
   mkedtNumero.Text := dm.ADOQchip.FieldByName('cd_numero').AsString;
   edtIMEI.Text := dm.ADOQchip.FieldByName('cd_imei').AsString;
   edtPin2.Text := dm.ADOQchip.FieldByName('cd_pin2').AsString;
   dbcbOperadora.KeyValue := dm.ADOQchip.FieldByName('cd_operadora').AsString;
   if dm.ADOQchip.FieldByName('st_chip').AsString = 'A' then
      cbStatus.ItemIndex := 0
      else
   if dm.ADOQchip.FieldByName('st_chip').AsString = 'E' then
      cbStatus.ItemIndex := 1
      else
   if dm.ADOQchip.FieldByName('st_chip').AsString = 'I' then
      cbStatus.ItemIndex := 2;
   cbStatus.Enabled := True;
   btnAlterar.Enabled := True;
   btnExcluirChip.Enabled := True;
end;

procedure TFormChip.btnAlterarClick(Sender: TObject);
begin
  inherited;
   tag := 2;
   InsertSQL;
   Formnovo;
   MessageDlg('CHIP alterado com sucesso.', mtInformation, [mbOK], 0);
   if btnGravar.Enabled = False then
      btnGravar.Enabled := True;
   if btnExcluir.Enabled = False then
      btnExcluir.Enabled := True;
end;

procedure TFormChip.btnGravarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.CommitTrans;
   Atualizar;
   btnGravar.Enabled := False;
   btnExcluir.Enabled := False;
   cbStatus.Enabled := False;
   PadraoSQL;
end;

procedure TFormChip.btnExcluirClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.RollbackTrans;
   Atualizar;
   btnGravar.Enabled := False;
   btnExcluir.Enabled := False;
   PadraoSQL;
end;

procedure TFormChip.btnExcluirChipClick(Sender: TObject);
begin
  inherited;
   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   if MessageDlg('Deseja realmente excluir as informações?', mtConfirmation, [mbYes, mbNO], 0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM chip WHERE cd_numero = :cd_numero');
         dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := mkedtNumero.Text;
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
   Atualizar;
   LinhasUnidade;
   LinhasTotal;
   if btnGravar.Enabled = False then
      btnGravar.Enabled := True;
   if btnExcluir.Enabled = False then
      btnExcluir.Enabled := True;
end;
//TO-DO FUNCAO FORM NOVO
function TFormChip.Formnovo: Boolean;
begin
   dbcbUnidade.KeyValue := -1;
   cbStatus.ItemIndex := -1;
   mkedtNumero.Clear;
   edtIMEI.Clear;
   edtPin2.Clear;
   dbcbOperadora.KeyValue := -1;
   dbcbUnidade.SetFocus;
   TravaBotoes;
   mkedtNumeroLocalizar.Clear;
end;

procedure TFormChip.Novo1Click(Sender: TObject);
begin
  inherited;
   PadraoSQL;
   Formnovo;
end;
//TO-DO FILTRO SQL CHIP
function TFormChip.FiltroSQL: Boolean;
begin
   dm.ADOQchip.SQL.Clear;
   dm.ADOQchip.SQL.Text := ('SELECT usina.cd_usina, usina.ds_usina, chip.cd_numero, chip.cd_imei, chip.cd_pin2, chip.cd_operadora, operadora.ds_operadora, chip.st_chip' +
                            '   FROM chip, operadora, usina' +
                            '   WHERE chip.cd_operadora = operadora.cd_operadora AND' +
                            '      usina.cd_usina = chip.cd_usina AND' +
                            '      chip.cd_usina = :cd_usina' +
                            '   ORDER BY chip.cd_usina, chip.cd_numero');
   dm.ADOQchip.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQchip.Close;
   dm.ADOQchip.Open;
end;

procedure TFormChip.dbcbUnidadeExit(Sender: TObject);
begin
  inherited;
   if dbcbUnidade.Text = '' then
      exit;
end;
//TO-DO FUNCAO PADRAO SQL CHIP
function TFormChip.PadraoSQL: Boolean;
begin
   dm.ADOQchip.SQL.Clear;
   dm.ADOQchip.SQL.Text := ('SELECT chip.cd_usina, usina.ds_usina, chip.cd_numero, chip.cd_imei, chip.cd_pin2, chip.cd_operadora, operadora.ds_operadora, chip.st_chip' +
                            '   FROM chip, usina, operadora' +
                            '   WHERE chip.cd_usina = usina.cd_usina AND' +
                            '      chip.cd_operadora = operadora.cd_operadora' +
                            '   ORDER BY chip.cd_usina, chip.cd_numero');
   dm.ADOQchip.Close;
   dm.ADOQchip.Open;

end;

procedure TFormChip.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   dm.ADOQchip.Open;
   FormRelChip := TFormRelChip.Create(Application);
   FormRelChip.rlrRelatorio.Preview();
end;

procedure TFormChip.dbcbUnidadeClick(Sender: TObject);
begin
  inherited;
   FiltroSQL;
   LinhasUnidade;
   cbStatus.Enabled := True;
   cbStatus.ItemIndex := -1;
   mkedtNumero.Clear;
   edtIMEI.Clear;
   edtPin2.Clear;
   dbcbOperadora.KeyValue := -1;
   dbcbUnidade.SetFocus;
end;

procedure TFormChip.btnLocalizarClick(Sender: TObject);
begin
  inherited;
   if trim(mkedtNumeroLocalizar.Text) = '' then
      begin
         MessageDlg('Digite o numero do telefone.', mtInformation, [mbOK], 0);
         mkedtNumeroLocalizar.SetFocus;
         exit;
      end;
   dm.ADOQchip.SQL.Clear;
   dm.ADOQchip.SQL.Text := ('SELECT chip.cd_usina, usina.ds_usina, chip.cd_numero, chip.cd_imei, chip.cd_pin2, chip.cd_operadora, operadora.ds_operadora, chip.st_chip' +
                            '   FROM chip, usina, operadora' +
                            '   WHERE chip.cd_usina = usina.cd_usina AND' +
                            '      chip.cd_operadora = operadora.cd_operadora AND' +
                            '      chip.cd_numero = :cd_numero');
   dm.ADOQchip.Parameters.ParamByName('cd_numero').Value := mkedtNumeroLocalizar.Text;
   dm.ADOQchip.Close;
   dm.ADOQchip.Open;

   dbcbUnidade.KeyValue := -1;
   cbStatus.ItemIndex := -1;
   mkedtNumero.Clear;
   edtIMEI.Clear;
   edtPin2.Clear;
   dbcbOperadora.KeyValue := -1;
   dbcbUnidade.SetFocus;
   TravaBotoes;
end;

procedure TFormChip.cbStatusKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      mkedtNumero.SetFocus;
end;

procedure TFormChip.cbStatusClick(Sender: TObject);
begin
  inherited;
   dm.ADOQchip.SQL.Clear;
   dm.ADOQchip.SQL.Text := ('SELECT usina.cd_usina, usina.ds_usina, chip.cd_numero, chip.cd_imei, chip.cd_pin2, chip.cd_operadora, operadora.ds_operadora, chip.st_chip' +
                            '   FROM chip, operadora, usina' +
                            '   WHERE chip.cd_operadora = operadora.cd_operadora AND' +
                            '      usina.cd_usina = chip.cd_usina AND' +
                            '      chip.cd_usina = :cd_usina AND' +
                            '      chip.st_chip = :st_chip' +
                            '   ORDER BY chip.cd_usina, chip.cd_numero');
   dm.ADOQchip.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQchip.Parameters.ParamByName('st_chip').Value := cbStatus.Text[1];
   dm.ADOQchip.Close;
   dm.ADOQchip.Open;
end;

procedure TFormChip.mkedtNumeroLocalizarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      btnLocalizar.Click;
end;

procedure TFormChip.btnUsuarioClick(Sender: TObject);
begin
  inherited;
   if Trim(mkedtNumero.Text) = '' then
      begin
         MessageDlg('Selecione um número', mtInformation, [mbOK], 0);
         dbgChip.SetFocus;
         Exit;
      end else
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo' +
                                 '   FROM usuario, chip, agenda ' +
                                 '   WHERE usuario.cd_matricula = agenda.cd_matricula AND' +
                                 '   chip.cd_numero = agenda.cd_numero AND' +
                                 '   chip.cd_numero = :cd_numero');
         dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := mkedtNumero.Text;
         dm.ADOQSQL.Open;
         MessageDlg('Matricula: ' + dm.ADOQSQL.FieldByName('cd_matricula').AsString +
                   #13 + 'Nome: ' + dm.ADOQSQL.FieldByName('ds_nome').AsString +
                  #13 + 'Cargo: ' + dm.ADOQSQL.FieldByName('ds_cargo').AsString, mtInformation, [mbOK], 0);
      end;
end;

//TO-DO LINHAS POR UNIDADE:
function TFormChip.LinhasUnidade: Boolean;
var linhaunid: Integer;
    linhaativ: Integer;
begin
   dm.ADOQSQL.SQL.Clear;
   dm.ADOQSQL.SQL.Text := ('SELECT COUNT(*) linhaunidade FROM chip WHERE cd_usina = :cd_usina');
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQSQL.Open;
   linhaunid := dm.ADOQSQL.FieldByName('linhaunidade').AsInteger;
   lblLinhasUnidade.Caption := 'Linhas Unidade: ' + IntToStr(linhaunid);

   dm.ADOQSQL.SQL.Clear;
   dm.ADOQSQL.SQL.Text := ('SELECT COUNT(*) linhaativa FROM chip WHERE cd_usina = :cd_usina AND st_chip = :st_chip');
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('st_chip').Value := 'A';
   dm.ADOQSQL.Open;
   linhaativ := dm.ADOQSQL.FieldByName('linhaativa').AsInteger;
   lblLinhasAtivas.Caption := 'Linhas Ativas: ' + IntToStr(linhaativ);
end;

//TO-DO TOTAL DE LINHAS
function TFormChip.LinhasTotal: Boolean;
begin
   dm.ADOQSQL.SQL.Clear;
   dm.ADOQSQL.SQL.Text := ('SELECT COUNT(*) total FROM chip');
   dm.ADOQSQL.Open;
   lblTotalLinhas.Caption := 'Total de Linhas: ' + IntToStr(dm.ADOQSQL.FieldByName('total').AsInteger);

   dm.ADOQSQL.SQL.Clear;
   dm.ADOQSQL.SQL.Text := ('SELECT COUNT(*) totalativo FROM chip WHERE st_chip = :st_chip');
   dm.ADOQSQL.Parameters.ParamByName('st_chip').Value := 'A';
   dm.ADOQSQL.Open;
   lblTotalAtivas.Caption := 'Linhas ativas: ' + IntToStr(dm.ADOQSQL.FieldByName('totalativo').AsInteger);
end;

end.
