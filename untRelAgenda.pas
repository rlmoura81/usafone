unit untRelAgenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoRelatorio, RLReport, jpeg, ComCtrls, DB, RLFilters,
  RLPDFFilter, RLParser;

type
  TFormRelAgenda = class(TFormRelPadrao)
    rllUnidade: TRLLabel;
    rllFuncionario: TRLLabel;
    rllOperadora: TRLLabel;
    rllNumero: TRLLabel;
    rllAparelho: TRLLabel;
    dsAgenda: TDataSource;
    RLExpressionParser: TRLExpressionParser;
    rlpdPDF: TRLPDFFilter;
    rldbFuncionario: TRLDBText;
    rldbOperdora: TRLDBText;
    rldbNumero: TRLDBText;
    rldbModelo: TRLDBText;
    dsUsina: TDataSource;
    rldbUsina: TRLDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelAgenda: TFormRelAgenda;

implementation

uses untDM;

{$R *.dfm}

procedure TFormRelAgenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   dm.ADOQagenda.Close;
end;

end.
