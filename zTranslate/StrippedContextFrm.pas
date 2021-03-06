unit StrippedContextFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, System.TypInfo,

  System.Math,

  TextTable, DataFrameEngine, CoreClasses, ListEngine, DoStatusIO, MemoryStream64,
  UnicodeMixedLib, QuickTranslateFrm, TextParsing, PascalStrings, LogFrm;

type
  TEditorReturnProc = procedure(tb: TTextTable) of object;

  TStrippedContextForm = class(TForm)
    ToolWindowMainMenu: TMainMenu;
    ContextListPopupMenu: TPopupMenu;
    CategoryPopupMenu: TPopupMenu;
    ActionList: TActionList;
    File1: TMenuItem;
    Edit1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    RefreshAction: TAction;
    SaveToFileAction: TAction;
    LoadFromFileAction: TAction;
    ImportTextAction: TAction;
    ExportTextAction: TAction;
    OpenTextDialog: TOpenDialog;
    SaveTextDialog: TSaveDialog;
    LoadfromFile1: TMenuItem;
    SavetoFile1: TMenuItem;
    N1: TMenuItem;
    ImportText1: TMenuItem;
    ExportText1: TMenuItem;
    Refresh1: TMenuItem;
    ExitAction: TAction;
    N2: TMenuItem;
    Exit1: TMenuItem;
    SelectAllAction: TAction;
    InvSelectedAction: TAction;
    Selectall1: TMenuItem;
    invselect1: TMenuItem;
    MarkPickedAction: TAction;
    MarkUnPickedAction: TAction;
    Picked1: TMenuItem;
    UnPicked1: TMenuItem;
    Refresh2: TMenuItem;
    Selectall2: TMenuItem;
    invselect2: TMenuItem;
    Picked2: TMenuItem;
    UnPicked2: TMenuItem;
    TestAction: TAction;
    Selectall3: TMenuItem;
    invselect3: TMenuItem;
    Picked3: TMenuItem;
    UnPicked3: TMenuItem;
    TopSplitter: TSplitter;
    ShowOriginContextAction: TAction;
    ShowOrigincontext1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ShowOrigincontext2: TMenuItem;
    RestoreTranslationOriginAction: TAction;
    RestoreTranslation1: TMenuItem;
    RestoreTranslation2: TMenuItem;
    TopPanel: TPanel;
    TopRightSplitter: TSplitter;
    topRightPanel: TPanel;
    topRightTopPanel: TPanel;
    Label1: TLabel;
    UndoButton: TButton;
    SaveTextButton: TButton;
    DefineMemo: TMemo;
    ClientPanel: TPanel;
    LeftSplitter: TSplitter;
    CategoryList: TListView;
    ContextPanel: TPanel;
    ContextList: TListView;
    ContextTopPanel: TPanel;
    OriginFilterEdit: TLabeledEdit;
    DefineFilterEdit: TLabeledEdit;
    ools1: TMenuItem;
    QuickTranslateAction: TAction;
    QuickTranslate1: TMenuItem;
    QuickTranslateButton: TButton;
    EditorReturnAction: TAction;
    ReturntoCodeBuild1: TMenuItem;
    UsesSourAction: TAction;
    UsesDest1Action: TAction;
    UsesDest2Action: TAction;
    UsesDest3Action: TAction;
    NoDialogBatchTranslateAction: TAction;
    UsedSourceF11: TMenuItem;
    UsesDest11: TMenuItem;
    UsesDest21: TMenuItem;
    UsesDest31: TMenuItem;
    Batchtranslate1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Batchtranslate2: TMenuItem;
    N7: TMenuItem;
    BatchTranslateAction: TAction;
    Batchtranslate3: TMenuItem;
    Batchtranslate4: TMenuItem;
    CodeEdit: TMemo;
    DoFilterButton: TButton;
    UndoAction: TAction;
    Undo1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    Undo2: TMenuItem;
    N12: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RefreshActionExecute(Sender: TObject);
    procedure SaveToFileActionExecute(Sender: TObject);
    procedure LoadFromFileActionExecute(Sender: TObject);
    procedure ImportTextActionExecute(Sender: TObject);
    procedure ExportTextActionExecute(Sender: TObject);
    procedure ExitActionExecute(Sender: TObject);
    procedure SelectAllActionExecute(Sender: TObject);
    procedure InvSelectedActionExecute(Sender: TObject);
    procedure MarkPickedActionExecute(Sender: TObject);
    procedure MarkUnPickedActionExecute(Sender: TObject);
    procedure ShowOriginContextActionExecute(Sender: TObject);
    procedure TestActionExecute(Sender: TObject);
    procedure ContextListColumnClick(Sender: TObject; Column: TListColumn);
    procedure ContextListItemChecked(Sender: TObject; Item: TListItem);
    procedure ContextListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure CategoryListItemChecked(Sender: TObject; Item: TListItem);
    procedure RestoreTranslationOriginActionExecute(Sender: TObject);
    procedure QuickTranslateActionExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EditorReturnActionExecute(Sender: TObject);
    procedure SaveTextButtonClick(Sender: TObject);
    procedure UsesSourActionExecute(Sender: TObject);
    procedure UsesDest1ActionExecute(Sender: TObject);
    procedure UsesDest2ActionExecute(Sender: TObject);
    procedure UsesDest3ActionExecute(Sender: TObject);
    procedure DefineMemoChange(Sender: TObject);
    procedure NoDialogBatchTranslateActionExecute(Sender: TObject);
    procedure BatchTranslateActionExecute(Sender: TObject);
    procedure DoFilterButtonClick(Sender: TObject);
    procedure FilterEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UndoActionExecute(Sender: TObject);
  private
    FTextData        : TTextTable;
    FOpenListItm     : TListItem;
    FOpenPtr         : PTextTableItem;
    FOpenPtrIsModify : Boolean;
    FOnReturnProc    : TEditorReturnProc;
    FCategoryHashList: THashObjectList;

    function GetOpenEditorOriginText(p: PTextTableItem): umlString;
    function GetOpenEditorDefineText(p: PTextTableItem): umlString;

    procedure OpenTextEditor(p: PTextTableItem; itm: TListItem);
    procedure SaveTextEditor;
    procedure SetOnReturnProc(const Value: TEditorReturnProc);
  public
    property OnReturnProc: TEditorReturnProc read FOnReturnProc write SetOnReturnProc;

    procedure LoadNewCTFromStream(m64: TMemoryStream64);
    procedure NewCT;

    function ExistsCategory(c: string): Boolean;
    function CategoryIsSelected(c: string): Boolean;

    procedure RefreshTextList(rebuild: Boolean);
    procedure Clear;
    property TextData: TTextTable read FTextData;

    procedure SetCurrentTranslate(Text: string);
  end;

var
  StrippedContextForm: TStrippedContextForm;

implementation

{$R *.dfm}


uses BatchTransOptFrm, BaiduTranslateClient, zTranslateMainFrm;

procedure TStrippedContextForm.FormCreate(Sender: TObject);
begin
  FTextData := TTextTable.Create;
  FCategoryHashList := THashObjectList.Create(False, 8192);
  FOnReturnProc := nil;
end;

procedure TStrippedContextForm.FormShow(Sender: TObject);
begin
  LogForm.PopupParent := Self;
end;

procedure TStrippedContextForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseBaiduTranslate;
  FTextData.Clear;
  RefreshTextList(True);
  Action := caHide;
  LogForm.PopupParent := BuildCodeMainForm;
end;

procedure TStrippedContextForm.FormDestroy(Sender: TObject);
begin
  DisposeObject(FCategoryHashList);
  DisposeObject(FTextData);
end;

procedure TStrippedContextForm.RefreshActionExecute(Sender: TObject);
begin
  RefreshTextList(False);
end;

procedure TStrippedContextForm.SaveToFileActionExecute(Sender: TObject);
var
  m64: TMemoryStream64;
begin
  if not SaveDialog.Execute then
      exit;
  m64 := TMemoryStream64.Create;
  FTextData.SaveToStream(m64);
  m64.SaveToFile(SaveDialog.FileName);
  DisposeObject(m64);
end;

procedure TStrippedContextForm.LoadFromFileActionExecute(Sender: TObject);
var
  m64: TMemoryStream64;
begin
  if not OpenDialog.Execute then
      exit;
  m64 := TMemoryStream64.Create;
  m64.LoadFromFile(OpenDialog.FileName);
  m64.Position := 0;
  FTextData.LoadFromStream(m64);
  DisposeObject(m64);

  RefreshTextList(True);
end;

procedure TStrippedContextForm.ImportTextActionExecute(Sender: TObject);
var
  m64: TMemoryStream64;
begin
  if not OpenTextDialog.Execute then
      exit;
  m64 := TMemoryStream64.Create;
  m64.LoadFromFile(OpenTextDialog.FileName);
  m64.Position := 0;
  FTextData.ImportFromTextStream(m64);
  DisposeObject(m64);
end;

procedure TStrippedContextForm.ExportTextActionExecute(Sender: TObject);
var
  m64: TMemoryStream64;
begin
  if not SaveTextDialog.Execute then
      exit;
  m64 := TMemoryStream64.Create;
  FTextData.ExportToTextStream(m64);
  m64.SaveToFile(SaveTextDialog.FileName);
  DisposeObject(m64);
end;

procedure TStrippedContextForm.ExitActionExecute(Sender: TObject);
begin
  Close;
end;

procedure TStrippedContextForm.SelectAllActionExecute(Sender: TObject);
begin
  if ActiveControl = CategoryList then
      CategoryList.SelectAll
  else
      ContextList.SelectAll;
end;

procedure TStrippedContextForm.InvSelectedActionExecute(Sender: TObject);
var
  i: Integer;
begin
  if ActiveControl = CategoryList then
    begin
      for i := 0 to CategoryList.Items.Count - 1 do
        begin
          with CategoryList.Items[i] do
              Selected := not Selected;
        end;
    end
  else
    begin
      for i := 0 to ContextList.Items.Count - 1 do
        begin
          with ContextList.Items[i] do
              Selected := not Selected;
        end;
    end;

end;

procedure TStrippedContextForm.MarkPickedActionExecute(Sender: TObject);
var
  i: Integer;
begin
  if ActiveControl = CategoryList then
    begin
      for i := 0 to CategoryList.Items.Count - 1 do
        begin
          with CategoryList.Items[i] do
            if Selected then
                Checked := True;
        end;
    end
  else
    begin
      for i := 0 to ContextList.Items.Count - 1 do
        begin
          with ContextList.Items[i] do
            if Selected then
                Checked := True;
        end;
    end;
end;

procedure TStrippedContextForm.MarkUnPickedActionExecute(Sender: TObject);
var
  i: Integer;
begin
  if ActiveControl = CategoryList then
    begin
      for i := 0 to CategoryList.Items.Count - 1 do
        begin
          with CategoryList.Items[i] do
            if Selected then
                Checked := False;
        end;
    end
  else
    begin
      for i := 0 to ContextList.Items.Count - 1 do
        begin
          with ContextList.Items[i] do
            if Selected then
                Checked := False;
        end;
    end;
end;

procedure TStrippedContextForm.ShowOriginContextActionExecute(Sender: TObject);
begin
  with TAction(Sender) do
      Checked := not Checked;
  RefreshTextList(False);
end;

procedure TStrippedContextForm.TestActionExecute(Sender: TObject);
var
  m64: TMemoryStream64;
begin
  m64 := TMemoryStream64.Create;
  FTextData.ExportToTextStream(m64);
  m64.Position := 0;
  FTextData.ImportFromTextStream(m64);
  m64.free;
  RefreshTextList(True);
end;

function cv(const A, B: Integer): Integer; inline;
begin
  if A = B then
      Result := 0
  else if A < B then
      Result := -1
  else
      Result := 1;
end;

function WasWide(t: PPascalString): Byte; inline;
var
  c: SystemChar;
begin
  for c in t^.Buff do
    if Ord(c) > $FF then
        exit(1);
  Result := 0;
end;

function CompText(t1, t2: TPascalString): Integer; inline;
begin
  Result := cv(WasWide(@t1), WasWide(@t2));
  if Result = 0 then
    begin
      Result := cv(Length(t1), Length(t2));
      if Result = 0 then
          Result := CompareText(t1, t2);
    end;
end;

function LV_Sort1(lParam1, lParam2, lParamSort: LPARAM): Integer; stdcall;
var
  itm1, itm2: TListItem;
begin

  itm1 := TListItem(lParam1);
  itm2 := TListItem(lParam2);
  try
    if lParamSort = 0 then
        Result := cv(StrToInt(itm1.Caption), StrToInt(itm2.Caption))
    else if lParamSort = 1 then
        Result := cv(StrToInt(itm1.SubItems[lParamSort - 1]), StrToInt(itm2.SubItems[lParamSort - 1]))
    else
        Result := CompText(itm1.SubItems[lParamSort - 1], itm2.SubItems[lParamSort - 1]);
  except
  end;
end;

function LV_Sort2(lParam2, lParam1, lParamSort: LPARAM): Integer; stdcall;
var
  itm1, itm2: TListItem;
begin
  itm1 := TListItem(lParam1);
  itm2 := TListItem(lParam2);
  if lParamSort = 0 then
      Result := cv(StrToInt(itm1.Caption), StrToInt(itm2.Caption))
  else if lParamSort = 1 then
      Result := cv(StrToInt(itm1.SubItems[lParamSort - 1]), StrToInt(itm2.SubItems[lParamSort - 1]))
  else
      Result := CompText(itm1.SubItems[lParamSort - 1], itm2.SubItems[lParamSort - 1]);
end;

procedure TStrippedContextForm.ContextListColumnClick(Sender: TObject; Column: TListColumn);
var
  i: Integer;
begin
  // reset other sort column
  for i := 0 to ContextList.Columns.Count - 1 do
    if ContextList.Columns[i] <> Column then
        ContextList.Columns[i].Tag := 0;

  // imp sort
  if Column.Tag = 0 then
    begin
      ContextList.CustomSort(@LV_Sort1, Column.Index);
      Column.Tag := 1;
    end
  else
    begin
      ContextList.CustomSort(@LV_Sort2, Column.Index);
      Column.Tag := 0;
    end;
end;

procedure TStrippedContextForm.ContextListItemChecked(Sender: TObject; Item: TListItem);
var
  p: PTextTableItem;
begin
  p := Item.Data;
  p^.Picked := Item.Checked;
end;

procedure TStrippedContextForm.ContextListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  p: PTextTableItem;
begin
  if (ContextList.SelCount = 1) and (Selected) then
    begin
      p := Item.Data;
      OpenTextEditor(p, Item);
    end;
end;

procedure TStrippedContextForm.CategoryListItemChecked(Sender: TObject; Item: TListItem);
begin
  DoStatus('F5 refresh...');
  // RefreshTextList(False);
end;

procedure TStrippedContextForm.RestoreTranslationOriginActionExecute(Sender: TObject);
var
  i: Integer;
  p: PTextTableItem;
begin
  if MessageDlg('After the operation cannot be recovered, do you continue?', mtWarning, [mbYes, mbNo], 0) <> mrYes then
      exit;
  for i := 0 to FTextData.Count - 1 do
    begin
      p := FTextData[i];
      p^.DefineText := p^.OriginText;
    end;
  RefreshTextList(False);
end;

procedure TStrippedContextForm.QuickTranslateActionExecute(Sender: TObject);
begin
  if DefineMemo.Lines.Count > 0 then
    begin
      QuickTranslateForm.SourMemo.Text := GetOpenEditorOriginText(FOpenPtr);
      QuickTranslateForm.Translate;
    end;
  if not QuickTranslateForm.Visible then
    begin
      QuickTranslateForm.PopupParent := Self;
      QuickTranslateForm.Show;
    end;
  Activate;
end;

procedure TStrippedContextForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
  if QuickTranslateForm.Visible then
      QuickTranslateForm.Close;
end;

procedure TStrippedContextForm.EditorReturnActionExecute(Sender: TObject);
var
  i : Integer;
  tb: TTextTable;
begin
  CloseBaiduTranslate;

  tb := TTextTable.Create;
  for i := 0 to FTextData.Count - 1 do
    if FTextData[i]^.Picked then
        tb.AddCopy(FTextData[i]^);

  if Assigned(FOnReturnProc) then
    begin
      try
          FOnReturnProc(tb);
      except
      end;
    end;

  DisposeObject(tb);

  Close;
end;

procedure TStrippedContextForm.SaveTextButtonClick(Sender: TObject);
begin
  SaveTextEditor;
end;

procedure TStrippedContextForm.UndoActionExecute(Sender: TObject);
var
  i: Integer;
  p: PTextTableItem;
begin
  for i := 0 to ContextList.Items.Count - 1 do
    if ContextList.Items[i].Selected then
      begin
        p := ContextList.Items[i].Data;
        p^.DefineText := p^.OriginText;
        p^.Picked := False;
        OpenTextEditor(p, ContextList.Items[i]);
        SaveTextEditor;
        ContextList.Items[i].Checked := False;
      end;
end;

procedure TStrippedContextForm.UsesSourActionExecute(Sender: TObject);
begin
  QuickTranslateForm.UsedSourButtonClick(nil);
end;

procedure TStrippedContextForm.UsesDest1ActionExecute(Sender: TObject);
begin
  QuickTranslateForm.UsedDest1ButtonClick(nil);
end;

procedure TStrippedContextForm.UsesDest2ActionExecute(Sender: TObject);
begin
  QuickTranslateForm.UsedDest2ButtonClick(nil);
end;

procedure TStrippedContextForm.UsesDest3ActionExecute(Sender: TObject);
begin
  QuickTranslateForm.UsedDest3ButtonClick(nil);
end;

procedure TStrippedContextForm.DefineMemoChange(Sender: TObject);
begin
  FOpenPtrIsModify := True;
end;

procedure TStrippedContextForm.DoFilterButtonClick(Sender: TObject);
begin
  RefreshTextList(False);
end;

procedure TStrippedContextForm.NoDialogBatchTranslateActionExecute(Sender: TObject);
type
  PtempRec = ^TtempRec;

  TtempRec = packed record
    p: PTextTableItem;
    itmIndex: Integer;
    Index: Integer;
  end;

  function DoAllowed(itm: TListItem): Boolean; inline;
  begin
    case BatchTransOptForm.WorkModeRadioGroup.ItemIndex of
      0: Result := itm.Selected; // selected
      1: Result := itm.Checked;  // picked
      else Result := True;
    end;
  end;

var
  i : Integer;
  p1: PtempRec;
begin
  CloseBaiduTranslate;

  for i := 0 to ContextList.Items.Count - 1 do
    if DoAllowed(ContextList.Items[i]) then
      begin
        new(p1);
        p1^.p := ContextList.Items[i].Data;
        p1^.itmIndex := ContextList.Items[i].Index;
        p1^.Index := p1^.p^.Index;

        BaiduTranslate(False, BatchTransOptForm.UsedCacheWithZDBCheckBox.Checked,
          BatchTransOptForm.SourComboBox.ItemIndex, BatchTransOptForm.Dest1ComboBox.ItemIndex,
          GetOpenEditorOriginText(p1^.p), p1,
          procedure(UserData: Pointer; Success, Cached: Boolean; TranslateTime: TTimeTick; sour, dest: TPascalString)
          var
            p2: PtempRec;
            itm: TListItem;
          begin
            p2 := UserData;
            if Success then
              begin
                if (FTextData.ExistsIndex(p2^.Index)) and (p2^.itmIndex < ContextList.Items.Count) and
                  (ContextList.Items[p2^.itmIndex].Data = p2^.p) then
                  begin
                    itm := ContextList.Items[p2^.itmIndex];
                    OpenTextEditor(p2^.p, itm);
                    SetCurrentTranslate(dest);

                    if ContextList.SelCount > 1 then
                        ContextList.ClearSelection
                    else if ContextList.SelCount = 1 then
                        ContextList.Selected.Selected := False;

                    itm.Selected := True;
                    itm.MakeVisible(True);
                  end;
              end;
            dispose(p2);
          end);
      end;
end;

procedure TStrippedContextForm.BatchTranslateActionExecute(
  Sender: TObject);
begin
  if BatchTransOptForm.ShowModal = mrOk then
      NoDialogBatchTranslateAction.Execute;
end;

function TStrippedContextForm.GetOpenEditorOriginText(p: PTextTableItem): umlString;
begin
  case p^.TextStyle of
    tsPascalText: Result := TTextParsing.TranslatePascalDeclToText(p^.OriginText);
    tsPascalComment: Result := TTextParsing.TranslatePascalDeclCommentToText(p^.OriginText);
    tsCText: Result := TTextParsing.TranslateC_DeclToText(p^.OriginText);
    tsCComment: Result := TTextParsing.TranslateC_DeclCommentToText(p^.OriginText);
    tsDFMText: Result := TTextParsing.TranslatePascalDeclToText(p^.OriginText);
    else Result := p^.OriginText;
  end;
  while (Result.Len > 0) and (CharIn(Result.Last, [#13, #10])) do
      Result.DeleteLast;
end;

function TStrippedContextForm.GetOpenEditorDefineText(p: PTextTableItem): umlString;
begin
  case p^.TextStyle of
    tsPascalText: Result := TTextParsing.TranslatePascalDeclToText(p^.DefineText);
    tsPascalComment: Result := TTextParsing.TranslatePascalDeclCommentToText(p^.DefineText);
    tsCText: Result := TTextParsing.TranslateC_DeclToText(p^.DefineText);
    tsCComment: Result := TTextParsing.TranslateC_DeclCommentToText(p^.DefineText);
    tsDFMText: Result := TTextParsing.TranslatePascalDeclToText(p^.DefineText);
    else Result := p^.DefineText;
  end;
  while (Result.Len > 0) and (CharIn(Result.Last, [#13, #10])) do
      Result.DeleteLast;
end;

procedure TStrippedContextForm.OpenTextEditor(p: PTextTableItem; itm: TListItem);
var
  n: umlString;
begin
  if FOpenPtrIsModify and (FOpenPtr <> nil) then
    begin
      SaveTextEditor;
      FOpenPtrIsModify := False;
    end;

  FOpenPtr := p;
  FOpenListItm := itm;

  DefineMemo.Text := GetOpenEditorDefineText(FOpenPtr);

  FOpenPtrIsModify := False;

  CodeEdit.Text := Format('//Origin:' + #13#10 + '%s' + #13#10#13#10 + '//Defined:' + #13#10 + '%s', [FOpenPtr^.OriginText, FOpenPtr^.DefineText]);
end;

procedure TStrippedContextForm.FilterEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
      DoFilterButtonClick(DoFilterButton);
end;

procedure TStrippedContextForm.SaveTextEditor;
var
  n: umlString;
begin
  if FOpenPtr = nil then
      exit;

  n := DefineMemo.Text;
  while (n.Len > 0) and (CharIn(n.Last, [#13, #10])) do
      n.DeleteLast;

  case FOpenPtr^.TextStyle of
    tsPascalText: FOpenPtr^.DefineText := TTextParsing.TranslateTextToPascalDecl(n);
    tsPascalComment: FOpenPtr^.DefineText := TTextParsing.TranslateTextToPascalDeclComment(n);
    tsCText: FOpenPtr^.DefineText := TTextParsing.TranslateTextToC_Decl(n);
    tsCComment: FOpenPtr^.DefineText := TTextParsing.TranslateTextToC_DeclComment(n);
    tsDFMText: FOpenPtr^.DefineText := TTextParsing.TranslateTextToPascalDeclWithUnicode(n);
    else FOpenPtr^.DefineText := n;
  end;
  FOpenPtrIsModify := False;

  FOpenPtr.Picked := True;

  with FOpenListItm do
    begin
      Caption := Format('%d', [FOpenPtr^.Index]);
      SubItems.Clear;
      SubItems.Add(Format('%d', [FOpenPtr^.RepCount]));

      if ShowOriginContextAction.Checked then
          n := umlDeleteChar(GetOpenEditorOriginText(FOpenPtr), #13#10)
      else
          n := umlDeleteChar(GetOpenEditorDefineText(FOpenPtr), #13#10);

      case FOpenPtr^.TextStyle of
        tsPascalComment, tsCComment: SubItems.Add('// ' + n);
        tsCText, tsPascalText, tsDFMText: SubItems.Add('"' + n + '"');
        tsNormalText: SubItems.Add(n);
      end;

      Checked := FOpenPtr^.Picked;
    end;

  CodeEdit.Text := Format('//Origin:' + #13#10 + '%s' + #13#10#13#10 + '//Defined:' + #13#10 + '%s', [FOpenPtr^.OriginText, FOpenPtr^.DefineText]);
end;

procedure TStrippedContextForm.SetOnReturnProc(const Value: TEditorReturnProc);
begin
  FOnReturnProc := Value;
  EditorReturnAction.Visible := Assigned(FOnReturnProc);
end;

procedure TStrippedContextForm.LoadNewCTFromStream(m64: TMemoryStream64);
begin
  FTextData.LoadFromStream(m64);
  RefreshTextList(True);
end;

procedure TStrippedContextForm.NewCT;
begin
  FTextData.Clear;
  RefreshTextList(True);
end;

function TStrippedContextForm.ExistsCategory(c: string): Boolean;
begin
  Result := FCategoryHashList.Exists(c);
end;

function TStrippedContextForm.CategoryIsSelected(c: string): Boolean;
var
  categoryItm: TListItem;
begin
  categoryItm := TListItem(FCategoryHashList[c]);
  Result := (categoryItm <> nil) and (categoryItm.Checked);
end;

procedure TStrippedContextForm.RefreshTextList(rebuild: Boolean);
  function Match(p: PTextTableItem; s1, s2: umlString): Boolean; inline;
  begin
    Result := True;
    if s1.Len = 0 then
        exit;

    if CharIn(s1.First, [':']) then
      begin
        s1.DeleteFirst;

        if (s1.Len > 0) and (CharIn(s1.First, [':'])) then
          begin
            Result := (s2.GetPos(s1) > 0) or umlMultipleMatch(s1, s2);
            exit;
          end;

        if p^.Picked then
            Result := (s2.GetPos(s1) > 0) or umlMultipleMatch(s1, s2)
        else
            Result := False;
      end
    else if CharIn(s1.First, ['/']) then
      begin
        s1.DeleteFirst;

        if (s1.Len > 0) and (CharIn(s1.First, ['/'])) then
          begin
            Result := (s2.GetPos(s1) > 0) or umlMultipleMatch(s1, s2);
            exit;
          end;

        if p^.TextStyle in [tsPascalComment, tsCComment] then
            Result := (s2.GetPos(s1) > 0) or umlMultipleMatch(s1, s2)
        else
            Result := False;
      end
    else if CharIn(s1.First, ['"']) then
      begin
        s1.DeleteFirst;

        if (s1.Len > 0) and (CharIn(s1.First, ['"'])) then
          begin
            Result := (s2.GetPos(s1) > 0) or umlMultipleMatch(s1, s2);
            exit;
          end;

        if p^.TextStyle in [tsPascalText, tsCText, tsNormalText, tsDFMText] then
            Result := (s2.GetPos(s1) > 0) or umlMultipleMatch(s1, s2)
        else
            Result := False;
      end
    else if CharIn(s1.First, ['#']) then
      begin
        s1.DeleteFirst;

        if (s1.Len > 0) and (CharIn(s1.First, ['#'])) then
          begin
            Result := (s2.GetPos(s1) > 0) or umlMultipleMatch(s1, s2);
            exit;
          end;

        if p^.TextStyle in [tsDFMText] then
            Result := (s2.GetPos(s1) > 0) or umlMultipleMatch(s1, s2)
        else
            Result := False;
      end
    else
        Result := (s2.GetPos(s1) > 0) or umlMultipleMatch(s1, s2);
  end;

var
  i          : Integer;
  p          : PTextTableItem;
  itm        : TListItem;
  categoryItm: TListItem;
  hlst       : THashObjectList;
  ori, def, n: umlString;
begin
  FOpenListItm := nil;
  FOpenPtr := nil;

  CloseBaiduTranslate;
  CodeEdit.Clear;
  DefineMemo.Clear;
  QuickTranslateForm.Close;

  ContextList.OnItemChecked := nil;
  CategoryList.OnItemChecked := nil;
  if rebuild then
      CategoryList.Items.BeginUpdate;

  ContextList.Items.BeginUpdate;

  hlst := THashObjectList.Create(False, 32768);

  if rebuild then
    begin
      CategoryList.Items.Clear;
      FCategoryHashList.Clear;
    end;
  ContextList.Items.Clear;
  for i := 0 to FTextData.Count - 1 do
    begin
      p := FTextData[i];

      if rebuild then
        if not ExistsCategory(umlDeleteChar(p^.Category, #13#10)) then
          begin
            categoryItm := CategoryList.Items.Add;
            categoryItm.Caption := umlDeleteChar(p^.Category, #13#10);
            categoryItm.ImageIndex := -1;
            categoryItm.StateIndex := -1;
            categoryItm.Checked := True;

            FCategoryHashList.Add(categoryItm.Caption, categoryItm);
          end;

      if CategoryIsSelected(umlDeleteChar(p^.Category, #13#10)) then
        if not hlst.Exists(p^.OriginText) then
          begin
            ori := umlDeleteChar(GetOpenEditorOriginText(p), #13#10);
            def := umlDeleteChar(GetOpenEditorDefineText(p), #13#10);
            if (Match(p, OriginFilterEdit.Text, ori)) and (Match(p, DefineFilterEdit.Text, def)) then
              begin
                itm := ContextList.Items.Add;
                hlst.Add(p^.OriginText, itm);
                with itm do
                  begin
                    Caption := Format('%d', [p^.Index]);
                    SubItems.Add(Format('%d', [p^.RepCount]));

                    if ShowOriginContextAction.Checked then
                        n := ori
                    else
                        n := def;

                    case p^.TextStyle of
                      tsPascalComment, tsCComment: SubItems.Add('// ' + n);
                      tsCText, tsPascalText, tsDFMText: SubItems.Add('"' + n + '"');
                      tsNormalText: SubItems.Add(n);
                    end;

                    Checked := p^.Picked;

                    ImageIndex := -1;
                    StateIndex := -1;

                    Data := p;

                  end;
              end;
          end;
    end;

  DisposeObject(hlst);

  ContextList.Items.EndUpdate;

  if rebuild then
      CategoryList.Items.EndUpdate;
  ContextList.OnItemChecked := ContextListItemChecked;
  CategoryList.OnItemChecked := CategoryListItemChecked;
end;

procedure TStrippedContextForm.Clear;
begin
  CategoryList.Clear;
  ContextList.Clear;
end;

procedure TStrippedContextForm.SetCurrentTranslate(Text: string);
begin
  if FOpenPtr = nil then
      exit;
  DefineMemo.Text := Text;
  SaveTextEditor;
end;

end.
