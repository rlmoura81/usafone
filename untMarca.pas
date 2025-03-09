unit untMarca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGrids;

type
  TFormMarca = class(TFormPadrao)
    mmMarca: TMainMenu;
    Voltar1: TMenuItem;
    dbgMarca: TDBGrid;
    pnlCampos: TPanel;
    pnlControl: TPanel;
    edtCodigo: TLabeledEdit;
    edtMarca: TLabeledEdit;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnRelatorio: TBitBtn;
    Novo1: TMenuItem;
    procedure Voltar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgMarcaCellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
  private
  function Validar: Boolean;
  function InsertSQL: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMarca: TFormMarca;

implementation

uses untDM, ADODB, DB, untRelMarca, untLogin, untPrincipal;

{$R *.dfm}

procedure TFormMarca.Voltar1Click(Sender: TObject);
begin
  inherited;
   close;
end;

procedure TFormMarca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;
end;

procedure TFormMarca.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   edtMarca.SetFocus;
   Tag := 1;
end;

procedure TFormMarca.edtMarcaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnGravar.SetFocus;
end;

//TO-DO VALIDA FORMULARIO MARCA
function TFormMarca.Validar: Boolean;
begin
   Result := False;
   if trim(edtMarca.Text) = '' then
      begin
         MessageDlg('Digite a marca.', mtInformation, [mbOK], 0);
         edtMarca.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormMarca.btnGravarClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   InsertSQL;
   if tag = 1 then
      MessageDlg('Marca cadastrada com sucesso.', mtInformation, [mbOK], 0);
   if tag = 2 then
      MessageDlg('Marca alterada com sucesso.', mtInformation, [mbOK], 0);
   btnGravar.Enabled := False;
   edtMarca.Clear;
   edtCodigo.Clear;
   edtMarca.SetFocus;
end;
//TO-DO FUNCAO INSERTSQL MARCA
function TFormMarca.InsertSQL: Boolean;
begin
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO marca (cd_marca, ds_marca, id_user) VALUES (s_marca.nextval, :ds_marca, :id_user)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE marca SET ds_marca = :ds_marca, id_user = :id_user WHERE cd_marca = :cd_marca');
         dm.ADOQSQL.Parameters.ParamByName('cd_marca').Value := edtCodigo.Text;
      end;
   dm.ADOQSQL.Parameters.ParamByName('ds_marca').Value := edtMarca.Text;
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   dm.ADOQmarca.Close;
   dm.ADOQmarca.Open;
end;

procedure TFormMarca.dbgMarcaCellClick(Column: TColumn);
begin
  inherited;
   tag := 2;
   edtCodigo.Text := dbgMarca.Columns.Items[0].Field.AsString;
   edtMarca.Text := dbgMarca.Columns.Items[1].Field.AsString;
end;

procedure TFormMarca.btnExcluirClick(Sender: TObject);
begin
  inherited;
   if MessageDlg('Deseja realmente excluir as informações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM marca WHERE cd_marca = :cd_marca');
         dm.ADOQSQL.Parameters.ParamByName('cd_marca').Value := edtCodigo.Text;
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
   dm.ADOQmarca.Close;
   dm.ADOQmarca.Open;
   edtCodigo.Clear;
   edtMarca.Clear;
end;

procedure TFormMarca.Novo1Click(Sender: TObject);
begin
  inherited;
   tag := 1;
   edtCodigo.Clear;
   edtMarca.Clear;
   btnGravar.Enabled := True;
   edtMarca.SetFocus;
end;

procedure TFormMarca.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   dm.ADOQmarca.Open;
   FormRelMarca := TFormRelMarca.Create(Application);
   FormRelMarca.rlrRelatorio.Preview();
end;

end.
