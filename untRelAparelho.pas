unit untRelAparelho;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLReport, jpeg, ComCtrls, RLFilters,
  RLPDFFilter, RLParser, DB;

type
  TFormRelAparelhos = class(TFormRelPadrao)
    RLExpressionParser: TRLExpressionParser;
    rlPDF: TRLPDFFilter;
    rldbMarca: TRLDBText;
    rldbModelo: TRLDBText;
    rldbOperadora: TRLDBText;
    rldbQtde: TRLDBText;
    rllMarca: TRLLabel;
    rllModelo: TRLLabel;
    rllOperadora: TRLLabel;
    rllQtde: TRLLabel;
    dsAparelho: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelAparelhos: TFormRelAparelhos;

implementation

uses untDM;

{$R *.dfm}

procedure TFormRelAparelhos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQaparelho.Close;
end;

end.
