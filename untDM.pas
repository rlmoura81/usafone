unit untDM;

interface

uses
  SysUtils, Classes, DB, ADODB, DBXpress;

type
  Tdm = class(TDataModule)
    ADOusafone: TADOConnection;
    ADOQmarca: TADOQuery;
    dsMarca: TDataSource;
    ADOQSQL: TADOQuery;
    ADOQmodelo: TADOQuery;
    dsModelo: TDataSource;
    ADOQcidade: TADOQuery;
    dsCidade: TDataSource;
    ADOQoperadora: TADOQuery;
    dsOperadora: TDataSource;
    ADOQusina: TADOQuery;
    dsUsina: TDataSource;
    ADOQusuario: TADOQuery;
    dsUsuario: TDataSource;
    ADOQaparelho: TADOQuery;
    dsAparelho: TDataSource;
    ADOQchip: TADOQuery;
    dsChip: TDataSource;
    ADOQlistafone: TADOQuery;
    dsListafone: TDataSource;
    ADOQagenda: TADOQuery;
    dsAgenda: TDataSource;
    ADOQacesso: TADOQuery;
    dsAcesso: TDataSource;
    ADOQestoque: TADOQuery;
    dsEstoque: TDataSource;
    dsGasto: TDataSource;
    ADOQgasto: TADOQuery;
    ADOQblackberry: TADOQuery;
    dsBlackberry: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

end.
