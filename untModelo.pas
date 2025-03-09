unit untModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, ComCtrls, Menus, StdCtrls, Buttons, DBCtrls,
  ExtCtrls, Grids, DBGrids, DB, ADODB;

type
  TFormModelo = class(TFormPadrao)
    mmModelo: TMainMenu;
    Voltar1: TMenuItem;
    dbgModelo: TDBGrid;
    pnlCampos: TPanel;
    edtCodigo: TLabeledEdit;
    dbcbMarca: TDBLookupComboBox;
    lblMarca: TLabel;
    edtModelo: TLabeledEdit;
    pnlControl: TPanel;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnRelatorio: TBitBtn;
    Novo1: TMenuItem;
    procedure Voltar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbcbMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtModeloKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure Novo1Click(Sender: TObject);
    procedure dbgModeloCellClick(Column: TColumn);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbcbMarcaExit(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
  private
  function Validar: Boolean;
  function InsertSQL: Boolean;
  function FiltroSQL: Boolean;
    { Private declarations }
  public
  function PadraoSQL: Boolean;
    { Public declarations }
  end;

var
  FormModelo: TFormModelo;

implementation

uses untDM, untRelModelo, untLogin, untPrincipal;

{$R *.dfm}

procedure TFormModelo.Voltar1Click(Sender: TObject);
begin
  inherited;
   close;
end;

procedure TFormModelo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;
   PadraoSQL;
end;

procedure TFormModelo.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   tag := 1;
   dbcbMarca.SetFocus;
end;

procedure TFormModelo.dbcbMarcaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtModelo.SetFocus;
end;

procedure TFormModelo.edtModeloKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnGravar.SetFocus;
end;
//TO-DO VALIDAR FORMULARIO MODELO
function TFormModelo.Validar: Boolean;
begin
   Result := False;
   if trim(dbcbMarca.Text) = '' then
      begin
         MessageDlg('Selecione a marca.', mtInformation, [mbOK], 0);
         dbcbMarca.SetFocus;
         exit;
      end else
   if trim(edtModelo.Text) = '' then
      begin
         MessageDlg('Digite o modelo.', mtInformation, [mbOK], 0);
         edtModelo.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormModelo.btnGravarClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   InsertSQL;
   if tag = 1 then
      MessageDlg('Modelo cadastrado com sucesso.', mtInformation, [mbOK], 0);
   if tag = 2 then
      MessageDlg('Modelo alterado com sucesso.', mtInformation, [mbOK], 0);
   PadraoSQL;
   dbcbMarca.KeyValue := -1;
   edtModelo.Clear;
   dbcbMarca.SetFocus;
end;

procedure TFormModelo.Novo1Click(Sender: TObject);
begin
  inherited;
   tag := 1;
   edtCodigo.Clear;
   dbcbMarca.KeyValue := 0;
   edtModelo.Clear;
   btnGravar.Enabled := True;
   dbcbMarca.SetFocus;
   PadraoSQL;
end;
//TO-DO FUNCAO INSERTSQL MODELO
function TFormModelo.InsertSQL: Boolean;
begin
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO modelo (cd_modelo, ds_modelo, cd_marca, id_user)' +
                                 '   VALUES (s_modelo.nextval, :ds_modelo, :cd_marca, :id_user)');
         dm.ADOQSQL.Parameters.ParamByName('cd_marca').Value := StrToInt(dbcbMarca.KeyValue);
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE modelo SET ds_modelo = :ds_modelo, id_user = :id_user WHERE cd_modelo = :cd_modelo');
         dm.ADOQSQL.Parameters.ParamByName('cd_modelo').Value := edtCodigo.Text;
      end;
   dm.ADOQSQL.Parameters.ParamByName('ds_modelo').Value := edtModelo.Text;
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   dm.ADOQmodelo.Close;
   dm.ADOQmodelo.Open;
end;

procedure TFormModelo.dbgModeloCellClick(Column: TColumn);
begin
  inherited;
   tag := 2;
   edtCodigo.Text := dm.ADOQmodelo.FieldByName('cd_modelo').AsString;
   dbcbMarca.KeyValue := dm.ADOQmodelo.FieldByName('cd_marca').AsInteger;
   edtModelo.Text := dm.ADOQmodelo.FieldByName('ds_modelo').AsString;
end;

procedure TFormModelo.btnExcluirClick(Sender: TObject);
begin
  inherited;
   if MessageDlg('Deseja realemente excluir as informações?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM modelo WHERE cd_modelo = :cd_modelo');
         dm.ADOQSQL.Parameters.ParamByName('cd_modelo').Value := edtCodigo.Text;
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
   edtCodigo.Clear;
   dbcbMarca.KeyValue := -1;
   edtModelo.Clear;
   dm.ADOQmodelo.Close;
   dm.ADOQmodelo.Open;
end;
//TO-DO FILTRO SQL MODELO
function TFormModelo.FiltroSQL: Boolean;
begin
   dm.ADOQmodelo.SQL.Clear;
   dm.ADOQmodelo.SQL.Text := ('SELECT modelo.*, marca.* FROM modelo,marca' +
                              '   WHERE modelo.cd_marca = marca.cd_marca AND' +
                              '         marca.cd_marca = :cd_marca' +
                              '   ORDER BY modelo.ds_modelo');
   dm.ADOQmodelo.Parameters.ParamByName('cd_marca').Value := StrToInt(dbcbMarca.KeyValue);
   dm.ADOQmodelo.Close;
   dm.ADOQmodelo.Open;
end;

procedure TFormModelo.dbcbMarcaExit(Sender: TObject);
begin
  inherited;
   if dbcbMarca.Text = '' then
      begin
         exit;
      end else
         FiltroSQL;
end;
//TO-DO PADRAOSQL MODELO
function TFormModelo.PadraoSQL: Boolean;
begin
   dm.ADOQmodelo.SQL.Clear;
   dm.ADOQmodelo.SQL.Text := ('SELECT modelo.cd_modelo, marca.cd_marca, marca.ds_marca, modelo.ds_modelo' +
                              '   FROM modelo, marca' +
                              '   WHERE modelo.cd_marca = marca.cd_marca' +
                              '   ORDER BY marca.ds_marca, modelo.cd_modelo');
  dm.ADOQmodelo.Close;
  dm.ADOQmodelo.Open;
end;

procedure TFormModelo.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   dm.ADOQmodelo.Open;
   FormRelModelo := TFormRelModelo.Create(Application);
   FormRelModelo.rlrRelatorio.Preview();
end;

end.
