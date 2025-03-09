unit untCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, ComCtrls, StdCtrls, ExtCtrls, Buttons, Grids,
  DBGrids, Menus;

type
  TFormCidade = class(TFormPadrao)
    mmCidade: TMainMenu;
    Sair1: TMenuItem;
    dbgCidade: TDBGrid;
    pnlControl: TPanel;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    pnlCampos: TPanel;
    edtCodigo: TLabeledEdit;
    edtCidade: TLabeledEdit;
    cbEstado: TComboBox;
    lblEstado: TLabel;
    btnRelatorio: TBitBtn;
    Novo1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure cbEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgCidadeCellClick(Column: TColumn);
    procedure Novo1Click(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
  private
  function Validar: Boolean;
  function InsertSQL: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCidade: TFormCidade;

implementation

uses untDM, DB, untPadraoRelatorio, untRelCidade, untLogin, untPrincipal;

{$R *.dfm}

procedure TFormCidade.Sair1Click(Sender: TObject);
begin
  inherited;
   Close;
end;

procedure TFormCidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;
end;

procedure TFormCidade.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtCidade.SetFocus;
end;

procedure TFormCidade.edtCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      cbEstado.SetFocus;
end;

procedure TFormCidade.cbEstadoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnGravar.SetFocus;
end;

procedure TFormCidade.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   tag := 1;
   edtCidade.SetFocus;
end;

//TO-DO VALIDAR FORMULARIO CIDADE
function TFormCidade.Validar: Boolean;
begin
   Result := False;
   if trim(edtCidade.Text) = '' then
      begin
         MessageDlg('Digite o nome da Cidade.', mtInformation, [mbOK], 0);
         edtCidade.SetFocus;
         exit;
      end else
   if trim(cbEstado.Text) = '' then
      begin
         MessageDlg('Selecione o Estado.', mtInformation, [mbOK], 0);
         cbEstado.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormCidade.btnGravarClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   InsertSQL;
   if tag = 1 then
      MessageDlg('Cidade cadastrada com sucesso.', mtInformation, [mbOK], 0);
   if tag = 2 then
      MessageDlg('Cidade alterada com sucesso.', mtInformation, [mbOK], 0);
   btnGravar.Enabled := False;
   edtCodigo.Clear;
   edtCidade.Clear;
   cbEstado.ItemIndex := -1;
end;
//TO-DO FUNCAO INSERTSQL CIDADE
function TFormCidade.InsertSQL: Boolean;
begin
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO cidade (cd_cidade, ds_cidade, ds_estado, id_user)' +
                                 '   VALUES (s_cidade.nextval, :ds_cidade, :ds_estado, :id_user)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE cidade SET ds_cidade = :ds_cidade, ds_estado = :ds_estado, id_user = :id_user' +
                                 '   WHERE cd_cidade = :cd_cidade');
         dm.ADOQSQL.Parameters.ParamByName('cd_cidade').Value := edtCodigo.Text;
      end;
   dm.ADOQSQL.Parameters.ParamByName('ds_cidade').Value := edtCidade.Text;
   dm.ADOQSQL.Parameters.ParamByName('ds_estado').Value := cbEstado.Text;
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   dm.ADOQcidade.Close;
   dm.ADOQcidade.Open;
end;

procedure TFormCidade.dbgCidadeCellClick(Column: TColumn);
begin
  inherited;
   tag := 2;
   edtCodigo.Text := dbgCidade.Columns.Items[0].Field.AsString;
   edtCidade.Text := dbgCidade.Columns.Items[1].Field.AsString;
   if dm.ADOQcidade.FieldByName('ds_estado').AsString = 'PR' then
      cbEstado.ItemIndex := 0
      else
   if dm.ADOQcidade.FieldByName('ds_estado').AsString = 'RJ' then
      cbEstado.ItemIndex := 1
      else
   if dm.ADOQcidade.FieldByName('ds_estado').AsString = 'SC' then
      cbEstado.ItemIndex := 2;
   btnGravar.Enabled := True;
end;

procedure TFormCidade.Novo1Click(Sender: TObject);
begin
  inherited;
   tag := 1;
   edtCodigo.Clear;
   edtCidade.Clear;
   cbEstado.ItemIndex := -1;
   btnGravar.Enabled := True;
   edtCidade.SetFocus;
end;

procedure TFormCidade.btnExcluirClick(Sender: TObject);
begin
  inherited;
   if MessageDlg('Deseja realmente excluir as informações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM cidade WHERE cd_cidade = :cd_cidade');
         dm.ADOQSQL.Parameters.ParamByName('cd_cidade').Value := edtCodigo.Text;
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
   edtCodigo.Clear;
   edtCidade.Clear;
   cbEstado.ItemHeight := -1;
   dm.ADOQcidade.Close;
   dm.ADOQcidade.Open;
end;

procedure TFormCidade.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   dm.ADOQcidade.Open;
   FormRelCidade := TFormRelCidade.Create(Application);
   FormRelCidade.rlrRelatorio.Preview();
end;

end.
