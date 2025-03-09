unit untSenha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFormSenha = class(TFormPadrao)
    pnlControl: TPanel;
    edtSenha: TLabeledEdit;
    btnGravar: TBitBtn;
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSenha: TFormSenha;

implementation

uses untDM, untLogin;

{$R *.dfm}

procedure TFormSenha.btnGravarClick(Sender: TObject);
begin
  inherited;
   if edtSenha.Text = '' then
      begin
         MessageDlg('Digite a senha.', mtInformation, [mbOK], 0);
         edtSenha.SetFocus;
         exit;
      end;
      begin
         dm.ADOQSQL.SQL.Clear;
         dm.ADOQSQL.SQL.Text := ('UPDATE acesso SET cd_senha = :cd_senha' +
                                 '   WHERE cd_matricula = :cd_matricula');
         dm.ADOQSQL.Parameters.ParamByName('cd_senha').Value := edtSenha.Text;
         dm.ADOQSQL.Parameters.ParamByName('cd_matricula').Value := FormLogin.id_user;
         dm.ADOQSQL.ExecSQL;
      end;
         MessageDlg('Senha alterada.', mtConfirmation, [mbOK], 0);
         FormSenha.Close;
end;

procedure TFormSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   Action := caFree;
end;

procedure TFormSenha.FormShow(Sender: TObject);
begin
  inherited;
   edtSenha.SetFocus;
end;

end.
