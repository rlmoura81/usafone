unit untRelCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLReport, jpeg, ComCtrls, RLFilters,
  RLPDFFilter, RLParser, DB;

type
  TFormRelCidade = class(TFormRelPadrao)
    rllCodigo: TRLLabel;
    rllCidade: TRLLabel;
    rllEstado: TRLLabel;
    rldbCodigo: TRLDBText;
    rldbCidade: TRLDBText;
    rldbEstado: TRLDBText;
    RLExpressionParser: TRLExpressionParser;
    rlpdPDF: TRLPDFFilter;
    dsCidade: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelCidade: TFormRelCidade;

implementation

uses untDM;

{$R *.dfm}

procedure TFormRelCidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQcidade.Close;
end;

end.
