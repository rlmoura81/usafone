unit untRelOperadora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLReport, DB, jpeg, ComCtrls, RLFilters,
  RLPDFFilter, RLParser;

type
  TFormRelOperadora = class(TFormRelPadrao)
    dsOperadora: TDataSource;
    rllCodigo: TRLLabel;
    rllDescircao: TRLLabel;
    rldbCodigo: TRLDBText;
    rldbDescricao: TRLDBText;
    RLExpressionParser: TRLExpressionParser;
    rlpdPDF: TRLPDFFilter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelOperadora: TFormRelOperadora;

implementation

uses untDM;

{$R *.dfm}

procedure TFormRelOperadora.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQoperadora.Close;
end;

end.
