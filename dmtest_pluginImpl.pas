unit dmtest_pluginImpl;

interface

uses DMPluginIntf, Classes, Dialogs;
const
  //������� ����� ���������� � ����� �������
  myPluginID = '{45145BBE-DCAE-4187-B981-FE9410F6DA5D}';//����������� ������� ���� ���������� ����� ������� (����������� Ctrl+Shift+G ��� ���������)
  myPluginName = 'Download Master Test Plug-in';//�������� ������� �� ���������� �����
  myPluginVersion = '0.1.1.1';
  myPluginEmail = 'slava@westbyte.com';
  myPluginHomePage = 'http://www.westbyte.com/dm/';
  myPluginCopyRight = chr(169)+'2006 WestByte';
  myMinNeedAppVersion = '5.0.2';//������ ����������� ��� �����
  //�������� �������. ������ ���� ������������ �� ������� � ���������� ������. ����� ��������� ��������� ���������� �� ����������� ��������.
  myPluginDescription = 'Test Plug-in for show how create plugins for DM';
  myPluginDescriptionRussian = '�������� ������ ��� ������������ ��� ��������� ������� ��� DM. �������� ������������ �������� ��� �������� ��������. ���� ���������� Delphi 7.';
  
type
TDMTestPlugIn = class(TInterfacedObject, IDMPlugIn)
  private
    myIDmInterface: IDmInterface;
  protected

  public
    function getID: WideString; stdcall;
    //-----info
    function GetName: WideString; stdcall;//�������� ���� � �������
    function GetVersion: WideString; stdcall;//�������� ���� � �������
    function GetDescription(language: WideString): WideString; stdcall;//�������� ���� � �������
    function GetEmail: WideString; stdcall;//�������� ���� � �������
    function GetHomepage: WideString; stdcall;//�������� ���� � �������
    function GetCopyright: WideString; stdcall;//�������� ���� � �������
    function GetMinAppVersion: WideString; stdcall;//�������� ����������� ������ ��-� � ������� ����� �������� ������

    //------
    procedure PluginInit(_IDmInterface: IDmInterface); stdcall;//������������� ������� � �������� ���������� ��� ������� � ��
    procedure PluginConfigure(params: WideString); stdcall;//����� ���� ������������ ������� (���� ������������ ����������� ���� ��������������)
    procedure BeforeUnload; stdcall;//���������� ����� ��������� �������

    function EventRaised(eventType: WideString; eventData: WideString): WideString; stdcall;//���������� �� ��-�� ��� ������������� ������ ���� �������
    { ������������� ������� }
    property ID: WideString read getID;

  published

end;

implementation
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetName: WideString;//�������� ���� � �������
begin
  Result := myPluginName;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetVersion: WideString;//�������� ���� � �������
begin
  Result := myPluginVersion;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetDescription(language: WideString): WideString;//�������� ���� � �������
begin
  if (language = 'russian') or (language = 'ukrainian') or (language = 'belarusian') then
    Result := myPluginDescriptionRussian
  else
    Result := myPluginDescription;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.getID: WideString; stdcall;
begin
  Result:= myPluginID;
end;
//------------------------------------------------------------------------------
procedure TDMTestPlugIn.PluginInit(_IDmInterface: IDmInterface);//������������� ������� � �������� ���������� ��� ������� � ��
begin
  myIDmInterface := _IDmInterface;
end;
//------------------------------------------------------------------------------
procedure TDMTestPlugIn.BeforeUnload;
begin
  myIDmInterface := nil;
//  ShowMessage('��������� ������ '+myPluginName);
end;
//------------------------------------------------------------------------------
procedure TDMTestPlugIn.PluginConfigure(params: WideString);//����� ���� ������������ �������
begin
  ShowMessage('Showing config form');
  myIDmInterface.DoAction('AddingURL', '<url>http://www.westbyte.com/plugin</url> <sectionslimit>2</sectionslimit>');
//  ShowMessage(myIDmInterface.DoAction('GetDownloadIDsList', '3'));
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.EventRaised(eventType: WideString; eventData: WideString): WideString;//���������� �� ��-�� ��� ������������� ������ ���� �������
begin
  if eventType = 'dm_download_added' then
    ShowMessage('Added ID='+eventData);
//  ShowMessage('Event RAISE'+#13#10+'eventType='+eventType+#13#10+'eventData='+eventData);
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetEmail: WideString;//�������� ���� � �������
begin
  Result:= myPluginEmail;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetHomepage: WideString;//�������� ���� � �������
begin
  Result:= myPluginHomePage;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetCopyright: WideString;//�������� ���� � �������
begin
  Result:= myPluginCopyright;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetMinAppVersion: WideString;//�������� ����������� ������ ��-� � ������� ����� �������� ������
begin
  Result:= myMinNeedAppVersion;
end;
//------------------------------------------------------------------------------

end.
