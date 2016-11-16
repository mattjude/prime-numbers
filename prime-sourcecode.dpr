program PrimeNumbers;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Console;

///////////////////////////////////////////////////

{Common command aliases}

procedure Col(Colour:byte);
begin                                   // A quick way to set colour
  TextColor(Colour);
end;

procedure BGcol(BGColour:byte);
begin                                   // A quick way to set BG colour
  TextBackground(BGColour);
end;

procedure cls;
begin
  ClrScr;                               // A quick way to clear screen
end;

procedure cll;
begin
  ClrEol;                              // A quick way to clear line in bgcol
end;

procedure Pause(key:char);
var read:char;
begin
  repeat                              // <-- I did this procedure :D
    read:=readkey;
  until read=key;
end;

procedure Caption(const Title: string);
begin
  writeln(Title);
  writeln(stringofchar('-', length(Title)));
  writeln;
end;

procedure Reset;
begin
  col(lightgray);
  bgcol(black);          //Something to reset the console
  Window(0,0,0,0);
  cls;
  gotoxy(1,1);
end;



{                     *** Little Boxes by mj 2006 ***
The following procedure draws a border box around set co-ordinates in a window;
it also asks for the foreground and background colours. Once the border is
drawn a window is placed inside that border to prevent overwiting of the edges.
Border Types: | 1, Single | 2, Double | 3, Thick | 4, Margin |
Note: Set leftx,rightx,topy,bottomy to 0 to create a screen border.
      Co-ords are relative to the console size not active window.
Uses: SysUtils, Console, and the above procedure (Reset).
}

procedure Box(LeftX,TopY,RightX,BottomY:SmallInt;FGcolour,BGcolour,BType:byte);
var
  x,y:byte;
  XMax,YMax:smallint;
  topleft,bottomleft,topright,bottomright,
  tophori,bottomhori,leftvert,rightvert:char;

const
{Border Types}
  // Type 1 - Single
  singleTL:char      = #218;
  singleBL:char      = #192;
  singleTR:char      = #191;
  singleBR:char      = #217;
  singleVert:char    = #179;
  singleHori:char    = #196;

  // Type 2 - Double
  doubleTL:char      = #201;
  doubleBL:char      = #200;
  doubleTR:char      = #187;
  doubleBR:char      = #188;
  doubleVert:char    = #186;
  doubleHori:char    = #205;

  // Type 3 - Thick
  thickT:char      = #220;
  thickB:char      = #223;
  thickL:char      = #221;
  thickR:char      = #222;

  // Type 4 - Margin
  margin:char      = #219;

begin

case BType of
  1:  begin
      topleft:=singleTL;
      bottomleft:=singleBL;
      topright:=singleTR;
      bottomright:=singleBR;
      leftvert:=singleVert;
      rightvert:=singleVert;
      tophori:=singleHori;
      bottomhori:=singleHori;
      end;

  2:  begin
      topleft:=doubleTL;
      bottomleft:=doubleBL;
      topright:=doubleTR;
      bottomright:=doubleBR;
      leftvert:=doubleVert;
      rightvert:=doubleVert;
      tophori:=doubleHori;
      bottomhori:=doubleHori;
      end;

  3:  begin
      topleft:=thickT;
      bottomleft:=thickB;
      topright:=thickT;
      bottomright:=thickB;
      leftvert:=thickL;
      rightvert:=thickR;
      tophori:=thickT;
      bottomhori:=thickB;
      end;

  4:  begin
      topleft:=margin;
      bottomleft:=margin;
      topright:=margin;
      bottomright:=margin;
      leftvert:=margin;
      rightvert:=margin;
      tophori:=margin;
      bottomhori:=margin;
      end;
end;

  XMax:=ScreenWidth;
  YMax:=ScreenHeight;

  if (leftx=0)
  and (rightx=0)
  and (topy=0)
  and (bottomy=0) then
  begin
    Reset; //Reset Console

    col(fgcolour);
    bgcol(bgcolour);
    cls;

    gotoxy(1,1);
      for x:=1 to xmax do
      write(tophori);
    gotoxy(1,ymax);
      for x:=1 to xmax do
      write(bottomhori);
    gotoxy(1,1);
      for y:=1 to ymax do begin
      write(leftvert);
      gotoxy(1,y);
      end;
    gotoxy(xmax,2);
      for y:=1 to ymax do begin
      writeln(rightvert);
      gotoxy(xmax,y);
      end;

    gotoxy(1,ymax);
      write(bottomleft);
    gotoxy(xmax,ymax);
      write(bottomright);
    gotoxy(1,1);
      write(topleft);
    gotoxy(xmax,1);
      write(topright);

    Window(2,2,xmax-1,ymax-1);

  end else
  begin
  //LeftX,RightX,TopY,BottomY:Integer;FGcolour,BGcolour:byte

  Window(leftx,topy,rightx,bottomy+1);
  //We do +1 to bottomy to eliminate writeln return/scrolling errors

  col(fgcolour);
  bgcol(bgcolour);

  xmax:=rightx-leftx+1;
  ymax:=bottomy-topy+1;

    gotoxy(1,1);
      for x:=1 to xmax do
      write(tophori);
    gotoxy(1,ymax);
      for x:=1 to xmax do
      write(bottomhori);
    gotoxy(1,1);
      for y:=1 to ymax do begin
      write(leftvert);
      gotoxy(1,y);
      end;
    gotoxy(xmax,3);
      for y:=1 to ymax do begin
      writeln(rightvert);
      gotoxy(xmax,y);
      end;

    gotoxy(1,1);
      write(topleft);
    gotoxy(xmax,1);
      write(topright);
    gotoxy(1,ymax);
      write(bottomleft);
    gotoxy(xmax,ymax);
      write(bottomright);

    Window(leftx+1,topy+1,rightx-1,bottomy-1);
    Cls;
  end;
end;
{************* END LITTLE BOXES PROCEDURE *************}


procedure DrawBG(Text:string;Times,DelayMS:integer;ResetWindowTF,GreyTF:Boolean);
var blocks:integer;
 begin
   if resetwindowtf=true then Box(0,0,0,0,white,black,1);
     gotoxy(73,23);
     col(darkgray);
     bgcol(lightgray);
     cll;
     gotoxy(74,23);
     // Add constant sig
     write('mj06');

   col(black);
   for Times:=1 to Times do                     // Something to redraw bg
   begin                                        // with a 4 char string.
   gotoxy(1,1);                                 // And add sig in BR corner.
     for blocks:=1 to 13*23-1 do
     begin
       if GreyTF=true then bgcol(Random(2)+7)
       else bgcol(Random(6)+1);
       write(' '+ text +' ');
       delay(delayMS);
     end;
   end;
   gotoxy(1,1);
 end;

procedure Logo(x,y:smallint);
begin
  Box(x,y,x+16,y+5,white,black,1);
    col(black);
    bgcol(lightred);
    gotoxy(1,1); cll;                    // Macro to create the PrmN Logo
    bgcol(yellow);                       // at the given co-ords.
    gotoxy(1,2); cll;                    // -mj06
    gotoxy(2,2);
    write('Prime Numbers');
    gotoxy(1,3); cll;
    gotoxy(4,3);
    write('in Spain!');
    bgcol(lightred);
    gotoxy(1,4); cll;
end;

procedure TheDuck(x,y:smallint;FGcolour,BGcolour:Byte);
begin
   col(fgcolour);
   bgcol(bgcolour);

   gotoxy(x,y);    writeln('      ,--~`~.._');
   gotoxy(x,y+1);  writeln('    ,''         `.');
   gotoxy(x,y+2);  writeln('   ; (((__   __)))');
   gotoxy(x,y+3);  writeln('   ;  ( (o) ( (o)');
   gotoxy(x,y+4);  writeln('   |   \_/___\_/|');
   gotoxy(x,y+5);  writeln('  ,"  ,-''    `__".');
   gotoxy(x,y+6);  writeln(' (   ( ._   ____`.)--._        _');
   gotoxy(x,y+7);  writeln('  `._ `-.`-'' \(`-''  _  `-. _,-'' `-/`.');
   gotoxy(x,y+8);  writeln('   ,'')   `.`._))  ,'' `.   `.  ,'',''  ;');
   gotoxy(x,y+9);  writeln(' .''   .    `--''  /     ).   `.      ;');
   gotoxy(x,y+10); writeln(';      `-       /     ''  )         ;');
   gotoxy(x,y+11); writeln('\                       '')       ,''');
   gotoxy(x,y+12); writeln(' \                     ,''       ;');
   gotoxy(x,y+13); writeln('  \               `~~~''       ,''');
   gotoxy(x,y+14); writeln('   `.                      _,''');
   gotoxy(x,y+15); writeln('     `.                ,--''');
   gotoxy(x,y+16); write('       `-._________,--''');
end;


///////////////////////////////////////////////////
//   Assembler Code to turn off blinking caret   //
///////////////////////////////////////////////////
//     Delphi has problems running this code     //
///////////////////////////////////////////////////
procedure CursorOff;
var S: word;
begin
  asm
    mov AH,03h ; mov BH,0 ; int 10h ;
    mov S,CX ; mov AH,01h ; mov BH,0 ;
    mov CX,2000h ; int 10h
  end;
end;

procedure CursorOn ;
var S : word ;
begin
  asm
    mov ah,01h ; mov bh,0 ; mov cx,S ; int 10h
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
{}              var               {}
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

  x,y,z,chances,tries: integer;
  MenuChoice,ElimChoice: Char;
  ElimNumbers: Array[1..100] of Boolean;
  LastStatement,GuessedRight: Boolean;
  PrimeDone,EvensOddsDone: Boolean;

  TrueNumber:SmallInt;   

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
{}             const              {}
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

  DblArrow:char     =  #175;
  DblArrowInv:char  =  #174;
  Est:char          =  #247;
  GrtEql:char       =  #242;
  LessEql:char      =  #243;

 (*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
 {}   Version:string = 'PrmN v2.4 (56)';   {}
 (*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

///////////////////////////////////////////////////
//         Number Elimination Procedures         //
///////////////////////////////////////////////////

procedure Prime();           // 1
begin
if primedone=false then
begin

  for x:=1 to 100 do
  begin
    if (truenumber = 2)  or (truenumber = 3)  or (truenumber = 5) or
       (truenumber = 5)  or (truenumber = 7)  or (truenumber = 11) or
       (truenumber = 13) or (truenumber = 17) or (truenumber = 19) or
       (truenumber = 23) or (truenumber = 29) or (truenumber = 31) or
       (truenumber = 37) or (truenumber = 41) or (truenumber = 43) or
       (truenumber = 47) or (truenumber = 53) or (truenumber = 59) or
       (truenumber = 61) or (truenumber = 67) or (truenumber = 71) or
       (truenumber = 73) or (truenumber = 79) or (truenumber = 83) or
       (truenumber = 89) or (truenumber = 97)
       then
       begin
        laststatement:=true;
        if (x <> 2) and (x <> 3) and (x <> 5) and
           (x <> 5) and (x <> 7) and (x <> 11) and
           (x <> 13) and (x <> 17) and (x <> 19) and
           (x <> 23) and (x <> 29) and (x <> 31) and
           (x <> 37) and (x <> 41) and (x <> 43) and
           (x <> 47) and (x <> 53) and (x <> 59) and
           (x <> 61) and (x <> 67) and (x <> 71) and
           (x <> 73) and (x <> 79) and (x <> 83) and
           (x <> 89) and (x <> 97)
           then ElimNumbers[x]:=true;
     end else
     begin
       laststatement:=false;
        if (x = 2) or (x = 3) or (x = 5) or
           (x = 5) or (x = 7) or (x = 11) or
           (x = 13) or (x = 17) or (x = 19) or
           (x = 23) or (x = 29) or (x = 31) or
           (x = 37) or (x = 41) or (x = 43) or
           (x = 47) or (x = 53) or (x = 59) or
           (x = 61) or (x = 67) or (x = 71) or
           (x = 73) or (x = 79) or (x = 83) or
           (x = 89) or (x = 97)
           then ElimNumbers[x]:=true;
     end;
  end;

  chances:=chances-1;
  if laststatement then
  begin
    Box(30,19,74,22,lightgreen,black,3);
    gotoxy(2,1); write('The Mystery Number is a Prime Number!');
    col(green);
    gotoxy(10,2); write('[You have '+inttostr(chances)+' chances left]');
  end else
  begin
    Box(30,19,74,22,lightred,black,3);
    gotoxy(2,1); write('The Mystery Number is not a Prime Number!');
    col(red);
    gotoxy(10,2); write('[You have '+inttostr(chances)+' chances left]');
  end;

  window(8,13,26,19);
  bgcol(black);
  gotoxy(1,1);
  cll;
  primedone:=true;
end;
end;

procedure Factor();          // 2
var input:integer;
begin
  Box(30,19,74,22,lightgray,black,3);
    repeat
      gotoxy(3,1); write('Is the Mystery Number a Factor of ');
      col(darkgray);
      gotoxy(14,2); write('(1 to ...)');
      col(white); gotoxy(38,2);
      write(': '); readln(input);
      if input <= 0 then
      begin
        col(lightred);
        gotoxy(30,2); write('ERROR');
        gotoxy(40,2);
        cll; col(lightgray);
      end;
    until input > 0;
  cls;
  for x:=1 to 100 do
  begin
    if input mod TrueNumber = 0 then
    begin
      laststatement:=true;
      if input mod x <> 0 then
      ElimNumbers[x]:=true;
    end else
    begin
      laststatement:=false;
      if input mod x = 0 then
      ElimNumbers[x]:=true;
    end;
  end;

  chances:=chances-1;
  if laststatement then
  begin
    Box(30,19,74,22,lightgreen,black,3);
    gotoxy(4,1); write('The Mystery Number is a Factor of '+inttostr(input));
    col(green);
    gotoxy(10,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end else
  begin
    Box(30,19,74,22,lightred,black,3);
    gotoxy(2,1); write('The Mystery Number is not a Factor of '+inttostr(input));
    col(red);
    gotoxy(10,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end;
end;

procedure EvenOdd();            // 6
begin
if (EvensOddsDone=false) and (chances>=2) then
begin
  for x:=1 to 100 do
  begin
    if TrueNumber mod 2 = 0 then
    begin
      laststatement:=true;
      if x mod 2 <> 0 then
      ElimNumbers[x]:=true;
    end else
    begin
      laststatement:=false;
      if x mod 2 = 0 then
      ElimNumbers[x]:=true;
    end;
  end;

  chances:=chances-2;

  if laststatement then
  begin
    Box(30,19,74,22,yellow,black,3);
    gotoxy(3,1); write('The Mystery Number is Even [-2 chances]');
    col(brown);
    gotoxy(10,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end else
  begin
    Box(30,19,74,22,yellow,black,3);
    gotoxy(3,1); write('The Mystery Number is Odd [-2 chances]');
    col(brown);
    gotoxy(10,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end;
  end else
  begin
    if chances<2 then
    begin
    Box(30,19,74,22,lightred,black,3);
    gotoxy(5,1); write('You do not have enough chances.');
    col(red);
    gotoxy(13,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
    end;
  end;

  window(8,13,26,19);
  bgcol(black);
  gotoxy(1,6); cll;
  gotoxy(1,7); cll;
  EvensOddsDone:=true;
end;

procedure Multiple();        // 3
var input:integer;
begin
  Box(30,19,74,22,lightgray,black,3);
  if (input <= 0) or (input > 100) then
  begin
    repeat
      gotoxy(3,1); write('Is the Mystery Number a Multiple of ');
      col(darkgray);
      gotoxy(14,2); write('(1 to 100)');
      col(white); gotoxy(38,2);
      write(': '); readln(input);
      if (input <= 0) or (input > 100) then
      begin
        col(lightred);
        gotoxy(30,2); write('ERROR');
        gotoxy(40,2);
        cll; col(lightgray);
      end;
    until (input > 0) and (input <= 100);
  end;
  cls;
  for x:=1 to 100 do
  begin
    if TrueNumber mod input = 0 then
    begin
      laststatement:=true;
      if x mod input <> 0 then
      ElimNumbers[x]:=true;
    end else
    begin
      laststatement:=false;
      if x mod input = 0 then 
      ElimNumbers[x]:=true;
    end;
  end;

  chances:=chances-1;
  if laststatement then
  begin
    Box(30,19,74,22,lightgreen,black,3);
    gotoxy(2,1); write('The Mystery Number is a Multiple of '+inttostr(input));
    col(green);
    gotoxy(10,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end else
  begin
    Box(30,19,74,22,lightred,black,3);
    gotoxy(1,1); write('The Mystery Number is not a Multiple of '+inttostr(input));
    col(red);
    gotoxy(10,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end;

  if (input=2) then  // Go to EvenOdd Procedure
  begin
    chances:=chances+1;
    EvenOdd;
  end;
end;

procedure Greater();         // 4
var input:integer;
begin
  Box(30,19,74,22,lightgray,black,3);
  if (input <= 0) or (input > 100) then
  begin
    repeat
      gotoxy(3,1); write('Is the Mystery Number Greater than');
      gotoxy(3,2); write('or Equal to: ');
      col(darkgray);
      gotoxy(18,2); write('(1 to 100)');
      col(white); gotoxy(38,2);
      write(': '); readln(input);
      if (input <= 0) or (input > 100) then
      begin
        col(lightred);
        gotoxy(30,2); write('ERROR');
        gotoxy(40,2);
        cll; col(lightgray);
      end;
    until (input > 0) and (input <= 100);
  end;
  cls;
  for x:=1 to 100 do
  begin
    if TrueNumber >= input then
    begin
      laststatement:=true;
      if x < input then
      ElimNumbers[x]:=true;
    end else
    begin
      laststatement:=false;
      if x >= input then
      ElimNumbers[x]:=true;
    end;
  end;

  chances:=chances-1;
  if laststatement then
  begin
    Box(30,19,74,22,lightgreen,black,3);
    gotoxy(2,1); write('The Mystery Number is Greater than or');
    gotoxy(2,2); write('Equal to '+inttostr(input));
    col(green);
    gotoxy(16,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end else
  begin
    Box(30,19,74,22,lightred,black,3);
    gotoxy(2,1); write('The Mystery Number is not Greater than or');
    gotoxy(2,2); write('Equal to '+inttostr(input));
    col(red);
    gotoxy(16,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end;
end;

procedure Less();            // 5
var input:integer;
begin
  Box(30,19,74,22,lightgray,black,3);
  if (input <= 0) or (input > 100) then
  begin
    repeat
      gotoxy(3,1); write('Is the Mystery Number Less than or');
      gotoxy(3,2); write('Equal to: ');
      col(darkgray);
      gotoxy(18,2); write('(1 to 100)');
      col(white); gotoxy(38,2);
      write(': '); readln(input);
      if (input <= 0) or (input > 100) then
      begin
        col(lightred);
        gotoxy(30,2); write('ERROR');
        gotoxy(40,2);
        cll; col(lightgray);
      end;
    until (input > 0) and (input <= 100);
  end;
  cls;
  for x:=1 to 100 do
  begin
    if TrueNumber <= input then
    begin
      laststatement:=true;
      if x > input then
      ElimNumbers[x]:=true;
    end else
    begin
      laststatement:=false;
      if x <= input then
      ElimNumbers[x]:=true;
    end;
  end;

  chances:=chances-1;
  if laststatement then
  begin
    Box(30,19,74,22,lightgreen,black,3);
    gotoxy(2,1); write('The Mystery Number is Less than or');
    gotoxy(2,2); write('Equal to '+inttostr(input));
    col(green);
    gotoxy(16,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end else
  begin
    Box(30,19,74,22,lightred,black,3);
    gotoxy(2,1); write('The Mystery Number is not Less than or');
    gotoxy(2,2); write('Equal to '+inttostr(input));
    col(red);
    gotoxy(16,2);
    if chances=1 then
     write('[You have '+inttostr(chances)+' chance left]')
    else
     write('[You have '+inttostr(chances)+' chances left]');
  end;
end;

procedure Guess();           // 7
var Guess: SmallInt;
begin
  Box(30,19,74,22,lightgreen,black,3);
  if (guess <= 0) or (guess > 100) then
  begin
    repeat
      col(lightgreen);
      gotoxy(3,1); write('What do you assume the');
      gotoxy(6,2); write('Mystery Number to be?');
      col(green);
      gotoxy(31,2);
      case tries of
        1 : write(dblarrowinv+' 3rd Try '+dblarrow);
        2 : write(dblarrowinv+' 2nd Try '+dblarrow);
        3 : write(dblarrowinv+' 1st Try '+dblarrow);
      end;
      col(white);
      gotoxy(36,1); write(': ');
      readln(guess);
      if (guess <= 0) or (guess > 100) then
      begin
        col(lightred);
        gotoxy(29,1); write('ERROR');
        gotoxy(37,1);
        cll; col(lightgray);
      end;
    until (guess > 0) and (guess <= 100);
  end;

  tries:=tries-1;

  if guess=TrueNumber then 
  begin
    Box(30,19,74,22,lightgreen,black,3);
    gotoxy(10,1); write('The Mystery Number is '+inttostr(guess)+'!!!');
    col(green);
    ElimNumbers[guess]:=true;
    gotoxy(3,2);
    write('[You are win, wait 1.5s for your prize]');
    guessedright:=true;
    delay(1500);
  end else
  begin
    Box(30,19,74,22,lightred,black,3);
    gotoxy(2,1); write('The Mystery Number is not '+inttostr(guess));
    col(red);
    ElimNumbers[guess]:=true;
    gotoxy(16,2);
    case tries of
      0   : begin
              gotoxy(3,2);
              write('[You are the loser, go drown in tears.]');
            end;
      1   : write('[You have '+inttostr(tries)+' try left]');
      2,3 : write('[You have '+inttostr(tries)+' tries left]');
    end;
  end;
end;

///////////////////////////////////////////////////

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
{}             label              {}
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

  Splash,
  Menu,
  PlayIntro,
  Play,
  Win,
  Loose,
  Instructions,
  About,
  LittleBoxes,
  Quit;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
{}             begin              {}
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

 Randomize;
 
 // Set a window with a 1pt single border; (78x23)
 // Using my procedure!!
Box(0,0,0,0,white,black,1);

Splash:

  DrawBG('PrmN',75,0,true,false);

   bgcol(yellow);
   for y:=1 to 4 do             // Clear bottom 4 lines
   begin
    gotoxy(1,23-y); delline;
   end;
   gotoxy(13,21);
   col(lightblue);
   write('[ Prime Numbers in Spain! :: An obscure adventure ]');
   gotoxy(24,22);
   col(lightred);
   write('"Knowing is half the battle"');

// Impliment ASCII art in a window in a window in a window.
// Thats 3 Windows! Microsoft eat your heart out! :P

   Box(20,2,60,20,lightgray,black,4);
   TheDuck(2,1,yellow,black);

   // Call Pause procedure until Return is pressed.
   window(1,1,79,24);
   col(darkgray);
   bgcol(yellow);
   gotoxy(65,24);
   write('Press Enter...');
   pause(#13); //Return is #13
   window(21,3,59,19);


   col(lightgreen);
   bgcol(black);
   gotoxy(22,2);
   write('So long');
   for x:=1 to 6 do
   begin
    write('.');
    delay(500);
   end;
   gotoxy(24,3);
   write('and thanks for');
   gotoxy(25,4);
   write('all the duck.');
   gotoxy(39,17);
   delay(1500);
   col(lightred);
   gotoxy(18,10);
   write(' `--[ BWAHAHAHAH! ]');
   gotoxy(39,17);
   delay(2500);

   cls;

{--- End Splash --}

Menu:

   DrawBG('Menu',1,0,true,true);

// PrmN logo
   Logo(10,7);

   Box(4,14,33,18,white,black,1);
     gotoxy(2,2);
     write('Knowing is half the battle');

   Box(36,3,74,23,white,black,4);
     gotoxy(3,2);
     write('Menu:');
     gotoxy(22,2);
     col(darkgray);
     write(version);

     Window(42,8,73,22);
     for x:=1 to 4 do
       writeln('('+inttostr(x)+')'+#10);
     col(lightgray);
     gotoxy(5,1); write('Play!');
     gotoxy(5,3); write('Instructions');
     gotoxy(5,5); write('About PrmN');
     gotoxy(5,7); write('Extra: Little Boxes '+#10);
     gotoxy(13,8); write('- by mj06');
     col(darkgray);
     gotoxy(1,11);
     col(lightgray); write('(S) ');
     col(darkgray); write('Show Intro');
     gotoxy(1,12);
     col(lightgray); write('(Q) ');
     col(darkgray); write('Quit');

     gotoxy(10,14);
     col(yellow);
     write('Choose your destiny!');

     repeat
     MenuChoice:=readkey;
     case MenuChoice of
      '1' : goto PlayIntro;
      '2' : goto Instructions;
      '3' : goto About;
      '4' : goto LittleBoxes;
      'S','s' : goto Splash;
      'Q','q' : goto Quit;
     end
     until keypressed;

{--- End Menu --}

PlayIntro:

//Begin Game
  DrawBG('Play',1,0,true,False);
  Box(10,3,71,23,white,black,4);
  Logo(52,5);

  Window(11,4,70,22);
  TheDuck(22,2,yellow,black);

  //Box(12,6,28,20,lightgray,black,1);
  window(13,3,30,20);

  //                  ##################
  col(white);
  gotoxy(1,5); Write('------------------');
  gotoxy(1,6); Write('Are you willing to');
  gotoxy(1,7); Write('  embark on this  ');
  gotoxy(1,8); Write('  this adventure  ');
  gotoxy(1,9); Write('------------------');
  gotoxy(7,12); col(lightgray);
  Write('(Y/N)');
  gotoxy(9,13);

  repeat
    MenuChoice:=readkey;
    case MenuChoice of
      'Y','y' : goto Play;
      'N','n' : goto Menu;
    end
  until keypressed;

Play:

  TrueNumber:=Random(99)+1;
  
  guessedright:=false;
  for x:=1 to 100 do ElimNumbers[x]:=false;
  primedone:=false;
  evensoddsdone:=false;
  chances:=6;
  tries:=3;


  DrawBG('PrmN',1,0,true,False);
  Box(4,3,77,23,white,black,4);
  Logo(9,4);

  Box(7,10,27,22,lightgreen,black,1);
   col(yellow);
   gotoxy(3,1); write('- Chance Menu -');
   col(white);
   for z:=1 to 6 do
   begin
     gotoxy(2,z+2);
     write(inttostr(z)+':');
   end;
   col(lightgray);
   gotoxy(5,3); write('A Prime Number');   // 1
   gotoxy(5,4); write('A Factor of:');     // 2
   gotoxy(5,5); write('A Multiple of:');   // 3
   gotoxy(5,6); write('Greater Than:');    // 4
   gotoxy(5,7); write('Less Than:');       // 5
   gotoxy(5,8); write('Evens/Odds');       // 6
   gotoxy(5,9); write('(Use 2 Chances)');
   z:=0;

// Draw Grid
  repeat
    if tries=0 then
    begin
      delay(1500);
      goto Loose;
    end;

    window(9,20,26,21);
    col(lightgreen);
    write('7: Guess Number');  // 8
    gotoxy(4,2); col(green);
    write(dblarrowinv+'  '+inttostr(tries)+' Left  '+dblarrow);
    Box(30,4,74,17,yellow,black,3);
    window(33,6,73,16);

    for x:=1 to 100 do
    begin
      if (x mod 10) <> 0 then
      begin
        if ElimNumbers[x] then
        col(darkgray) else col(lightgreen);
        write(inttostr(x));
        if x > 10 then
        write('  ')
        else
        write('   ');
      end else
      begin
        if ElimNumbers[x] then
        col(darkgray) else col(lightgreen);
        write(inttostr(x)+#10);
      end;
    end;

    if z=0 then
    begin
      Box(30,19,74,22,lightgray,black,3);
      gotoxy(3,1); write('Choose your choices; You have '+inttostr(chances)+' chances');
      gotoxy(3,2); write('before you are forced to guess '+inttostr(tries)+' times.');
    end;
    z:=1;

    window(0,0,0,0);
    gotoxy(30,18);
    col(darkgray);
    for x:=1 to 45 do write(#196);
    gotoxy(73,21);

    if chances=0 then
    begin
      if guessedright=true then goto win;
      delay(1500);
      Guess;
    end else
    begin
      ElimChoice:=readkey;
      case ElimChoice of
        '1' : Prime;
        '2' : Factor;
        '3' : Multiple;
        '4' : Greater;
        '5' : Less;
        '6' : EvenOdd;
        '7' : Guess;

       // The Small Cheat
       #30 :
        begin
          window(0,0,0,0);
          gotoxy(3,25);
          col(lightGreen);
          write('Ans: '+inttostr(truenumber));
        end;
    end;
    end;
  until guessedright=true;

{--- End Game --}

Win:
  DrawBG('Wina',1,0,true,false);
  Box(6,3,75,23,white,black,4);
  TheDuck(31,2,yellow,black);
  Logo(56,5);

  Box(9,5,34,21,yellow,black,1);
  writeln('You Win,');
  writeln;
  writeln;
  writeln;
  write(' Though ');
  col(lightred);
  write('THE DUCK');
  col(yellow);
  writeln(' still');
  writeln('  wins, you get to find');
  writeln('    and understand:');
  writeln;
  writeln;
  writeln;
  writeln(' The Meaning of life...');

  col(darkgray);
  gotoxy(2,14); write('Press Enter for');
  gotoxy(10,15); write('Salvation...');

  Pause(#13);

  DrawBG('Wina',1,0,true,false);
  Box(6,3,75,23,white,black,4);
  Logo(56,5);

  window(8,4,73,21);

  col(white);
  bgcol(black);
  gotoxy(2,5); write('The Oxford English Dictionary');
  gotoxy(8,6); write(' states ''Life'' as:');
  gotoxy(4,10); write('Life [n]: ');
  col(lightgray); write('The ability to breathe, grow, reproduce, etc.');
  gotoxy(6,11); write('which people, animals and plants have before they die');
  gotoxy(6,12); write('and which objects do not have.');

  col(white);
  gotoxy(20,15); write('Happy Now?');
  col(darkgray);
  gotoxy(32,18); write('Press Enter to return to Menu...');

  Pause(#13);
  goto Menu;

Loose:
  DrawBG('OhNo',1,0,true,false);
  Box(6,3,75,23,white,black,4);
  TheDuck(31,2,yellow,black);
  Logo(56,5);

  Box(9,5,34,21,yellow,black,1);
  writeln('You loose,');
  writeln;
  writeln;
  writeln;
  writeln(' It''s all over');
  writeln('  Better luck next time');
  col(lightred);
  write('   THE DUCK');
  col(yellow);
  writeln(' wins...');
  writeln('    And you bombed out');

  col(darkgray);
  gotoxy(3,14); write('Press Enter to');
  gotoxy(5,15); write('return to the menu');

  Pause(#13);
  goto Menu;

Instructions:

  DrawBG('PrmN',1,0,true,false);
  Box(4,3,77,23,white,black,4);

// PrmN logo
  Logo(57,5);

  Window(6,5,76,22);
  gotoxy(1,1);
  col(white);
  bgcol(black);
  Caption('Instructions:');
  Window(8,8,76,22);
// Page 1
  col(white);
  Writeln('The Basics:');
  col(lightgray);
  Writeln;
  Writeln('"Sword of Omens, give me sight beyond sight!"');
  Writeln('You might ask yourself, what is the meaning to life, the universe');
  Writeln('and everything else; and the answer lies beneath this game. By');
  Writeln('''beneath'', I mean it is garded by a three headed dog named');
  Writeln('Alcidecidialanikovivichina and a savage binary eating meerkat');
  Writeln('pokemon called Kikiokikon with a bad case of Melsis and Polio.');
  Writeln('"This is the big one! I''m coming to join you, Elizabeth!"');
  Writeln;
  Writeln('But really, that was just a metaphor stating that if your overall');
  Writeln('IQ is either less than or equal to 55, this game is just a');
  Writeln('mere distraction in your ''simple'' yet carefree life.');
  gotoxy(39,15);
  col(darkgray);
  write('Press Enter to go to page 2...');
  Pause(#13);

  Box(4,3,77,23,white,black,4);
  Window(6,5,76,22);
  Caption('Instructions:');
  Logo(57,5);
  col(white);
  bgcol(black);
  Window(8,8,76,22);

// Page 2
  col(white);
  Writeln('The Real Basics:');
  col(lightgray);
  Writeln('Here are the basics you should know...');
  writeln;
  Writeln(' '+dblarrow+'  You are given a set of numbers (1 to 100)');
  Writeln(' '+dblarrow+'  The goal is to guess the random number.');
  Writeln(' '+dblarrow+'  You are given 6 chances to eliminate the most numbers from the');
  Writeln('    table by using 6 different techniques. Primes, Factors,');
  Writeln('    Multiples, Greater Than or Equal to, Less than or Equal to,');
  Writeln('    and Even/Odd split. After 6 chances you are given 3 tries');
  writeln('    to guess the Mystery Number.');
  Write(' '+dblarrow+'  If you loose, you combust in hell and ');
  col(lightred); write('THE DUCK'); col(lightGray);
  Writeln(' wins.');
  Writeln(' '+dblarrow+'  If you happen to win, you combust in hell, get reincarnated');
  write('    as a gnat, and ');
  col(lightred); write('THE DUCK'); col(lightGray);
  Writeln(' wins.');
  Write(' '+dblarrow+'  And you also find out the meaning of life....');
  gotoxy(36,15);
  col(darkgray);
  write('Press Enter to get to the Menu...');
  Pause(#13);

  goto Menu;

{--- End Instructions --}

About:
  DrawBG('????',1,0,true,true);
  Box(12,5,69,21,white,black,4);
  gotoxy(2,2);

  col(lightgray);
  gotoxy(3,2); write('Prime Numbers in Spain was written in Delphi Console');
  gotoxy(3,4); write('   Everything in this program was written by mj06');
  gotoxy(3,6); write('       This game has nothing to do with Spain');
  gotoxy(3,9); write('The Little Boxes Procedure is used throughout this');
  gotoxy(3,10); write(' program, and as you can see it is very useful.');
  gotoxy(3,13); write('  For an added cheat, press Ctrl+Alt+A to view the');
  gotoxy(3,14); write('    Mysterious Number in the bottom right corner.');



  Pause(#13);
  goto Menu;

LittleBoxes:

  Reset;

  Box(0,0,0,0,lightred,black,4);
    col(white);
    gotoxy(3,3); writeln('Little Boxes by mj06:');
    window(6,6,79,24);
    col(lightGray);
    Writeln;
    Writeln('The following procedure draws a border box around set co-ordinates');
    Writeln('in a window; it also asks for the foreground and background colours.');
    Writeln('Once the border is drawn a window is placed inside that border to');
    Writeln('prevent overwiting of the edges.');
    Writeln;
    writeln;
    col(white);
    writeln('Box(LeftX, TopY, RightX, BottomY, FGcolour, BGcolour, BType)');
    col(lightgray);
    writeln;
    Writeln('Border Types: | 1, Single | 2, Double | 3, Thick | 4, Margin | ');
    Writeln('Note: Set leftx,rightx,topy,bottomy to 0 to create a screen border. ');
    Writeln('      Co-ords are relative to the console size not active window. ');
    Write('Uses: SysUtils, Console, and the above procedure (Reset). ');

  gotoxy(30,18);
  col(brown);
  write('Press Enter for a demonstration...');
  Pause(#13);

  Box(0,0,0,0,yellow,black,2);
     gotoxy(50,22); write('Box(0,0,0,0,yellow,black,2);');
  Box(6,2,70,20,white,black,3);
     gotoxy(29,2); write('Box(6,2,70,20,white,black,3);');
  Box(11,6,48,23,white,lightblue,1);
     gotoxy(2,15); write('Box(11,6,48,23,white,lightblue,1);');
  Box(27,8,67,18,darkgray,lightGray,4);
     gotoxy(2,2); write('Box(27,8,67,18,darkgray,lightGray,4);');
     col(black);
     gotoxy(4,8); write('Press Enter to return to menu...');

  Pause(#13);
  goto Menu;

Quit:

  (***** END PROGRAM *****)

end.



