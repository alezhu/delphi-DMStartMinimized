unit dmtest_pluginImpl;

interface

uses DMPluginIntf, Classes, Dialogs;
const
  //укажите здесь информацию о своем плагине
  myPluginID = '{45145BBE-DCAE-4187-B981-FE9410F6DA5D}';//обязательно укажите свой уникальный номер плагина (используйте Ctrl+Shift+G для генерации)
  myPluginName = 'Download Master Test Plug-in';//название плагина на английском языке
  myPluginVersion = '0.1.1.1';
  myPluginEmail = 'slava@westbyte.com';
  myPluginHomePage = 'http://www.westbyte.com/dm/';
  myPluginCopyRight = chr(169)+'2006 WestByte';
  myMinNeedAppVersion = '5.0.2';//версия указывается без билда
  //описание плагина. Должно быть представлено на русском и английском языках. Может содержать подробную инструкцию по пользованию плагином.
  myPluginDescription = 'Test Plug-in for show how create plugins for DM';
  myPluginDescriptionRussian = 'Тестовый плагин для демонстрации как создавать плагины для DM. Является одновременно шаблоном для создания плагинов. Язык реализации Delphi 7.';
  
type
TDMTestPlugIn = class(TInterfacedObject, IDMPlugIn)
  private
    myIDmInterface: IDmInterface;
  protected

  public
    function getID: WideString; stdcall;
    //-----info
    function GetName: WideString; stdcall;//получаем инфу о плагине
    function GetVersion: WideString; stdcall;//получаем инфу о плагине
    function GetDescription(language: WideString): WideString; stdcall;//получаем инфу о плагине
    function GetEmail: WideString; stdcall;//получаем инфу о плагине
    function GetHomepage: WideString; stdcall;//получаем инфу о плагине
    function GetCopyright: WideString; stdcall;//получаем инфу о плагине
    function GetMinAppVersion: WideString; stdcall;//получаем минимальную версию ДМ-а с которой может работать плагин

    //------
    procedure PluginInit(_IDmInterface: IDmInterface); stdcall;//инициализация плагина и передача интерфейса для доступа к ДМ
    procedure PluginConfigure(params: WideString); stdcall;//вызов окна конфигурации плагина (окно конфигурации реализуется вами самостоятельно)
    procedure BeforeUnload; stdcall;//вызывается перед удалением плагина

    function EventRaised(eventType: WideString; eventData: WideString): WideString; stdcall;//вызывается из ДМ-ма при возникновении какого либо события
    { идентификатор плагина }
    property ID: WideString read getID;

  published

end;

implementation
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetName: WideString;//получаем инфу о плагине
begin
  Result := myPluginName;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetVersion: WideString;//получаем инфу о плагине
begin
  Result := myPluginVersion;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetDescription(language: WideString): WideString;//получаем инфу о плагине
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
procedure TDMTestPlugIn.PluginInit(_IDmInterface: IDmInterface);//инициализация плагина и передача интерфейса для доступа к ДМ
begin
  myIDmInterface := _IDmInterface;
end;
//------------------------------------------------------------------------------
procedure TDMTestPlugIn.BeforeUnload;
begin
  myIDmInterface := nil;
//  ShowMessage('Выгружаем плагин '+myPluginName);
end;
//------------------------------------------------------------------------------
procedure TDMTestPlugIn.PluginConfigure(params: WideString);//вызов окна конфигурации плагина
begin
  ShowMessage('Showing config form');
  myIDmInterface.DoAction('AddingURL', '<url>http://www.westbyte.com/plugin</url> <sectionslimit>2</sectionslimit>');
//  ShowMessage(myIDmInterface.DoAction('GetDownloadIDsList', '3'));
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.EventRaised(eventType: WideString; eventData: WideString): WideString;//вызывается из ДМ-ма при возникновении какого либо события
begin
  if eventType = 'dm_download_added' then
    ShowMessage('Added ID='+eventData);
//  ShowMessage('Event RAISE'+#13#10+'eventType='+eventType+#13#10+'eventData='+eventData);
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetEmail: WideString;//получаем инфу о плагине
begin
  Result:= myPluginEmail;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetHomepage: WideString;//получаем инфу о плагине
begin
  Result:= myPluginHomePage;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetCopyright: WideString;//получаем инфу о плагине
begin
  Result:= myPluginCopyright;
end;
//------------------------------------------------------------------------------
function TDMTestPlugIn.GetMinAppVersion: WideString;//получаем минимальную версию ДМ-а с которой может работать плагин
begin
  Result:= myMinNeedAppVersion;
end;
//------------------------------------------------------------------------------

end.
