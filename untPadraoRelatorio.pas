unit untPadraoRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPadraoGeral, RLReport, jpeg, ComCtrls, RLParser, RLFilters,
  RLPDFFilter, DB;

type
  TFormRelPadrao = class(TFormPadrao)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelPadrao: TFormRelPadrao;

implementation

uses untCidade, untDM;

{$R *.dfm}

procedure TFormRelPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   Action := caFree;
end;

end.
