unit untRelBlackberry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLReport, jpeg, ComCtrls, StdCtrls,
  RLParser, RLFilters, RLPDFFilter, DB;

type
  TFormRelBlackberry = class(TFormRelPadrao)
    rldbFuncionario: TRLDBText;
    rldbCargo: TRLDBText;
    rldbNumero: TRLDBText;
    rldbPin: TRLDBText;
    rldbImei: TRLDBText;
    rldbModelo: TRLDBText;
    RLPDFFilter1: TRLPDFFilter;
    RLExpressionParser1: TRLExpressionParser;
    rlFuncionario: TRLLabel;
    rlCargo: TRLLabel;
    rlNumero: TRLLabel;
    rlPin: TRLLabel;
    rlImei: TRLLabel;
    rlModelo: TRLLabel;
    rlUnidade: TRLLabel;
    rldbUnidade: TRLDBText;
    rlNum: TRLLabel;
    rldbNum: TRLDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelBlackberry: TFormRelBlackberry;

implementation

uses untDM, untBlackberry;

{$R *.dfm}

end.
