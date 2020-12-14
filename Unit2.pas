unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.TabControl, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.ListBox, FMX.Layouts, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.EditBox,
  FMX.SpinBox, FMX.DateTimeCtrls, System.IOUtils;

type
  TForm2 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    ToolBar2: TToolBar;
    SpeedButton1: TSpeedButton;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ToolBar3: TToolBar;
    Назад: TSpeedButton;
    ChangeTabAction2: TChangeTabAction;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ChangeTabAction3: TChangeTabAction;
    ToolBar1: TToolBar;
    SpeedButton4: TSpeedButton;
    ListBox2: TListBox;
    lbghDateTime: TListBoxGroupHeader;
    deDateNew: TDateEdit;
    teTimeNew: TTimeEdit;
    lbghLenght: TListBoxGroupHeader;
    lbiLengthNew: TListBoxItem;
    sbLengthNew: TSpinBox;
    lbghWater: TListBoxGroupHeader;
    lbiWaterNew: TListBoxItem;
    swWaterNew: TSwitch;
    lbghComment: TListBoxGroupHeader;
    lbiCommentNew: TListBoxItem;
    meCommentNew: TMemo;
    Layout1: TLayout;
    paDateTimeHeader: TPanel;
    laDateTimeHeader: TLabel;
    loWaterValue: TLayout;
    laWaterValue: TLabel;
    loDateTimeValue: TLayout;
    laDateTimeValue: TLabel;
    paLengthHeader: TPanel;
    laLengthHeader: TLabel;
    loCommentValue: TLayout;
    laCommentValue: TLabel;
    loLengthValue: TLayout;
    laLengthValue: TLabel;
    paCommenHeader: TPanel;
    laCommentHeader: TLabel;
    paWaterHeader: TPanel;
    laWaterHeader: TLabel;
    procedure SpeedButton2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  arDate: array [1..31] of TDate;
  arTime: array [1..31] of TTime;
  arLength: array [1..31] of single;
  arWater: array [1..31] of boolean;
  arComment: array [1..31] of string;


    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.FormCreate(Sender: TObject);

var
i: integer;
begin
for i:= 1 to 31 do
arLength[i]:= 0.0;
arWater[i]:= false;
arComment[i]:= '';
arDate[i]:= 0;
arTime[i]:= 0;
end;


procedure TForm2.FormShow(Sender: TObject);

var
FileName: string;
MyFile: TextFile;
BigString: string;
sDate, sTime, sLength, sWater, sComment: string;
i: integer;
n: integer;
j: integer;
NewListBoxItem: TListBoxItem;
begin
FileName:= TPath.GetDocumentsPath + PathDelim + 'diary.txt';
AssignFile(MyFile, FileName);
Reset(MyFile);

//
while not Eof(MyFile) do
begin
Readln(MyFile, BigString);
sDate:=''; sTime:=''; sLength:=''; sWater:=''; sComment:='';
i:= Low(BigString); 
while BigString[i] <> ' ' do
begin
 sDate:= sDate + BigString[i];
 i:= i + 1;
end;
i:= i + 1;
while BigString[i] <> ' ' do
begin
 sTime:= sTime + BigString[i];
 i:= i + 1;
end;
i:= i + 1;
while BigString[i] <> ' ' do
begin
 sLength:= sLength + BigString[i];
 i:= i + 1;
end;
i:= i + 1;
while BigString[i] <> ' ' do
begin
 sWater:= sWater + BigString[i];
 i:= i + 1;
end;
i:= i + 1;
while i < High(BigString) do
begin
 if BigString[i] <> '"' then
 sComment:= sComment + BigString[i];
 i:= i + 1;
end;
n:= n + 1;
arDate[n]:= StrToDate(sDate);
arTime[n]:= StrToTime(sTime);
arLength[n]:= StrToFloat(sLength);
if sWater = 'да' then
arWater[n]:= true
else
arWater[n]:= false;
arComment[n]:= sComment;
end;
//

CloseFile(MyFile);
for j:= 1 to n do
begin
NewListBoxItem:= TListBoxItem.Create(ListBox1);
NewListBoxItem.Parent:= ListBox1;
NewListBoxItem.StyleLookup:= 'listboxitembottomdetail';
NewListBoxItem.Height:= 44;
NewListBoxItem.ItemData.Accessory:= TListBoxItemData.
TAccessory.aMore;
NewListBoxItem.ItemData.Text:= DateToStr(arDate[j]) + ' '
+ TimeToStr(arTime[j]);
NewListBoxItem.ItemData.Detail:= 'Длина ростка ' +
FloatToStr(arLength[j]) + ' см';
end;
end;




procedure TForm2.ListBox1Click(Sender: TObject);
var
ListBoxItemIndex: integer;
begin
if ListBox1.ItemIndex < 0 then exit;
ChangeTabAction3.ExecuteTarget(TabControl1);

begin
if ListBox1.ItemIndex < 0 then exit;

ListBoxItemIndex:= ListBox1.ItemIndex + 1;

laDateTimeValue.Text:= DateToStr(arDate[ListBoxItemIndex]) + ' ' + TimeToStr(arTime[ListBoxItemIndex]);
laLengthValue.Text:= 'Длина ростка '
+ FloatToStr(arLength[ListBoxItemIndex]) + ' мм';
if arWater[ListBoxItemIndex] then
 laWaterValue.Text:= 'да'
else
 laWaterValue.Text:= 'нет';
 laCommentValue.Text:= arComment[ListBoxItemIndex];

ChangeTabAction3.ExecuteTarget(TabControl1);

end;
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
var
NewIndex: integer;
NewListBoxItem: TListBoxItem;
MyFile: TextFile;
FileName: string;
MyString: string;
begin
Newindex:= ListBox1.Count + 1;
arDate[NewIndex]:= deDateNew.Date;
arTime[NewIndex]:= teTimeNew.Time;
arLength[NewIndex]:= sbLengthNew.Value;
arWater[NewIndex]:= swWaterNew.IsChecked;
arComment[NewIndex]:= meCommentNew.Text;
NewListBoxItem:= TListBoxItem.Create(ListBox1);
NewListBoxItem.Parent:= ListBox1;
NewListBoxItem.StyleLookup:= 'listboxitembottomdetail';
NewListBoxItem.Height:= 44;
NewListBoxItem.ItemData.Accessory:= TListBoxItemData.
TAccessory.aMore;
NewListBoxItem.ItemData.Text:= DateToStr(arDate[NewIndex]) +
' ' + TimeToStr(arTime[NewIndex]);
NewListBoxItem.ItemData.Detail:= ' Длина ростка ' +
FloatToStr(arLength[NewIndex]) + ' мм';

FileName:= TPath.GetDocumentsPath + PathDelim + 'diary.txt';

AssignFile(MyFile, FileName);
Append(MyFile);

MyString:= DateToStr(arDate[NewIndex]) + ' ' +
TimeToStr(arTime[NewIndex])
+ ' ' + FloatToStr(arLength[NewIndex]);
if arWater[NewIndex] = true then
MyString:= MyString + ' ' + 'да' + ' '
else
MyString:= MyString + ' ' + 'да' + ' ';
MyString:= MyString + '"' + arComment[NewIndex] + '"';
Writeln(MyFile, MyString);
CloseFile(MyFile);

ChangeTabAction2.ExecuteTarget(TabControl1);
end;


end.
