unit untUnidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, Menus, ComCtrls, StdCtrls, Buttons, DBCtrls,
  ExtCtrls, Grids, DBGrids;

type
  TFormUnidade = class(TFormPadrao)
    mmUnidade: TMainMenu;
    Voltar1: TMenuItem;
    dbgUnidade: TDBGrid;
    pnlCampos: TPanel;
    pnlControl: TPanel;
    edtCodigo: TLabeledEdit;
    dbcbCidade: TDBLookupComboBox;
    edtUnidade: TLabeledEdit;
    lblCidade: TLabel;
    btnGravar: TBitBtn;
    BitBtn1: TBitBtn;
    btnRelatorio: TBitBtn;
    Novo1: TMenuItem;
    procedure Voltar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbcbCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure Novo1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure dbgUnidadeCellClick(Column: TColumn);
    procedure btnRelatorioClick(Sender: TObject);
  private
  function Validar: Boolean;
  function InsertSQL: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUnidade: TFormUnidade;

implementation

uses untDM, DB, untRelUnidade, untLogin, untPrincipal;

{$R *.dfm}

procedure TFormUnidade.Voltar1Click(Sender: TObject);
begin
  inherited;
   close;
end;

procedure TFormUnidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;
end;

procedure TFormUnidade.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   tag := 1;
   edtCodigo.SetFocus;
end;

//TO-DO VALIDAR FORMULARIO UNIDADE
function TFormUnidade.Validar: Boolean;
begin
   Result := False;
   if trim(edtCodigo.Text) = '' then
      begin
         MessageDlg('Digite o código da unidade.', mtInformation, [mbOK], 0);
         edtCodigo.SetFocus;
         exit;
      end else
   if trim(dbcbCidade.Text) = '' then
      begin
         MessageDlg('Selecione a cidade.', mtInformation, [mbOK], 0);
         dbcbCidade.SetFocus;
         exit;
      end else
   if trim(edtUnidade.Text) = '' then
      begin
         MessageDlg('Digite o nome da Unidade.', mtInformation, [mbOK], 0);
         edtUnidade.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormUnidade.dbcbCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtUnidade.SetFocus;
end;

procedure TFormUnidade.edtUnidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnGravar.SetFocus;
end;

procedure TFormUnidade.btnGravarClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   InsertSQL;
   if tag = 1 then
      MessageDlg('Unidade cadastrada com sucesso.', mtInformation, [mbOK], 0);
   if tag = 2 then
      MessageDlg('Unidade alterada com sucesso.', mtInformation, [mbOK], 0);
   edtCodigo.Clear;
   dbcbCidade.KeyValue := -1;
   edtUnidade.Clear;
   btnGravar.Enabled := False;
end;

procedure TFormUnidade.edtCodigoExit(Sender: TObject);
begin
  inherited;
   if trim(edtCodigo.Text) = '' then
      begin
         exit;
      end else
   if StrToIntDef(edtCodigo.Text, -1) = -1 then
      begin
         edtCodigo.SetFocus;
         MessageDlg('Somente números.', mtError, [mbOK], 0);
         exit;
      end;
end;

procedure TFormUnidade.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      dbcbCidade.SetFocus;
end;
//TO-DO FUNCAO INSERTSQL UNIDADE
function TFormUnidade.InsertSQL: Boolean;
begin
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO usina (cd_usina, ds_usina, cd_cidade, id_user)' +
                                 '   VALUES (:cd_usina, :ds_usina, :cd_cidade, :id_user)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE usina SET cd_usina = :cd_usina, ds_usina = :ds_usina, cd_cidade = :cd_cidade, id_user = :id_user' +
                                 '   WHERE cd_usina = :cd_usina, ds_usina = :ds_usina, cd_cidade = :cd_cidade, :id_user');
      end;
   dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := edtCodigo.Text;
   dm.ADOQSQL.Parameters.ParamByName('ds_usina').Value := edtUnidade.Text;
   dm.ADOQSQL.Parameters.ParamByName('cd_cidade').Value := StrToInt(dbcbCidade.KeyValue);
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   dm.ADOQusina.Close;
   dm.ADOQusina.Open;
end;

procedure TFormUnidade.Novo1Click(Sender: TObject);
begin
  inherited;
   tag := 1 ;
   edtCodigo.Clear;
   dbcbCidade.KeyValue := -1;
   edtUnidade.Clear;
   btnGravar.Enabled := true;
   edtCodigo.SetFocus;
end;

procedure TFormUnidade.BitBtn1Click(Sender: TObject);
begin
  inherited;
   if MessageDlg('Deseja realmente excluir as informações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        dm.ADOQSQL.SQL.Clear;
        dm.ADOQSQL.SQL.Text := ('DELETE FROM usina WHERE cd_usina = :cd_usina');
        dm.ADOQSQL.Parameters.ParamByName('cd_usina').Value := edtCodigo.Text;
        dm.ADOQSQL.ExecSQL;
        MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
   edtCodigo.Clear;
   dbcbCidade.KeyValue := -1;
   edtUnidade.Clear;
   dm.ADOQusina.Close;
   dm.ADOQusina.Open;
end;

procedure TFormUnidade.dbgUnidadeCellClick(Column: TColumn);
begin
  inherited;
   tag := 2;
   edtCodigo.Text := dm.ADOQusina.FieldByName('cd_usina').AsString;
   dbcbCidade.KeyValue := dm.ADOQusina.FieldByName('cd_cidade').AsInteger;
   edtUnidade.Text := dm.ADOQusina.FieldByName('ds_usina').AsString;
end;

procedure TFormUnidade.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   dm.ADOQusina.Open;
   FormRelUnidade := TFormRelUnidade.Create(Application);
   FormRelUnidade.rlrRelatorio.Preview();
end;

end.
