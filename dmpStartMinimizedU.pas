unit dmpStartMinimizedU;

interface

uses
  Windows,DMPluginIntf,dmplugin;

type
  TDmStartMinimizedPlugin=class(TDmPlugin)
  protected
    procedure GetPlugInInfo(var PluginInfo:TDMPluginInfo);override;
    procedure DoPluginInit;override;
    procedure DoPluginConfigure(params:widestring);override;
    procedure DoBefoUnload;override;
    function DoEventRaised(eventType: WideString; eventData: WideString): WideString;override;

    function GetDmWindow:HWND;
  end;

function RegisterPlugIn: IDMPlugIn; stdcall;

implementation
uses
  shellApi,Messages;

function RegisterPlugIn: IDMPlugIn; stdcall;
begin
  try
    Result := TDmStartMinimizedPlugin.Create as IDMPlugin;
  except
    Result := nil;
  end;
end;


{ TDmStartMinimizedPlugin }

procedure TDmStartMinimizedPlugin.DoBefoUnload;
begin
  // nothing to do
end;

function TDmStartMinimizedPlugin.DoEventRaised(eventType,
  eventData: WideString): WideString;
var
  H:HWND;
begin
 if eventType = 'dm_start' then
 begin
   h:=GetDmWindow;
   if h<> 0 then
   begin
     ShowWindow(h,SW_MINIMIZE);
//     CloseWindow(h);
        ShowWindow(h,sw_hide);
//        Postmessage(h,WM_CLoSE,0,0);
//        DestroyWindow(h);
   end;
 end;

end;

procedure TDmStartMinimizedPlugin.DoPluginConfigure(params: widestring);
begin
  ShellAboutW(GetDmWindow,'Download Master Start Minimized PlugIn', 'Copyright © 2007 by AZ',
        LoadIcon(GetModuleHandle(nil),'MAINICON'));
end;

procedure TDmStartMinimizedPlugin.DoPluginInit;
begin

end;

function TDmStartMinimizedPlugin.GetDmWindow: HWND;
begin
//  result:=FindWindowW('TMainForm','Download Master 5.2.1.1055');
  result:=FindWindowW('TApplication','Download Master');
end;

procedure TDmStartMinimizedPlugin.GetPlugInInfo(
  var PluginInfo: TDMPluginInfo);
begin
  With PluginInfo do
  begin
    PluginID := '{FE3F8FA2-6AE7-4235-AEB7-417D90C2BADE}';
    PluginName := 'Start Minimized';
    PluginVersion := '0.1.0.0';
    PluginEmail := 'lev-money@mail.ru';
    PluginHomePage := '';
    PluginCopyRight := 'Copyright © 2007 by AZ';
    MinNeedAppVersion := '5.0.0';
    PluginDescription := 'Minimize Download Master when it starts';
    PluginDescriptionRussian := 'Сворачивает Download Master при запуске'; 
  end;

end;

end.
