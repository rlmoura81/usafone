unit untRelChip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLFilters, RLPDFFilter, RLParser, DB,
  RLReport, jpeg, ComCtrls;

type
  TFormRelChip = class(TFormRelPadrao)
    dsCHIP: TDataSource;
    RLExpressionParser: TRLExpressionParser;
    rlpdPDF: TRLPDFFilter;
    rllUnidade: TRLLabel;
    rllNumero: TRLLabel;
    rllIMEI: TRLLabel;
    rllPin2: TRLLabel;
    RLLOperadora: TRLLabel;
    rldbUsina: TRLDBText;
    rldbNumero: TRLDBText;
    rldbIMEI: TRLDBText;
    rldbPin2: TRLDBText;
    rldbOperadora: TRLDBText;
    RLLabel1: TRLLabel;
    rldbST: TRLDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelChip: TFormRelChip;

implementation

uses untDM;

{$R *.dfm}

procedure TFormRelChip.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQchip.Close;
end;

end.
