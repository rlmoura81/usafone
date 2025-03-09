unit untRelModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLFilters, RLPDFFilter, RLParser, DB,
  RLReport, jpeg, ComCtrls;

type
  TFormRelModelo = class(TFormRelPadrao)
    dsModelo: TDataSource;
    RLExpressionParser: TRLExpressionParser;
    rlpdPDF: TRLPDFFilter;
    rllCodigo: TRLLabel;
    rllMarca: TRLLabel;
    rllModelo: TRLLabel;
    rldbCodigo: TRLDBText;
    rldbMarca: TRLDBText;
    rldbModelo: TRLDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelModelo: TFormRelModelo;

implementation

uses untDM;

{$R *.dfm}

procedure TFormRelModelo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQmodelo.Close;
end;

end.
