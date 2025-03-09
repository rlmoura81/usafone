unit untOperadora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, StdCtrls, ExtCtrls, Menus, Grids, DBGrids,
  ComCtrls, Buttons;

type
  TFormOperadora = class(TFormPadrao)
    mmOperadora: TMainMenu;
    dbgOperadora: TDBGrid;
    Voltar1: TMenuItem;
    pnlCampos: TPanel;
    pnlControl: TPanel;
    edtCodigo: TLabeledEdit;
    edtOperadora: TLabeledEdit;
    btnGravar: TBitBtn;
    btnExcluir: TBitBtn;
    btnRelatorio: TBitBtn;
    Novo1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Voltar1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtOperadoraKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgOperadoraCellClick(Column: TColumn);
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
  FormOperadora: TFormOperadora;

implementation

uses untDM, DB, untRelOperadora, untLogin, untPrincipal;

{$R *.dfm}

procedure TFormOperadora.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   FormPrincipal.Show;
   Action := caFree;
end;

procedure TFormOperadora.Voltar1Click(Sender: TObject);
begin
  inherited;
   close;
end;

procedure TFormOperadora.FormShow(Sender: TObject);
begin
  inherited;
   FormPrincipal.Hide;
   tag := 1;
   edtOperadora.SetFocus;
end;

procedure TFormOperadora.edtOperadoraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if key = #13 then
      btnGravar.SetFocus;
end;
//TO-DO VALIDAR FORMULARIO OPERADORA
function TFormOperadora.Validar: Boolean;
begin
   Result := False;
      if trim(edtOperadora.Text) = '' then
         begin
            MessageDlg('Digite a operadora.', mtInformation, [mbOK], 0);
            edtOperadora.SetFocus;
            exit;
         end else
         begin
            Result := True;
         end;
end;

procedure TFormOperadora.btnGravarClick(Sender: TObject);
begin
  inherited;
   if not Validar then
      exit;
   InsertSQL;
   if tag = 1 then
      MessageDlg('Operadora cadastrada com suscesso.', mtInformation, [mbOK], 0);
   if tag = 2 then
      MessageDlg('Operadora alterada com sucesso.', mtInformation, [mbOK], 0);
   btnGravar.Enabled := False;
   edtCodigo.Clear;
   edtOperadora.Clear;
end;
//TO-DO FUNCAO INSERTSQL OPERADORA
function TFormOperadora.InsertSQL: Boolean;
begin
   if tag = 1 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('INSERT INTO operadora (cd_operadora, ds_operadora, id_user)' +
                                 '   VALUES (s_operadora.nextval, :ds_operadora, :id_user)');
      end else
   if tag = 2 then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE operadora SET ds_operadora = :ds_operadora, id_user = :id_user' +
                                 '   WHERE cd_operadora = :cd_operadora');
         dm.ADOQSQL.Parameters.ParamByName('cd_operadora').Value := edtCodigo.Text;
      end;
   dm.ADOQSQL.Parameters.ParamByName('ds_operadora').Value := edtOperadora.Text;
   dm.ADOQSQL.Parameters.ParamByName('id_user').Value := FormLogin.id_user;
   dm.ADOQSQL.ExecSQL;
   dm.ADOQoperadora.Close;
   dm.ADOQoperadora.Open;
end;

procedure TFormOperadora.dbgOperadoraCellClick(Column: TColumn);
begin
  inherited;
   edtCodigo.Text := dbgOperadora.Columns.Items[0].Field.AsString;
   edtOperadora.Text := dbgOperadora.Columns.Items[1].Field.AsString;
   tag := 2;
end;

procedure TFormOperadora.Novo1Click(Sender: TObject);
begin
  inherited;
   tag := 1;
   edtCodigo.Clear;
   edtOperadora.Clear;
   btnGravar.Enabled := True;
   edtOperadora.SetFocus;
end;

procedure TFormOperadora.btnExcluirClick(Sender: TObject);
begin
  inherited;
   if MessageDlg('Deseja realmente excluir as infromações?', mtConfirmation, [mbYes, mbNo], 0)  = mrYes then
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('DELETE FROM operadora WHERE cd_operadora = :cd_operadora');
         dm.ADOQSQL.Parameters.ParamByName('cd_operadora').Value := edtCodigo.Text;
         dm.ADOQSQL.ExecSQL;
         MessageDlg('Registro excluido com sucesso.', mtInformation, [mbOK], 0);
      end;
   dm.ADOQoperadora.Close;
   dm.ADOQoperadora.Open;
   edtCodigo.Clear;
   edtOperadora.Clear;
end;

procedure TFormOperadora.btnRelatorioClick(Sender: TObject);
begin
  inherited;
   dm.ADOQoperadora.Open;
   FormRelOperadora := TFormRelOperadora.Create(Application);
   FormRelOperadora.rlrRelatorio.Preview();
end;

end.
