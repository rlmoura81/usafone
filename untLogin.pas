unit untLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormLogin = class(TFormPadrao)
    edtLogin: TLabeledEdit;
    edtSenha: TLabeledEdit;
    btnOK: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
  function Validar: Boolean;
    { Private declarations }
  public
     id_user, ac: Integer;
     nm_user: String;
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

uses untDM, Math, DB, untPrincipal;

{$R *.dfm}

procedure TFormLogin.btnCancelarClick(Sender: TObject);
begin
  inherited;
   Application.Terminate;
end;

procedure TFormLogin.btnOKClick(Sender: TObject);
var
acesso: Integer;
senha_bd, senha_edt, login: String;

begin
  inherited;
   if not Validar then
      exit;
   senha_edt := edtSenha.Text;
   //LOGIN
   begin
      dm.ADOQSQL.SQL.Clear;
      dm.ADOQSQL.SQL.Text := ('SELECT (acesso.cd_acesso) as acesso, (usuario.cd_matricula) as id_user, (acesso.cd_senha) as senha' +
                              '   FROM acesso, usuario ' +
                              '   WHERE acesso.cd_matricula = usuario.cd_matricula AND ' +
                              '      acesso.ds_login = :ds_login');
      dm.ADOQSQL.Parameters.ParamByName('ds_login').Value := edtLogin.Text;
         try
            dm.ADOQSQL.Open;
            acesso := dm.ADOQSQL.FieldByName('acesso').AsInteger;
            id_user := dm.ADOQSQL.FieldByName('id_user').AsInteger;
            senha_bd := dm.ADOQSQL.FieldByName('senha').AsString;
         except
            acesso := null;
         end;
      dm.ADOQSQL.Close;
   end;
   if senha_bd <> senha_edt then
      begin
         MessageDlg('Usuário ou senha incorreta.', mtError, [mbOK], 0);
         edtLogin.Clear;
         edtSenha.Clear;
         edtLogin.SetFocus;
         exit;
      end;

   nm_user := edtLogin.Text;
   ac := acesso;

   FormPrincipal := TFormPrincipal.Create(Application);
   FormPrincipal.ShowModal;
end;

//FUNCAO VALIDAR LOGIN
function TFormLogin.Validar: Boolean;
begin
   result := False;
   if Trim(edtLogin.Text) = '' then
      begin
         MessageDlg('Digite o login de acesso.', mtInformation, [mbOK], 0);
         edtLogin.SetFocus;
         exit;
      end else
   if Trim(edtSenha.Text) = '' then
      begin
         MessageDlg('Digite a senha de acesso.', mtInformation, [mbOK], 0);
         edtSenha.SetFocus;
         exit;
      end else
      begin
         Result := True;
      end;
end;

procedure TFormLogin.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      edtSenha.SetFocus;
end;

procedure TFormLogin.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if key = #13 then
      btnOK.SetFocus; 
end;

procedure TFormLogin.FormShow(Sender: TObject);
begin
  inherited;
   edtLogin.Clear;
   edtSenha.Clear;
   edtLogin.SetFocus;
end;

end.
