@echo off
echo ====================================
echo ��ӭʹ�� Hexo �������� ��ѡ������
echo ���ز��Ի��ϴ���վʱ�����Զ�������
echo ====================================
echo 1. �������߲���
echo 2. ���ز���
echo 3. �ϴ���վ
echo 4. ������
echo 5. �½�����
echo 6. �½�ҳ��
echo .
set /p input="��ѡ��������»س���"
if %input%==1 goto A
if %input%==2 goto B
if %input%==3 goto C
if %input%==4 goto D
if %input%==5 goto E
if %input%==6 goto F

:A
cls
start https://hipeach.eu.org
exit

:B
start cmd.exe /k "@echo off && hexo cl && echo. && echo �������� && hexo s && pause && exit"


:C
start cmd.exe /k "@echo off && hexo cl && echo. && echo �������� && hexo d && echo. && echo ָ������� ������������� && pause && cls && ���нű�.bat"
exit

:D
start cmd.exe /k "@echo off && hexo cl && echo. && echo �������� && pause && cls && ���нű�.bat"
exit

:E
cls
set /p t1="�����������ļ�����"
start cmd.exe /k "hexo n %t1% && echo. && echo ���� source/_posts Ŀ¼�������ļ���%t1%.md �� ��Դ�ļ��У� %t1% && pause && exit"
exit

:F
cls
set /p t2="���������ҳ���ļ�����"
start cmd.exe /k "hexo n page %t2% && echo. && echo ���� source Ŀ¼������һ���ļ��У� %t2% �����ļ����ڴ������ļ��� %t2%.md && pause && exit"
exit

pause


