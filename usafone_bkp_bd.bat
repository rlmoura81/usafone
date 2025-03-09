@echo off
echo ****************************
echo RLMHOME/Administrator:
echo Etapa 1:
echo    Exportando base de dados
echo ****************************

cd\

Exp usafone/usafone@rlm full=y statistics=none buffer=10000000 consistent=y file=c:\exp_full.dmp log=c:\exp_full.log

echo ****************************
echo RLMHOME/Administrator:
echo Etapa 2:
echo    Movendo base de dados
echo ****************************

move c:\exp_full.dmp d:\programas\delphi_rlm\usacucar\usafone\bd\

move c:\exp_full.log d:\programas\delphi_rlm\usacucar\usafone\bd\

