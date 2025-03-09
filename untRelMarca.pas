unit untRelMarca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, DB, RLReport, jpeg, ComCtrls, RLFilters,
  RLPDFFilter, RLParser;

type
  TFormRelMarca = class(TFormRelPadrao)
    RLExpressionParser: TRLExpressionParser;
    rlpdPDF: TRLPDFFilter;
    dsMarca: TDataSource;
    rllCodigo: TRLLabel;
    rllDescricao: TRLLabel;
    rldbCodigo: TRLDBText;
    rldbDescricao: TRLDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelMarca: TFormRelMarca;

implementation

uses untDM;

{$R *.dfm}

procedure TFormRelMarca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQmarca.Close;
end;

end.
