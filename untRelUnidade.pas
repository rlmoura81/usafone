unit untRelUnidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLReport, jpeg, ComCtrls, DB;

type
  TFormRelUnidade = class(TFormRelPadrao)
    dsUnidade: TDataSource;
    rllCodigo: TRLLabel;
    rllUnidade: TRLLabel;
    rllCidade: TRLLabel;
    rldbCodigo: TRLDBText;
    rldbUnidade: TRLDBText;
    rldbCidade: TRLDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelUnidade: TFormRelUnidade;

implementation

uses untDM;

{$R *.dfm}

procedure TFormRelUnidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQusina.Close;
end;

end.
