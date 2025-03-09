unit untAgenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, Menus, ComCtrls, StdCtrls, DBCtrls, ExtCtrls,
  Grids, DBGrids, Buttons;

type
  TFormAgenda = class(TFormPadrao)
    mmAgenda: TMainMenu;
    Voltar1: TMenuItem;
    pnlCamposFuncionario: TPanel;
    dbcbFuncionario: TDBLookupComboBox;
    lblFuncionario: TLabel;
    lblUnidade: TLabel;
    dbcbUnidade: TDBLookupComboBox;
    dbcbNumero: TDBLookupComboBox;
    lblNumero: TLabel;
    dbcbOperadoraChip: TDBLookupComboBox;
    lblOperadoraChip: TLabel;
    dbgAgenda: TDBGrid;
    pnlControl: TPanel;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnRelatorio: TBitBtn;
    btnVerlista: TBitBtn;
    edtLocalizarUsuario: TEdit;
    btnLocalizar: TBitBtn;
    pnlCamposAparelho: TPanel;
    dbcbAparelho: TDBLookupComboBox;
    lblAparelho: TLabel;
    lblOperadoraAparelho: TLabel;
    dbcbMarca: TDBLookupComboBox;
    lblMarca: TLabel;
    dbcbOperadoraAparelho: TDBLookupComboBox;
    Panel1: TPanel;
    btnTransferir: TBitBtn;
    dbcbFuncionarioTransferencia: TDBLookupComboBox;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Voltar1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbcbUnidadeClick(Sender: TObject);
    procedure dbcbOperadoraChipClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgAgendaCellClick(Column: TColumn);
    procedure btnVerlistaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure dbcbUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbFuncionarioKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbOperadoraChipKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbAparelhoKeyPress(Sender: TObject; var Key: Char);
    procedure btnLocalizarClick(Sender: TObject);
    procedure edtLocalizarUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure dbcbOperadoraAparelhoClick(Sender: TObject);
    procedure dbcbMarcaClick(Sender: TObject);
    procedure dbcbNumeroClick(Sender: TObject);
    procedure dbcbOperadoraAparelhoKeyPress(Sender: TObject;
      var Key: Char);
    procedure dbcbMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure btnTransferirClick(Sender: TObject);
    procedure dbcbFuncionarioClick(Sender: TObject);
  private
  function Validar: Boolean;
  function InsertSQL: Boolean;
  function PadraoSQL: Boolean;
  function Acesso: Boolean;
  function LocalizarSQL: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAgenda: TFormAgenda;

implementation

uses untDM, untListaTelefone, Math, DB, untRelAgenda, untLogin, DateUtils,
  untPrincipal;

{$R *.dfm}

procedure TFormAgenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;
   PadraoSQL;
end;

procedure TFormAgenda.Voltar1Click(Sender: TObject);
begin
  inherited;
   close;
end;

procedure TFormAgenda.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   tag := 1;
   Acesso;
   dbcbUnidade.SetFocus;
   dbcbFuncionario.Enabled := False;
   dbcbOperadoraChip.Enabled := False;
   dbcbNumero.Enabled := False;
   dbcbOperadoraAparelho.Enabled := False;
   dbcbMarca.Enabled := False;
   dbcbAparelho.Enabled := False;
   btnTransferir.Enabled := False;
   dbcbFuncionarioTransferencia.Enabled := False;
   dm.ADOQagenda.Close;
end;

procedure TFormAgenda.dbcbUnidadeClick(Sender: TObject);
begin
  inherited;
   dbcbFuncionario.KeyValue := -1;
   dbcbOperadoraChip.KeyValue := -1;
   dbcbNumero.KeyValue := -1;
   dbcbAparelho.KeyValue := -1;
   dbcbOperadoraAparelho.KeyValue := -1;
   dbcbMarca.KeyValue := -1;
   dbcbAparelho.KeyValue := -1;
//TO-DO FILTRO SQL USUARIO/UNIDADE
//BEGIN
   dm.ADOQusuario.SQL.Clear;
   dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome' +
                               '   FROM usuario, usina' +
                               '   WHERE usuario.cd_usina = usina.cd_usina AND' +
                               '      usina.cd_usina = :cd_usina' +
                               '   ORDER BY usuario.ds_nome');
   dm.ADOQusuario.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;
//END
   dbcbFuncionario.Enabled := True;

//TO-DO FILTRO SQL USUARIO/UNIDADE DBGAGENDA
//BEGIN
   dm.ADOQagenda.SQL.Clear;
   dm.ADOQagenda.SQL.Text := ('SELECT usina.cd_usina, usuario.cd_matricula, usuario.ds_nome, agenda.cd_numero, chip.cd_pin2, operadora.cd_operadora, operadora.ds_operadora, marca.cd_marca, marca.ds_marca, modelo.cd_modelo, modelo.ds_modelo, aparelho.cd_aparelho' +
                              '   FROM agenda, usuario, modelo, aparelho, operadora, chip, marca, usina' +
                              '   WHERE agenda.cd_usina = usina.cd_usina AND' +
                              '      agenda.cd_matricula = usuario.cd_matricula AND' +
                              '      agenda.cd_aparelho = aparelho.cd_aparelho AND' +
                              '      aparelho.cd_modelo = modelo.cd_modelo AND' +
                              '      aparelho.cd_marca = marca.cd_marca AND' +
                              '      aparelho.cd_operadora = operadora.cd_operadora AND' +
                              '      agenda.cd_numero = chip.cd_numero AND' +
                              '      usuario.cd_usina = usina.cd_usina AND' +
                              '      usina.cd_usina = :cd_usina' +
                              '   ORDER BY usuario.ds_nome');
   dm.ADOQagenda.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQagenda.Close;
   dm.ADOQagenda.Open;
//END
end;

procedure TFormAgenda.dbcbOperadoraChipClick(Sender: TObject);
begin
  inherited;
//TO-DO FILTRO SQL OPERADORA/CHIP
//BEGIN
   dm.ADOQchip.SQL.Clear;
   dm.ADOQchip.SQL.Text := ('SELECT chip.cd_numero' +
                            '   FROM chip, operadora, usina' +
                            '   WHERE chip.cd_operadora = operadora.cd_operadora AND' +
                            '      operadora.cd_operadora = :cd_operadora AND' +
                            '      chip.cd_usina = usina.cd_usina AND' +
                            '      chip.cd_usina = :cd_usina AND' +
                            '      NOT EXISTS (SELECT agenda.cd_numero' +
                            '                     FROM agenda' +
                            '                     WHERE agenda.cd_numero = chip.cd_numero)' +
                            '   ORDER BY chip.cd_numero');
   dm.ADOQchip.Parameters.ParamByName('cd_operadora').Value := StrToInt(dbcbOperadoraChip.KeyValue);
   dm.ADOQchip.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQchip.Close;
   dm.ADOQchip.Open;
//END
   dbcbNumero.Enabled := True;
   dbcbAparelho.Enabled := True;
end;

procedure TFormAgenda.btnGravarClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      Exit;
   InsertSQL;
   MessageDlg('Agenda salva com sucesso.', mtInformation, [mbOK], 0);
end;
//TO-DO FUNCAO VALIDAR FORMAGENDA
function TFormAgenda.Validar: Boolean;
begin
   Result := False;
   if Trim(dbcbUnidade.Text) = '' then
      begin
         MessageDlg('Selecine a unidade.', mtInformation, [mbOK], 0);
         dbcbUnidade.SetFocus;
         exit;
      end else
   if Trim(dbcbFuncionario.Text) = '' then
      begin
         MessageDlg('Selecine o funcionário.', mtInformation, [mbOK], 0);
         dbcbFuncionario.SetFocus;
         exit;
      end else
   if trim(dbcbOperadoraChip.Text) = '' then
      begin
         MessageDlg('Selecione a operadora do chip.', mtInformation, [mbOK], 0);
         dbcbOperadoraChip.SetFocus;
         Exit;
      end else
   if Trim(dbcbNumero.Text) = '' then
      begin
         MessageDlg('Selecine o número.', mtInformation, [mbOK], 0);
         dbcbNumero.SetFocus;
         Exit;
      end else
   if Trim(dbcbOperadoraAparelho.Text) = '' then
      begin
         MessageDlg('Selecione a operadora do aparelho.', mtInformation, [mbOK], 0);
         dbcbOperadoraAparelho.SetFocus;
         Exit;
      end else
   if Trim(dbcbMarca.Text) = '' then
      begin
         MessageDlg('Selecione a marca do aparelho.', mtInformation, [mbOK], 0);
         dbcbMarca.SetFocus;
         exit;
      end else
   if Trim(dbcbAparelho.Text) = '' then
      begin
         MessageDlg('Selecione o aparelho.', mtInformation, [mbOK], 0);
         dbcbAparelho.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;
//TO-DO FUNCAO INSERT SQL AGENDA
function TFormAgenda.InsertSQL: Boolean;
begin
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO agenda (cd_usina, cd_matricula, cd_numero, cd_aparelho, dt_data, id_user)' +
                                 '   VALUES (:cd_usina, :cd_matricula, :cd_numero, :cd_aparelho, :dt_data, :id_user)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE agenda SET cd_aparelho = :cd_aparelho, dt_data = :dt_data, id_user = :id_user' +
                                 '   WHERE cd_matricula = :cd_matricula AND' +
                                 '         cd_numero = :cd_numero AND' +
                                 '         cd_usina = :cd_usina');
      end;
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbFuncionario.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := StrToFloat(dbcbNumero.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('cd_aparelho').Value := StrToInt(dbcbAparelho.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('dt_data').Value := Date;
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   dm.ADOQagenda.Close;
   dm.ADOQagenda.Open;
   
   //REGISTRA STATUS DO CHIP
   begin
      dm.ADOQSQL.SQL.Clear;
      dm.ADOQSQL.SQL.Text := ('UPDATE chip SET st_chip = :st_chip, id_user = :id_user WHERE cd_numero = :cd_numero');
      dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := StrToFloat(dbcbNumero.KeyValue);
      dm.ADOQSQL.Parameters.ParamByName('st_chip').Value := 'A';
      dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
      dm.ADOQSQL.ExecSQL;
   end;

   //RETIRA APARELHO DO ESTOQUE
   if MessageDlg('Retirar aparelho do estoque?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE aparelho SET qtde = qtde - 1, id_user = :id_user WHERE cd_aparelho = :cd_aparelho');
         dm.ADOQSQL.Parameters.ParamByName('cd_aparelho').Value := StrToInt(dbcbAparelho.KeyValue);
         dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
         dm.ADOQSQL.ExecSQL;
      end;
   tag := 1;
end;
//TO-DO PADRAO SQL
function TFormAgenda.PadraoSQL: Boolean;
begin
//PADRAO SQL USUARIO
//BEGIN
   dm.ADOQusuario.SQL.Clear;
   dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome, usuario.ds_cargo, usina.cd_usina, usina.ds_usina' +
                               '   FROM usuario, usina' +
                               '   WHERE usuario.cd_usina = usina.cd_usina' +
                               '   ORDER BY ds_usina, ds_nome');
   dm.ADOQusuario.Close;
   dm.ADOQusuario.Open;
//END

//PADRAO SQL CHIP
//BEGIN
   dm.ADOQchip.SQL.Clear;
   dm.ADOQchip.SQL.Text := ('SELECT chip.cd_usina, usina.ds_usina, chip.cd_numero, chip.cd_imei, chip.cd_pin2, chip.cd_operadora, operadora.ds_operadora, chip.st_chip' +
                            '   FROM chip, usina, operadora' +
                            '   WHERE chip.cd_usina = usina.cd_usina AND' +
                            '      chip.cd_operadora = operadora.cd_operadora' +
                            '   ORDER BY chip.cd_usina, chip.cd_numero');
   dm.ADOQchip.Close;
   dm.ADOQchip.Open;
//END

//PADRAO SQL APARELHO
//BEGIN
   dm.ADOQaparelho.SQL.Clear;
   dm.ADOQaparelho.SQL.Text := ('SELECT aparelho.cd_aparelho, aparelho.cd_modelo, aparelho.cd_operadora, aparelho.cd_marca, marca.cd_marca, marca.ds_marca, modelo.ds_modelo, operadora.ds_operadora, aparelho.qtde, aparelho.dt_data' +
                                '   FROM aparelho, marca, modelo, operadora' +
                                '   WHERE aparelho.cd_modelo = modelo.cd_modelo AND' +
                                '      modelo.cd_marca = marca.cd_marca AND' +
                                '      aparelho.cd_operadora = operadora.cd_operadora' +
                                '   ORDER BY marca.ds_marca, modelo.ds_modelo');
   dm.ADOQaparelho.Close;
   dm.ADOQaparelho.Open;
//END

//PADRAO SQL MARCA
//BEGIN
   dm.ADOQmarca.SQL.Clear;
   dm.ADOQmarca.SQL.Text := ('select * from marca order by cd_marca');
   dm.ADOQmarca.Close;
   dm.ADOQmarca.Open;
//END

end;

procedure TFormAgenda.dbgAgendaCellClick(Column: TColumn);
var ds_nome: String;
    cd_usina: Integer;
begin
  inherited;
   if dbcbFuncionario.Text = dbgAgenda.Fields[0].AsString then
      begin
         dbcbUnidade.KeyValue := dm.ADOQagenda.FieldByName('cd_usina').AsInteger;
         dbcbFuncionario.KeyValue := dm.ADOQagenda.FieldByName('cd_matricula').AsInteger;
         dbcbOperadoraChip.KeyValue := dm.ADOQagenda.FieldByName('cd_operadora').AsInteger;
         dbcbNumero.KeyValue := dm.ADOQagenda.FieldByName('cd_numero').AsString;
         dbcbOperadoraAparelho.KeyValue := dm.ADOQagenda.FieldByName('cd_operadora').AsInteger;
         dbcbMarca.KeyValue := dm.ADOQagenda.FieldByName('cd_marca').AsInteger;
         dbcbAparelho.KeyValue := dm.ADOQagenda.FieldByName('cd_aparelho').AsInteger;
      end else
   if dbcbFuncionario.Text <> dbgAgenda.Fields[0].AsString then
      begin
         ds_nome := dbgAgenda.Fields[0].AsString;
         cd_usina := dbgAgenda.Fields[6].AsInteger;

         dm.ADOQusuario.SQL.Clear;
         dm.ADOQusuario.SQL.Text := ('SELECT usuario.cd_matricula, usuario.ds_nome' +
                                     '   FROM usuario, usina' +
                                     '   WHERE usuario.cd_usina = usina.cd_usina AND' +
                                     '      usina.cd_usina = :cd_usina' +
                                     '   ORDER BY usuario.ds_nome');
         dm.ADOQusuario.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
         dm.ADOQusuario.Close;
         dm.ADOQusuario.Open;

         dbcbUnidade.KeyValue := dm.ADOQagenda.FieldByName('cd_usina').AsInteger;
         dbcbFuncionario.KeyValue := dm.ADOQagenda.FieldByName('cd_matricula').AsInteger;
         dbcbOperadoraChip.KeyValue := dm.ADOQagenda.FieldByName('cd_operadora').AsInteger;
         dbcbNumero.KeyValue := dm.ADOQagenda.FieldByName('cd_numero').AsString;
         dbcbAparelho.KeyValue := dm.ADOQagenda.FieldByName('cd_aparelho').AsInteger;
      end;

   tag := 2;
   dbcbNumero.Enabled := True;
   dbcbMarca.Enabled := True;
   dbcbAparelho.Enabled := True;
   btnTransferir.Enabled := True;
   dbcbFuncionarioTransferencia.Enabled := True;
end;

procedure TFormAgenda.btnVerlistaClick(Sender: TObject);
begin
  inherited;
   if Trim(dbcbUnidade.Text) = '' then
      exit;
   if trim(dbcbFuncionario.Text) = '' then
      begin
         MessageDlg('Selecione o usuário da lista.', mtInformation, [mbOK], 0);
         dbgAgenda.SetFocus;
         exit;
      end else
      begin
         FormListaTelefone := TFormListaTelefone.Create(Application);
         FormListaTelefone.mmListaTelefone.Items[0].Caption := 'Fechar';
         FormListaTelefone.sts := 0;
         FormListaTelefone.Show;
         FormListaTelefone.dbcbUnidade.KeyValue := dbcbUnidade.KeyValue;
         FormListaTelefone.dbcbUnidade.Enabled := False;
         FormListaTelefone.dbcbFuncionario.KeyValue := dbcbFuncionario.KeyValue;
         FormListaTelefone.dbcbFuncionarioClick(Self);
      end;
end;

procedure TFormAgenda.btnExcluirClick(Sender: TObject);
begin
  inherited;
   if MessageDlg('Deseja realmente excluir as informações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM agenda WHERE cd_matricula = :cd_matricula AND cd_numero = :cd_numero AND cd_usina = :cd_usina');
         dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := dbcbFuncionario.KeyValue;
         dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := dbcbNumero.KeyValue;
         dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(FloatToStr(dbcbUnidade.KeyValue));
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
   if MessageDlg('Deseja destivar o CHIP?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE chip SET st_chip = :st_chip, id_user = :id_user WHERE cd_numero = :cd_numero');
         dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := StrToFloat(dbcbNumero.KeyValue);
         dm.ADOQSQL.Parameters.ParamByName('st_chip').Value := 'I';
         dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
         dm.ADOQSQL.ExecSQL;
         MessageDlg('O CHIP foi desativado!', mtInformation,[mbOK], 0);
      end else
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE chip SET st_chip = :st_chip, id_user = :id_user WHERE cd_numero = :cd_numero');
         dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := StrToFloat(dbcbNumero.KeyValue);
         dm.ADOQSQL.Parameters.ParamByName('st_chip').Value := 'E';
         dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
         dm.ADOQSQL.ExecSQL;
         MessageDlg('CHIP disponivel para novo uso.', mtInformation, [mbOK], 0);
      end;
   dm.ADOQagenda.Close;
   dm.ADOQagenda.Open;

   dbcbUnidade.KeyValue := -1;
   dbcbFuncionario.KeyValue := -1;
   dbcbOperadoraChip.KeyValue := -1;
   dbcbNumero.KeyValue := -1;
   dbcbAparelho.KeyValue := -1;
   dbcbFuncionario.Enabled := False;
   dbcbNumero.Enabled := False;
   dbcbAparelho.Enabled := False;
   tag := 1;
end;

procedure TFormAgenda.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   if dbcbUnidade.Text = '' then
      begin
         MessageDlg('Selecione a unidade.', mtInformation, [mbOK], 0);
         dbcbUnidade.SetFocus;
         Exit;
      end;
   dm.ADOQusina.Open;   
   dm.ADOQagenda.Open;
   FormRelAgenda := TFormRelAgenda.Create(Application);
   FormRelAgenda.rlrRelatorio.Preview();
end;

function TFormAgenda.Acesso: Boolean;
begin
   if FormLogin.ac = 2 then
      begin
         btnGravar.Enabled := False;
         btnExcluir.Enabled := False;
      end;
end;

procedure TFormAgenda.dbcbUnidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbFuncionario.SetFocus;
end;

procedure TFormAgenda.dbcbFuncionarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbOperadoraChip.SetFocus;
end;

procedure TFormAgenda.dbcbOperadoraChipKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbNumero.SetFocus;
end;

procedure TFormAgenda.dbcbNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbOperadoraAparelho.SetFocus;
end;

procedure TFormAgenda.dbcbAparelhoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnGravar.SetFocus;
end;

procedure TFormAgenda.btnLocalizarClick(Sender: TObject);
begin
  inherited;
   if trim(edtLocalizarUsuario.Text) = '' then
      begin
         MessageDlg('Digite o nome a ser localizado.', mtInformation, [mbOK], 0);
         edtLocalizarUsuario.SetFocus;
         exit;
      end;
   dbcbUnidade.KeyValue := -1;
   dbcbFuncionario.KeyValue := -1;
   dbcbOperadoraChip.KeyValue := -1;
   dbcbNumero.KeyValue := -1;
   dbcbAparelho.KeyValue := -1;
   LocalizarSQL;
end;
//TO-DO FUNCAO LOCALIZAR USUARIO
function TFormAgenda.LocalizarSQL: Boolean;
begin
   if StrToFloatDef(edtLocalizarUsuario.Text, 1) = 1 then
      begin
         dm.ADOQagenda.SQL.Clear;
         dm.ADOQagenda.SQL.Text := ('select usina.cd_usina, usuario.ds_nome, chip.cd_numero, chip.cd_pin2, operadora.ds_operadora, marca.ds_marca, modelo.ds_modelo, usina.cd_usina, usuario.cd_matricula, operadora.cd_operadora, aparelho.cd_aparelho, aparelho.cd_marca' +
                                    '   from usuario, chip, operadora, marca, modelo, aparelho, usina, agenda' +
                                    '   where usuario.cd_matricula = agenda.cd_matricula and' +
                                    '      usuario.cd_usina = agenda.cd_usina and' +
                                    '      usuario.cd_usina = usina.cd_usina and' +
                                    '      agenda.cd_usina = usina.cd_usina and' +
                                    '      chip.cd_numero = agenda.cd_numero and' +
                                    '      operadora.cd_operadora = chip.cd_operadora and' +
                                    '      aparelho.cd_aparelho = agenda.cd_aparelho and' +
                                    '      aparelho.cd_marca = marca.cd_marca and' +
                                    '      aparelho.cd_modelo = modelo.cd_modelo and' +
                                    '      usuario.ds_nome like :ds_nome  '+
                                    '   order by usuario.ds_nome');
         dm.ADOQagenda.Parameters.ParamByName('ds_nome').Value := '%'+edtLocalizarUsuario.Text+'%';
         dm.ADOQagenda.Close;
         dm.ADOQagenda.Open;
      end;
   if StrToFloatDef(edtLocalizarUsuario.Text, 1) <> 1 then
      begin
         dm.ADOQagenda.SQL.Clear;
         dm.ADOQagenda.SQL.Text := ('select usina.cd_usina, usuario.ds_nome, chip.cd_numero, chip.cd_pin2, operadora.ds_operadora, marca.ds_marca, modelo.ds_modelo, usina.cd_usina, usuario.cd_matricula, operadora.cd_operadora, aparelho.cd_aparelho, aparelho.cd_marca' +
                                    '   from usuario, chip, operadora, marca, modelo, aparelho, usina, agenda' +
                                    '   where usuario.cd_matricula = agenda.cd_matricula and' +
                                    '      usuario.cd_usina = usina.cd_usina and' +
                                    '      agenda.cd_usina = usina.cd_usina and' +
                                    '      chip.cd_numero = agenda.cd_numero and' +
                                    '      operadora.cd_operadora = chip.cd_operadora and' +
                                    '      aparelho.cd_aparelho = agenda.cd_aparelho and' +
                                    '      aparelho.cd_marca = marca.cd_marca and' +
                                    '      aparelho.cd_modelo = modelo.cd_modelo and' +
                                    '      chip.cd_numero like :cd_numero' +
                                    '   order by usuario.ds_nome');
         dm.ADOQagenda.Parameters.ParamByName('cd_numero').Value := '%'+edtLocalizarUsuario.Text+'%';
         dm.ADOQagenda.Close;
         dm.ADOQagenda.Open;
      end;
end;

procedure TFormAgenda.edtLocalizarUsuarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      btnLocalizar.Click;
   PadraoSQL;
end;

procedure TFormAgenda.dbcbOperadoraAparelhoClick(Sender: TObject);
begin
  inherited;
//TO-DO FILTRO SQL OPERADORA/MARCA
//BEGIN
   dm.ADOQmarca.SQL.Clear;
   dm.ADOQmarca.SQL.Text := ('SELECT DISTINCT(marca.ds_marca), marca.cd_marca ' +
                             '   FROM marca, operadora, aparelho ' +
                             '   WHERE aparelho.cd_marca = marca.cd_marca AND' +
                             '      aparelho.cd_operadora = operadora.cd_operadora AND' +
                             '      aparelho.cd_operadora = :cd_operadora');
   dm.ADOQmarca.Parameters.ParamByName('cd_operadora').Value := StrToInt(dbcbOperadoraAparelho.KeyValue);
   dm.ADOQmarca.Close;
   dm.ADOQmarca.Open;

   dbcbMarca.Enabled := True;

//END
end;

procedure TFormAgenda.dbcbMarcaClick(Sender: TObject);
begin
  inherited;
//TO-DO FILTRO SQL OPERADORA/MARCA/MODELO
   dm.ADOQaparelho.SQL.Clear;
   dm.ADOQaparelho.SQL.Text := ('SELECT marca.ds_marca, modelo.ds_modelo, operadora.ds_operadora, aparelho.cd_aparelho, aparelho.qtde, aparelho.dt_data' +
                                '   FROM marca, operadora, modelo, aparelho ' +
                                '   WHERE marca.cd_marca = modelo.cd_marca and ' +
                                '      aparelho.cd_modelo = modelo.cd_modelo and ' +
                                '      aparelho.cd_operadora = operadora.cd_operadora and ' +
                                '      aparelho.cd_marca = :cd_marca and ' +
                                '      aparelho.cd_operadora = :cd_operadora ' +
                                '   ORDER BY modelo.ds_modelo');
   dm.ADOQaparelho.Parameters.ParamByName('cd_marca').Value := StrToInt(dbcbMarca.KeyValue);
   dm.ADOQaparelho.Parameters.ParamByName('cd_operadora').Value := StrToInt(dbcbOperadoraAparelho.KeyValue);
   dm.ADOQaparelho.Close;
   dm.ADOQaparelho.Open;

   dbcbAparelho.Enabled := True;
end;

procedure TFormAgenda.dbcbNumeroClick(Sender: TObject);
begin
  inherited;
   dbcbOperadoraAparelho.Enabled := True;
end;

procedure TFormAgenda.dbcbOperadoraAparelhoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbMarca.SetFocus;
end;

procedure TFormAgenda.dbcbMarcaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbAparelho.SetFocus;
end;

procedure TFormAgenda.btnTransferirClick(Sender: TObject);
begin
  inherited;
   if Trim(dbcbFuncionarioTransferencia.Text) = '' then
      begin
         MessageDlg('Selecione o novo usuário.', mtInformation, [mbOK], 0);
         dbcbFuncionarioTransferencia.SetFocus;
         exit;
      end;
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE agenda SET cd_matricula = :cd_matricula, id_user = :id_user ' +
                                 '   WHERE cd_numero = :cd_numero AND' +
                                 '      cd_usina = :cd_usina');
         dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := StrToInt(dbcbUnidade.KeyValue);
         dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := StrToInt(dbcbFuncionarioTransferencia.KeyValue);
         dm.ADOQSQL.Parameters.ParamByName('cd_numero').Value := StrToFloat(dbcbNumero.KeyValue);
         dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
         dm.ADOQSQL.ExecSQL;
         dm.ADOQagenda.Close;
         dm.ADOQagenda.Open;
         MessageDlg('Transferencia realizada.', mtInformation, [mbOK], 0);
      end;
   dbcbUnidade.SetFocus;
   dbcbFuncionario.Enabled := False;
   dbcbOperadoraChip.Enabled := False;
   dbcbNumero.Enabled := False;
   dbcbOperadoraAparelho.Enabled := False;
   dbcbMarca.Enabled := False;
   dbcbAparelho.Enabled := False;
   btnTransferir.Enabled := False;
   dbcbFuncionarioTransferencia.Enabled := False;

end;

procedure TFormAgenda.dbcbFuncionarioClick(Sender: TObject);
begin
  inherited;
   dbcbOperadoraChip.Enabled := True;
end;

end.
