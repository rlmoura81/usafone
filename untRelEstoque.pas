unit untRelEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLFilters, RLPDFFilter, RLParser, DB,
  RLReport, jpeg, ComCtrls;

type
  TFormRelEstoque = class(TFormRelPadrao)
    dsEstoque: TDataSource;
    RLExpressionParser: TRLExpressionParser;
    rlPDF: TRLPDFFilter;
    rllUsuario: TRLLabel;
    rllMarca: TRLLabel;
    rllModelo: TRLLabel;
    rllQtde: TRLLabel;
    rllData: TRLLabel;
    rldbUsuario: TRLDBText;
    rldbMarca: TRLDBText;
    rldbModelo: TRLDBText;
    rldbQtde: TRLDBText;
    rldbData: TRLDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelEstoque: TFormRelEstoque;

implementation

uses untEstoque, untDM;

{$R *.dfm}

end.
