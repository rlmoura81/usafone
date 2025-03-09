unit untRelListaTelefone;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLReport, jpeg, ComCtrls, RLFilters,
  RLPDFFilter, RLParser, DB;

type
  TFormRelListaTelefone = class(TFormRelPadrao)
    RLExpressionParser: TRLExpressionParser;
    rlpPDF: TRLPDFFilter;
    rldbNome: TRLDBText;
    rldbNumero: TRLDBText;
    dsListaFone: TDataSource;
    dsFuncionario: TDataSource;
    rldbFuncionario: TRLDBText;
    rldbUnidade: TRLDBText;
    dsUsina: TDataSource;
    RLBand1: TRLBand;
    rllDescricao: TRLLabel;
    rllNumero: TRLLabel;
    rlNum: TRLLabel;
    rldbNum: TRLDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelListaTelefone: TFormRelListaTelefone;

implementation

uses untListaTelefone, untDM;

{$R *.dfm}

procedure TFormRelListaTelefone.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQlistafone.Close;
end;

end.
