unit untPadraoGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls;

type
  TFormPadrao = class(TForm)
    StatusBar1: TStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPadrao: TFormPadrao;

implementation

{$R *.dfm}

procedure TFormPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.

