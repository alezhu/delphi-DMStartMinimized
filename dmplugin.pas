unit dmplugin;

interface

uses DMPluginIntf;
type
  TDMPluginInfo = record
    PluginID:string;//����������� ������� ���� ���������� ����� ������� (����������� Ctrl+Shift+G ��� ���������)
    PluginName:string;//�������� ������� �� ���������� �����
    PluginVersion:string; // '0.1.1.1';
    PluginEmail:string;//'slava@westbyte.com';
    PluginHomePage:string;//'http://www.westbyte.com/dm/';
    PluginCopyRight:string;///'�2006 WestByte';
    MinNeedAppVersion:string;//'5.0.2';//������ ����������� ��� �����
    //�������� �������. ������ ���� ������������ �� ������� � ���������� ������. ����� ��������� ��������� ���������� �� ����������� ��������.
    PluginDescription:string;//'Test Plug-in for show how create plugins for DM';
    PluginDescriptionRussian:string;//'�������� ������ ��� ������������ ��� ��������� ������� ��� DM. �������� ������������ �������� ��� �������� ��������. ���� ���������� Delphi 7.';
  end;

  TDMPlugIn = class(TInterfacedObject, IDMPlugIn)
  private
    FIDmInterface: IDmInterface;
    FPluginInfo:TDMPluginInfo;
    { IDMPlugIn }
    function GetID: WideString; stdcall;
    function GetName: WideString; stdcall;//�������� ���� � �������
    function GetVersion: WideString; stdcall;//�������� ���� � �������
    function GetDescription(language: WideString): WideString; stdcall;//�������� ���� � �������
    function GetEmail: WideString; stdcall;//�������� ���� � �������
    function GetHomepage: WideString; stdcall;//�������� ���� � �������
    function GetCopyright: WideString; stdcall;//�������� ���� � �������
    function GetMinAppVersion: WideString; stdcall;//�������� ����������� ������ ��-� � ������� ����� �������� ������
    //------
    procedure PluginInit(_IDmInterface: IDmInterface); stdcall;//������������� ������� � �������� ���������� ��� ������� � ��
    procedure PluginConfigure(params: WideString); stdcall;//����� ���� ������������ �������
    procedure BeforeUnload; stdcall;//���������� ����� ��������� �������

    function EventRaised(eventType: WideString; eventData: WideString): WideString; stdcall;//���������� �� ��-�� ��� ������������� ������ ���� �������
  protected
    procedure GetPlugInInfo(var PluginInfo:TDMPluginInfo);virtual;abstract;
    procedure DoPluginInit;virtual;abstract;
    procedure DoPluginConfigure(params:widestring);virtual;abstract;
    procedure DoBefoUnload;virtual;abstract;
    function DoEventRaised(eventType: WideString; eventData: WideString): WideString; virtual;abstract;
  public
    { ������������� ������� }
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
function TDMPlugIn.GetVersion: WideString;//�������� ���� � �������
begin
  Result := FPluginInfo.PluginVersion;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetDescription(language: WideString): WideString;//�������� ���� � �������
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
procedure TDMPlugIn.PluginInit(_IDmInterface: IDmInterface);//������������� ������� � �������� ���������� ��� ������� � ��
begin
  FIDmInterface := _IDmInterface;
end;
//------------------------------------------------------------------------------
procedure TDMPlugIn.BeforeUnload;
begin
  FIDmInterface := nil;
//  ShowMessage('��������� ������ '+myPluginName);
end;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
function TDMPlugIn.EventRaised(eventType: WideString; eventData: WideString): WideString;//���������� �� ��-�� ��� ������������� ������ ���� �������
begin
  result:=DOEventRaised(eventType,eventData);
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetEmail: WideString;//�������� ���� � �������
begin
  Result:= FPluginInfo.PluginEmail;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetHomepage: WideString;//�������� ���� � �������
begin
  Result:= FPluginInfo.PluginHomePage;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetCopyright: WideString;//�������� ���� � �������
begin
  Result:= FPluginInfo.PluginCopyright;
end;
//------------------------------------------------------------------------------
function TDMPlugIn.GetMinAppVersion: WideString;//�������� ����������� ������ ��-� � ������� ����� �������� ������
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
