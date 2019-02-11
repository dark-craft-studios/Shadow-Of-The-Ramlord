#define MyAppName "The Shadow of the Ramlord"
#define RamlordCsFolderName "shadow-of-the-ramlord"
#define MyAppVersion "1.4"
#define MyAppPublisher "Dark Craft Studios"
#define MyAppURL "https://www.moddb.com/mods/the-shadow-of-the-ramlord"

#define AmnOtherLabel = "Other (Select the path yourself)"
#define AmnSteamLabel = "Amnesia: The Dark Descent (Steam)"
#define AmnDiscordLabel = "Amnesia: The Dark Descent (Discord)"
#define AmnRetailLabel = "Amnesia: The Dark Descent (Retail)"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{3DDECC9C-9772-441A-8F7E-2CEC8742A1B7}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#RamlordCsFolderName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=installer-res\license.rtf
InfoBeforeFile=installer-res\readme.rtf
OutputBaseFilename=amnesia-sotr-v1-4
SetupIconFile=installer-res\sotr.ico
Compression=lzma
SolidCompression=yes
UsePreviousAppDir=no
WizardSmallImageFile=installer-res\sotr-icon.bmp
WizardImageFile=installer-res\sotr-banner.bmp
DisableProgramGroupPage=yes
PrivilegesRequired=lowest

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\custom_story_settings.cfg"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\extra_english.lang"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\SOTR_thumbnail.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\entities\*"; DestDir: "{app}\entities"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\graphics\*"; DestDir: "{app}\graphics"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\maps\*"; DestDir: "{app}\maps"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\music\*"; DestDir: "{app}\music"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\sounds\*"; DestDir: "{app}\sounds"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\static_objects\*"; DestDir: "{app}\static_objects"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Program Files (x86)\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\shadow-of-the-ramlord\textures\*"; DestDir: "{app}\textures"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

[Code]
var
  AmnesiaDetectionPage: TInputOptionWizardPage;

procedure InitializeWizard;
begin
    { Page creation }

    AmnesiaDetectionPage := CreateInputOptionPage(wpInfoBefore,
        'Amnesia Location', 'Detected Amnesia copies',
        'Please select one of the found Amnesia installations on your machine:',
        True, False);

    AmnesiaDetectionPage.Add(ExpandConstant('{#AmnOtherLabel}'));
    AmnesiaDetectionPage.Values[0] := true;

    if DirExists(ExpandConstant('{pf32}\Steam\steamapps\common\Amnesia The Dark Descent')) then begin
        AmnesiaDetectionPage.Add(ExpandConstant('{#AmnSteamLabel}'));
    end;

    if DirExists(ExpandConstant('{localappdata}\DiscordGames\Amnesia The Dark Descent\content')) then begin
        AmnesiaDetectionPage.Add(ExpandConstant('{#AmnDiscordLabel}'));
    end;

    if DirExists(ExpandConstant('{pf32}\Amnesia - The Dark Descent\redist\custom_stories')) then begin
        AmnesiaDetectionPage.Add(ExpandConstant('{#AmnDiscordLabel}'));
    end;

end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  I: Integer;
  selectedIndex: Integer;
  selectedText: String;
begin
  if CurPageID = AmnesiaDetectionPage.ID then begin
    selectedIndex := AmnesiaDetectionPage.SelectedValueIndex;
    selectedText := AmnesiaDetectionPage.CheckListBox.ItemCaption[selectedIndex];

    Result := True;
    
    if(selectedText = ExpandConstant('{#AmnOtherLabel}')) then begin
      WizardForm.DirEdit.Text := ExpandConstant('{pf}\Amnesia\custom_stories\{#RamlordCsFolderName}');
    end else if (selectedText = ExpandConstant('{#AmnSteamLabel}')) then begin
      WizardForm.DirEdit.Text := ExpandConstant('{pf32}\Steam\steamapps\common\Amnesia The Dark Descent\custom_stories\{#RamlordCsFolderName}');
    end else if (selectedText = ExpandConstant('{#AmnDiscordLabel}')) then begin
      WizardForm.DirEdit.Text := ExpandConstant('{localappdata}\DiscordGames\Amnesia The Dark Descent\content\custom_stories\{#RamlordCsFolderName}');
    end else if (selectedText = ExpandConstant('{#AmnRetailLabel}')) then begin
      WizardForm.DirEdit.Text := ExpandConstant('{pf32}\Amnesia - The Dark Descent\redist\custom_stories');
    end;
  end else if (CurPageID = wpSelectDir) and not FileExists(ExpandConstant(WizardForm.DirEdit.Text + '\..\..\Launcher.exe')) then begin
    if MsgBox('The selected directory does not appear to be a valid Amnesia/custom_stories location. Do you want to force install into this directory?', mbConfirmation, MB_YESNO or MB_DEFBUTTON2) = IDYES then
    begin
      Result := True;
      exit;
    end;
    Result := False;
    exit;
  end else
    Result := True;
end;
