unit untBlackberry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, Grids, DBGrids, ExtCtrls, Menus, ComCtrls,
  StdCtrls, DBCtrls, Buttons, ADODB, Mask;

type
  TFormBlackberry = class(TFormPadrao)
    mmBlackberry: TMainMenu;
    Voltar1: TMenuItem;
    pnlCampos: TPanel;
    dbgBlackberry: TDBGrid;
    pnlBotoes: TPanel;
    edtCargo: TEdit;
    edtNumero: TEdit;
    edtModelo: TEdit;
    lblCargo: TLabel;
    lblUnidade: TLabel;
    lblNumero: TLabel;
    lblModelo: TLabel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    BitBtn1: TBitBtn;
    pnlBotoesControl: TPanel;
    edtImei: TEdit;
    lblIMEI: TLabel;
    lblPIN: TLabel;
    edtPin: TEdit;
    btnRegistrar: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    edtUnidade: TEdit;
    dbgAgenda: TDBGrid;
    edtFuncionario: TEdit;
    lblFuncionario: TLabel;
    lblBBreg: TLabel;
    lblfunBB: TLabel;
    Novo1: TMenuItem;
    lblTotal: TLabel;
    procedure Voltar1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRegistrarClick(Sender: TObject);
    procedure edtImeiExit(Sender: TObject);
    procedure edtPinExit(Sender: TObject);
    procedure edtPinChange(Sender: TObject);
    procedure dbcbFuncionarioClick(Sender: TObject);
    procedure dbcbFuncionarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtImeiKeyPress(Sender: TObject; var Key: Char);
    procedure edtPinKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbgBlackberryCellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dbgAgendaCellClick(Column: TColumn);
    procedure Novo1Click(Sender: TObject);
  private
     qtde: Integer;
     function Validar: Boolean;
     function FiltroBB: Boolean;
     function TravaRegistro: Boolean;
     function InsertSQL: Boolean;
     function CountBB: Boolean;
     function Novo: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBlackberry: TFormBlackberry;

implementation

uses untPrincipal, untDM, DB, untRelBlackberry, untLogin;

{$R *.dfm}

procedure TFormBlackberry.Voltar1Click(Sender: TObject);
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

procedure TFormBlackberry.FormShow(Sender: TObject);
begin
  inherited;
   tag := 1;
   dm.ADOQblackberry.Open;
   dm.ADOusafone.IsolationLevel := ilReadCommitted;
   FormPrincipal.Hide;
   dbgAgenda.SetFocus;
   TravaRegistro;
   FiltroBB;
   CountBB;
end;

procedure TFormBlackberry.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQblackberry.Close;
   FormPrincipal.Show;
   Action := caFree;
end;

procedure TFormBlackberry.btnRegistrarClick(Sender: TObject);
begin
  inherited;
   Validar;
   InsertSQL;
   btnGravar.Enabled := True;
   btnCancelar.Enabled := True;
   MessageDlg('Registro do aparelho concluido.', mtInformation, [mbOK], 0);
   CountBB;
   edtFuncionario.Clear;
   edtCargo.Clear;
   edtUnidade.Clear;
   edtNumero.Clear;
   edtModelo.Clear;
   edtImei.Clear;
   edtPin.Clear;
   FiltroBB;
end;

//TO-DO FUNCAO VALIDAR IMEI/PIN
function TFormBlackberry.Validar: Boolean;
begin
   Result := False;
   if Trim(edtImei.Text) = '' then
      begin
         MessageDlg('Digite o IMEI do aparelho.', mtInformation, [mbOK], 0);
         edtImei.SetFocus;
         exit;
      end else
   if Trim(edtPin.Text) = '' then
      begin
          MessageDlg('Digite o PIN do aparelho.', mtInformation, [mbOK], 0);
          edtPin.SetFocus;
          exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormBlackberry.edtImeiExit(Sender: TObject);
begin
  inherited;
   if edtImei.Text = '' then
      exit;
   if StrToFloatDef(edtImei.Text, -1) = -1 then
      begin
         MessageDlg('Somente números.', mtError, [mbOK], 0);
         edtImei.SetFocus;
         exit;
      end else
   if Length(edtImei.Text) <> 15 then
      begin
         MessageDlg('Número IMEI inválido.'#13'Digite o IMEI com 15 dígitos.', mtError, [mbOK], 0);
         edtImei.SetFocus;
         exit;
      end;
end;

procedure TFormBlackberry.edtPinExit(Sender: TObject);
begin
  inherited;
   if edtPin.Text = '' then
      exit;
   if Length(edtPin.Text) <> 8 then
      begin
         MessageDlg('Código PIN inválido.'#13'Digite o PIN com 08 dígitos.', mtError, [mbOK], 0);
         edtPin.SetFocus;
         exit;
      end
end;

procedure TFormBlackberry.edtPinChange(Sender: TObject);
begin
  inherited;
   btnRegistrar.Enabled := True;
   btnAlterar.Enabled := True;
   btnExcluir.Enabled := True;
end;

procedure TFormBlackberry.dbcbFuncionarioClick(Sender: TObject);
begin
  inherited;

end;

//TO-DO FUNCAO FILTRO BB
function TFormBlackberry.FiltroBB: Boolean;
begin
   dm.ADOQagenda.SQL.Clear;
   dm.ADOQagenda.SQL.Text := ('SELECT usuario.cd_usina, usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, usina.ds_usina, agenda.cd_numero, modelo.ds_modelo' +
                              '   FROM usuario, agenda, marca, modelo, aparelho, usina' +
                              '   WHERE usuario.cd_matricula = agenda.cd_matricula and' +
                              '      usina.cd_usina = agenda.cd_usina and' +
                              '      usina.cd_usina = usuario.cd_usina and' +
                              '      usuario.cd_usina = agenda.cd_usina and' +
                              '      aparelho.cd_aparelho = agenda.cd_aparelho and' +
                              '      aparelho.cd_marca = marca.cd_marca and' +
                              '      aparelho.cd_modelo = modelo.cd_modelo and' +
                              '      marca.cd_marca = 7' +
                              '   ORDER BY usuario.ds_nome');
   dm.ADOQagenda.Close;
   dm.ADOQagenda.Open;
end;

procedure TFormBlackberry.dbcbFuncionarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      edtImei.SetFocus;
end;

procedure TFormBlackberry.edtImeiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtPin.SetFocus;
end;

procedure TFormBlackberry.edtPinKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnRegistrar.SetFocus;
end;

procedure TFormBlackberry.btnAlterarClick(Sender: TObject);
begin
  inherited;
   btnGravar.Enabled := True;
   btnCancelar.Enabled := True;

   if edtImei.Text <> dm.ADOQblackberry.FieldByName('cd_imei').AsString then
     begin
        MessageDlg('Registro não existente.', mtError, [mbOK], 0);
        exit;
     end;
     
   InsertSQL;
   MessageDlg('Registro do aparelho alterado.', mtInformation, [mbOK], 0);
   CountBB;
end;

//TO-DO FUNCAO TRAVA REGISTRO
function TFormBlackberry.TravaRegistro: Boolean;
begin
   edtCargo.Clear;
   edtUnidade.Clear;
   edtNumero.Clear;
   edtModelo.Clear;
   edtImei.Clear;
   edtPin.Clear;
   pnlBotoesControl.Enabled := False;
   edtImei.Color := clBtnFace;
   edtPin.Color := clBtnFace;
   btnRegistrar.Enabled := False;
   btnAlterar.Enabled := False;
   btnExcluir.Enabled := False;
   btnGravar.Enabled := False;
   btnCancelar.Enabled := False;
end;

procedure TFormBlackberry.btnGravarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.CommitTrans;
   TravaRegistro;
   MessageDlg('Registro salvo com sucesso.', mtInformation, [mbOK], 0);
   dm.ADOQblackberry.Close;
   dm.ADOQblackberry.Open;
end;

procedure TFormBlackberry.btnCancelarClick(Sender: TObject);
begin
  inherited;
   dm.ADOusafone.RollbackTrans;
   TravaRegistro;
   dm.ADOQblackberry.Close;
   dm.ADOQblackberry.Open;
end;

procedure TFormBlackberry.dbgBlackberryCellClick(Column: TColumn);
begin
  inherited;
   tag := 2;
   edtFuncionario.Text := dm.ADOQblackberry.FieldByName('ds_nome').AsString;
   edtCargo.Text := dm.ADOQblackberry.FieldByName('ds_cargo').AsString;
   edtUnidade.Text := dm.ADOQblackberry.FieldByName('ds_usina').AsString;
   edtNumero.Text := dm.ADOQblackberry.FieldByName('cd_numero').AsString;
   edtModelo.Text := dm.ADOQblackberry.FieldByName('ds_modelo').AsString;
   edtImei.Text := dm.ADOQblackberry.FieldByName('cd_imei').AsString;
   edtPin.Text := dm.ADOQblackberry.FieldByName('cd_pin').AsString;
   pnlBotoesControl.Enabled := True;
end;

//TO-DO INSERT SLQ BLACKBERRY
function TFormBlackberry.InsertSQL: Boolean;
var cd_mat, cd_us: Integer;
begin
   cd_mat := dm.ADOQagenda.FieldByName('cd_matricula').Value;
   cd_us := dm.ADOQagenda.FieldByName('cd_usina').Value;

   if not dm.ADOusafone.InTransaction then
      dm.ADOusafone.BeginTrans;
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO blackberry (cd_matricula, cd_usina, cd_imei, cd_pin, id_user)' +
                                 '   VALUES (:cd_matricula, :cd_usina, :cd_imei, :cd_pin, :id_user)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE blackberry SET cd_matricula = :cd_matricula, cd_usina = :cd_usina, id_user = :id_user' +
                                 '   WHERE cd_imei = :cd_imei AND cd_pin = :cd_pin');
         edtImei.Enabled := False;
         edtPin.Enabled := False;
      end;
   dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := cd_mat;
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := cd_us;
   dm.ADOQSQL.Parameters.ParamByName('cd_imei').Value := edtImei.Text;
   dm.ADOQSQL.Parameters.ParamByName('cd_pin').Value := edtPin.Text;
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   dm.ADOQblackberry.Close;
   dm.ADOQblackberry.Open;
end;

procedure TFormBlackberry.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if not dm.ADOusafone.InTransaction then
     dm.ADOusafone.BeginTrans;
  if edtImei.Text <> dm.ADOQblackberry.FieldByName('cd_imei').AsString then
     begin
        MessageDlg('Registro não existente.', mtError, [mbOK], 0);
        exit;
     end;
  if MessageDlg('Deseja realmente excluir as informações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin
        dm.ADOQSQL.SQL.Clear;
        dm.ADOQSQL.SQL.Text := ('DELETE FROM blackberry WHERE cd_imei = :cd_imei AND cd_pin = :cd_pin');
        dm.ADOQSQL.Parameters.ParamByName('cd_imei').Value := edtImei.Text;
        dm.ADOQSQL.Parameters.ParamByName('cd_pin').Value := edtPin.Text;
        dm.ADOQSQL.ExecSQL;
        MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
     end;
        dm.ADOQblackberry.Close;
        dm.ADOQblackberry.Open;
        CountBB;
        Novo;
        btnGravar.Enabled := True;
        btnCancelar.Enabled := True;
end;

//TO-DO COUNT BB
function TFormBlackberry.CountBB: Boolean;
begin
   dm.ADOQSQL.SQL.Clear;
   dm.ADOQSQL.SQL.Text := ('SELECT COUNT(*)qtde FROM blackberry');
   dm.ADOQSQL.Open;
   lblTotal.Caption := 'Total: ' + IntToStr(dm.ADOQSQL.FieldByName('qtde').AsInteger);

end;

procedure TFormBlackberry.BitBtn1Click(Sender: TObject);
begin
  inherited;
   dm.ADOQblackberry.Open;
   FormRelBlackberry := TFormRelBlackberry.Create(Application);
   FormRelBlackberry.rlrRelatorio.Preview();
end;

procedure TFormBlackberry.dbgAgendaCellClick(Column: TColumn);
begin
  inherited;
   pnlBotoesControl.Enabled := True;
   edtImei.Color := clWindow;
   edtPin.Color := clWindow;
   edtFuncionario.Text := dbgAgenda.Fields[0].AsString;
   begin
      dm.ADOQagenda.SQL.Clear;
      dm.ADOQagenda.SQL.Text := ('SELECT usuario.cd_usina, usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, usina.ds_usina, agenda.cd_numero, modelo.ds_modelo' +
                                 '   FROM usuario, agenda, marca, modelo, aparelho, usina' +
                                 '   WHERE usuario.cd_matricula = agenda.cd_matricula and' +
                                 '      usuario.ds_nome like :ds_nome and' +
                                 '      usina.cd_usina = agenda.cd_usina and' +
                                 '      usina.cd_usina = usuario.cd_usina and' +
                                 '      usuario.cd_usina = agenda.cd_usina and' +
                                 '      aparelho.cd_aparelho = agenda.cd_aparelho and' +
                                 '      aparelho.cd_marca = marca.cd_marca and' +
                                 '      aparelho.cd_modelo = modelo.cd_modelo and' +
                                 '      marca.cd_marca = 7' +
                                 '   ORDER BY usuario.ds_nome');
      dm.ADOQagenda.Parameters.ParamByName('ds_nome').Value := edtFuncionario.Text;
      dm.ADOQagenda.Close;
      dm.ADOQagenda.Open;
   end;
      edtCargo.Text := dm.ADOQagenda.FieldByName('ds_cargo').AsString;
      edtUnidade.Text :=  dm.ADOQagenda.FieldByName('ds_usina').AsString;
      edtNumero.Text := dm.ADOQagenda.FieldByName('cd_numero').AsString;
      edtModelo.Text := dm.ADOQagenda.FieldByName('ds_modelo').AsString;
end;

//TO-DO FORMULARIO NOVO
function TFormBlackberry.Novo: Boolean;
begin
   edtFuncionario.Clear;
   edtCargo.Clear;
   edtUnidade.Clear;
   edtNumero.Clear;
   edtModelo.Clear;
   edtImei.Clear;
   edtPin.Clear;
   FiltroBB;
end;

procedure TFormBlackberry.Novo1Click(Sender: TObject);
begin
  inherited;
   Novo;
   TravaRegistro;
end;

end.
