unit untRelUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, DB, RLReport, jpeg, ComCtrls;

type
  TFormRelUsuario = class(TFormRelPadrao)
    dsUsuario: TDataSource;
    rllMatricula: TRLLabel;
    rllNome: TRLLabel;
    rllCargo: TRLLabel;
    rllUnidade: TRLLabel;
    rldbMatricula: TRLDBText;
    rldbNome: TRLDBText;
    rldbCargo: TRLDBText;
    rldbUnidade: TRLDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelUsuario: TFormRelUsuario;

implementation

uses untDM;

{$R *.dfm}

procedure TFormRelUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQusuario.Close;
end;

end.
