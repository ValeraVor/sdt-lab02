type
     PRec = ^TRec;
        TRec = record
        myNext : PRec;
        NSt   :string[20];
        Time  :string[20];
        ID :integer;
end;
var List,newList : PRec;
    addID:integer;
{добавление данных в список}
procedure AddToList(var myList:PRec; const addNst : string; const addTime : string);
var P : PRec;
begin
    P:= myList;
    New(P);
    P^.NSt:= addNst;
    P^.Time:= addTime;
    inc(addID);
    P^.ID:= addID;
    P^.myNext:=List;
    List:=P;
end;

function Assigned(p : pointer): boolean;  { для ABCNet }
begin
  Assigned:= p<>nil
end;

{ Распечатка списка }
procedure PrintList(var myList:PRec);
var P : PRec;
begin
  P:= myList;
  writeln('Распечатка списка: ');
  while Assigned(P) do begin
    Writeln('Номер поезда: ',P^.ID,'':3,'Название станции назначения: ',P^.NSt,'':3,'Время отправления: ',P^.Time);
    P:= P^.myNext;
  end;
end;

{изменение личных данных}
procedure ChangeList(const myList: PRec; const myNSt: string; const myTime: string);
var P: PRec;  i,a:integer;
begin
  P:= myList;
  while P<>nil do 
    begin
      inc(i);
      if myNSt = P^.NSt then 
      begin
          P^.Time:=myTime;
      end;
      P:=P^.myNext;
    end;
end;

{по запросу вывести данные поезда, с одним и тем же временем}
procedure IntList(const myList: PRec; const myTime: string);
var P: PRec;  i,a:integer;
begin
  P:= myList;
  while P<>nil do 
    begin
      inc(i);
      if myTime = P^.Time then 
      begin
          Writeln('Номер поезда: ',P^.ID,'':3,'Название станции назначения: ',P^.NSt,'':3,'Время отправления: ',P^.Time);
      end;
      P:=P^.myNext;
    end;
end;

{сортировку станций назначения по алфавиту}
procedure SortList(const myList: PRec);
   var l,ll,p,first,pp,t1,t2,u:PRec;
   k,kk:boolean;
   begin
      l:=myList;
      while l^.myNext <> nil do
      begin
         p:=l^.myNext;
         while p<>nil do
         begin
            if l^.NSt>p^.NSt then
            begin
              t1:=l;
              t2:=p;
              l:=t2;
              u:=l^.myNext;
              if not k then begin
                t1^.myNext:=t2^.myNext;
                l^.myNext:=t1;
              end else 
              begin
                  l^.myNext:=t1^.myNext; 
                  pp^.myNext:=t1;
                  t1^.myNext:=u;
              end;
              k:=false;
              pp:=t2;
              p:=p^.myNext;
            end else begin pp:=p;  p:=p^.myNext; end;
            k:=true;
         end;
         k:=false;
         if not kk then begin first:=l; end;
         if  kk = true then ll^.myNext:=l;
         kk:=true;
         ll:=l;
         l:=l^.myNext;
      end;
      List:=first;
   end;

{ Длина списка }
function CountList(const myList:PRec): integer; 
var P:PRec; i:byte;
begin
  P:= myList;
  while P<>nil do
  begin
    inc(i);
    P:= P^.myNext;
  end;
  CountList:=i;
end;

{Вставка нового элемента перед i- элементом}
procedure InsertList(const myList:PRec; const ii: integer);
var P,Q: PRec; 
      i:integer;
      addNSt,addTime:string;
begin
  P:=myList;
  while P<>nil do 
  begin
    inc(i);
    if ii = i then 
    begin
        new(Q);
        writeln('Введите станцию назначения: '); Readln(addNSt);
        writeln('Введите время отпраления: '); Readln(addTime);
        Q^.NSt:=addNSt;
        Q^.Time:=addTime;
        inc(addID);
        Q^.ID:=addID;
        Q^.myNext:=P^.myNext;
        P^.myNext:=Q;
    end;
    P:= P^.myNext;
  end;
end;


{Удаление i- элемента}
procedure DeleteList(const myList:PRec; const ii: integer);
var P,Q,Z: PRec;  i:integer;
begin
  P:= myList;
  while P<>nil do 
  begin
    inc(i);
    if ii = i then 
    begin
        Z^.myNext:=P^.myNext;
        Q:=P;
        Dispose(Q);
    end;
    Z:=P;
    P:=P^.myNext;
  end;
  inc(i);
  if ii = i then 
    begin
       Dispose(P);
    end;
end;

{Удаление списка}
procedure DeletesList(const myList:PRec);
var P,Q: PRec; 
begin
  P:= myList;
  while P<>nil do 
  begin
    Q:=P^.myNext;
    Dispose(P);
    P:=Q;
  end;
end;

{Поиск i-элемента}
function RecList(const myList: PRec; const ii: integer):string;
var P: PRec;  i:integer;
begin
  P:= myList;
  while P<>nil do 
    begin
      inc(i);
      if ii = i then 
      begin
          RecList:=P^.NSt;
      end;
      P:=P^.myNext;
    end;
end;

{ Прверка на равенство списков }
function  EquList(const myList1,myList2:PRec):boolean;
var P2,P3:PRec; 
    b:boolean;
begin
  P2:= myList1;
  P3:= myList2;
  while (P2 <> nil) and (P3 <> nil) and (P2^.NSt = P3^.NSt) do
    begin P2 := P2^.myNext; P3 := P3^.myNext; end;
  EquList := (P2 = nil) and (P3 = nil);
end;

{ Главная программа }
var i,doit: integer;
    IntName,IntTime:string;
  tm,first,u:PRec;
  RusA:array[1..20] of char=('А','Б','В','Г','Д',
                            'Е','Ж','З','И','К',
                            'Л','М','Н','О','П',
                            'Р','С','Т','У','Х');
  R:array[1..20] of char=('а','б','в','г','д',
                            'е','ж','з','и','к',
                            'л','м','н','о','п',
                            'р','с','т','у','х');
begin   
  List:= nil;
  doit:=-1;
  while doit <> 0 do 
  begin
      writeln('Выберите действие :');
      writeln('1. Сортировать по алфавиту станции назначения');
      writeln('2. Вывести список');
      writeln('3. Изменить время отпраления по названию станции назначения');
      writeln('4. Вывести номер поезда с введенным временем отпраления');
      writeln('5. Добавить данные');
      writeln('6. Определить длинну списку');
      writeln('7. Вставить новый элемент на i-место');
      writeln('8. Удалить элемент с i-место');
      writeln('9. Поиск i-фамилии');
      writeln('10. Проверка на равенство списков по фамилии');
      writeln('11. Удалить список');
      writeln('12. Добавить данные newList');
      writeln('0. Выход');
      Readln(doit);
      case doit of
      1: SortList(List);
      2: PrintList(List);
      3: begin 
               writeln('Введите название станции: '); Readln(IntName);
               writeln('Введите время отпраления поезда: '); Readln(IntTime); 
               ChangeList(List,IntName,IntTime); 
         end;
      4: begin writeln('Введите время отпраления: '); Readln(IntTime); IntList(List,IntTime); end;
      5: begin
                Write('Введите число новых данных: '); Readln(i);
                for i:=1 to i do begin
                  Write('Введите название станции назначения: '); Readln(IntName);
                  AddToList(List, IntName, random(24)+':'+random(60));
                end;
         end;
      6: writeln('Длина списока: ',CountList(List));
      7: begin writeln('Введите i-место: '); Readln(i); InsertList(List,i); end;
      8: begin writeln('Введите i-место: '); Readln(i); DeleteList(List,i); end;
      9: begin writeln('Введите i-элемент: '); Readln(i); RecList(List,i); end;
      10:if EquList(List,newList) then writeln('Списки равны') else writeln('Списки не равны');
      11:DeletesList(List);
      12: begin 
                Write('Введите число новых данных: '); Readln(i);
                for i:=1 to i do begin
                  Write('Введите название станции назначения: '); Readln(IntName);
                  AddToList(newList, IntName, random(24)+':'+random(60));
                end;
          end;
      end;
  end;
end.