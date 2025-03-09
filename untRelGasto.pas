unit untRelGasto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLReport, jpeg, ComCtrls, RLFilters,
  RLPDFFilter, RLParser, DB;

type
  TFormRelGasto = class(TFormRelPadrao)
    rldbUsina: TRLDBText;
    rldbNumero: TRLDBText;
    rldbValor: TRLDBText;
    rldbNome: TRLDBText;
    dsGasto: TDataSource;
    RLExpressionParser1: TRLExpressionParser;
    RLPDFFilter1: TRLPDFFilter;
    dsUsina: TDataSource;
    rlUnidade: TRLLabel;
    rlNumero: TRLLabel;
    rlVlmes: TRLLabel;
    rlFuncionario: TRLLabel;
    rldbDataRef: TRLDBText;
    rlDatavenc: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelGasto: TFormRelGasto;

implementation

uses untDM, untGasto;

{$R *.dfm}

end.
