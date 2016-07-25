unit dmplugin;

interface

uses DMPluginIntf;
type
  TDMPluginInfo = record
    PluginID:string;//обязательно укажите свой уникальный номер плагина (используйте Ctrl+Shift+G для генерации)
    PluginName:string;//название плагина на английском языке
    PluginVersion:string; // '0.1.1.1';
    PluginEmail:string;//'slava@westbyte.com';
    PluginHomePage:string;//'http://www.westbyte.com/dm/';
    PluginCopyRight:string;///'©2006 WestByte';
    MinNeedAppVersion:string;//'5.0.2';//версия указывается без билда
    //описание плагина. Должно быть представлено на русском и английском языках. Может содержать подробную инструкцию по пользованию плагином.
    PluginDescription:string;//'Test Plug-in for show how create plugins for DM';
    PluginDescriptionRussian:string;//'Тестовый плагин для демонстрации как создавать плагины для DM. Является одновременно шаблоном для создания плагинов. Язык реализации Delphi 7.';
  end;

  TDMPlugIn = class(TInterfacedObject, IDMPlugIn)
  private
    FIDmInterface: IDmInterface;
    FPluginInfo:TDMPluginInfo;
    { IDMPlugIn }
    function GetID: WideString; stdcall;
    function GetName: WideString; stdcall;//получаем инфу о плагине
    function GetVersion: WideString; stdcall;//получаем инфу о плагине
    function GetDescription(language: WideString): WideString; stdcall;//получаем инфу о плагине
    function GetEmail: WideString; stdcall;//получаем инфу о плагине
    function GetHomepage: WideString; stdcall;//получаем инфу о плагине
    function GetCopyright: WideString; stdcall;//получаем инфу о плагине
    function GetMinAppVersion: WideString; stdcall;//получаем минимальную версию ДМ-а с которой может работать плагин
    //------
    procedure PluginInit(_IDmInterface: IDmInterface); stdcall;//инициализация плагина и передача интерфейса для доступа к ДМ
    procedure PluginConfigure(params: WideString); stdcall;//вызов окна конфигурации плагина
    procedure BeforeUnload; stdcall;//вызывается перед удалением плагина

    function EventRaised(eventType: WideString; eventData: WideString): WideString; stdcall;//вызывается из ДМ-ма при возникновении какого либо события
  protected
    procedure GetPlugInInfo(var PluginInfo:TDMPluginInfo);virtual;abstract;
    procedure DoPluginInit;virtual;abstract;
    procedure DoPluginConfigure(params:widestring);virtual;abstract;
    procedure DoBefoUnload;virtual;abstract;
    function DoEventRaised(eventType: WideString; eventData: WideString): WideString; virtual;abstract;
  public
    { идентификатор плагина }
    property ID: WideString read getID;
    property DownloadMaster:IDMInterface read Fidminterface;
    constructor Create;
  end;

implementation
//------------------------------------------------------------------------------

function TDMPlugIn.GetName: WideString;
begin
  Result := FPluginInfo.PluginName;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetVersion: WideString;//получаем инфу о плагине
begin
  Result := FPluginInfo.PluginVersion;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetDescription(language: WideString): WideString;//получаем инфу о плагине
begin
  if (language = 'russian') or (language = 'ukrainian') or (language = 'belarusian') then
    Result := FPluginInfo.PluginDescriptionRussian
  else
    Result := FPluginInfo.PluginDescription;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.getID: WideString; stdcall;
begin
  Result:= FPluginInfo.PluginID;
end;
//------------------------------------------------------------------------------
procedure TDMPlugIn.PluginInit(_IDmInterface: IDmInterface);//инициализация плагина и передача интерфейса для доступа к ДМ
begin
  FIDmInterface := _IDmInterface;
end;
//------------------------------------------------------------------------------
procedure TDMPlugIn.BeforeUnload;
begin
  FIDmInterface := nil;
//  ShowMessage('Выгружаем плагин '+myPluginName);
end;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function TDMPlugIn.EventRaised(eventType: WideString; eventData: WideString): WideString;//вызывается из ДМ-ма при возникновении какого либо события
begin
  result:=DOEventRaised(eventType,eventData);
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetEmail: WideString;//получаем инфу о плагине
begin
  Result:= FPluginInfo.PluginEmail;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetHomepage: WideString;//получаем инфу о плагине
begin
  Result:= FPluginInfo.PluginHomePage;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetCopyright: WideString;//получаем инфу о плагине
begin
  Result:= FPluginInfo.PluginCopyright;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetMinAppVersion: WideString;//получаем минимальную версию ДМ-а с которой может работать плагин
begin
  Result:= FPluginInfo.MinNeedAppVersion;
end;
//------------------------------------------------------------------------------

constructor TDMPlugIn.Create;
begin
  inherited;
  fillchar(FPluginInfo,sizeof(fplugininfo),0);
  GetPlugInInfo(FPlugininfo);
end;

procedure TDMPlugIn.PluginConfigure(params: WideString);
begin
  DoPluginConfigure(params);
end;

end.
