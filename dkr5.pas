    var
  arr: array of integer;
  i, j, count, ram, c, m, len, max, id_max: integer;
  f, answer: text;
//vstavka
procedure vstavka(var arr: array of integer);
var
  x, i, j, f: integer;
begin
  for i := 2 to length(arr) do
  begin
    x := arr[i];
    j := i - 1;
    while (j > 0) and (x < arr[j]) do
    begin
      arr[j + 1] := arr[j];
      j := j - 1;
    end;
    arr[j + 1] := x;
  end;
end;

function MaxNumber(arr: array of integer): integer;
var
  i, max: integer;
begin
  max := arr[0];
  for i := 1 to Length(arr) - 1 do
  begin
    if arr[i] > max then
      max := arr[i];
  end;
  Result := max;
end;

procedure RadixSort(var arr: array of integer);
var
  i, j, digit, maxNum, currentDigit, divisor: integer;
  buckets: array[0..9] of array of integer;
begin
  maxNum := MaxNumber(arr);
  currentDigit := 1;
  
  while maxNum / currentDigit > 0 do
  begin
    for i := 0 to 9 do
      SetLength(buckets[i], 0);
    
    for i := 0 to Length(arr) - 1 do
    begin
      digit := (arr[i] div currentDigit) mod 10;
      SetLength(buckets[digit], Length(buckets[digit]) + 1);
      buckets[digit][Length(buckets[digit]) - 1] := arr[i];
    end;
    j := 0;
    for i := 0 to 9 do
    begin
      for digit := 0 to Length(buckets[i]) - 1 do
      begin
        arr[j] := buckets[i][digit];
        j := j + 1;
      end;
    end;
    currentDigit := currentDigit * 10;
  end;
end;

begin
  writeln('1 - Алгоритм вставкой');
  writeln('2 - Поразрядный алгоритм');
  writeln('Введите сортировку:');
    read(c);
  writeln('Введите сложность теста (от 1 до 3)');
    read(m);
  case m of
    1: 
    assign(f, 'test1.txt');
    2: 
    assign(f, 'test2.txt');
    3: 
    assign(f, 'test3.txt');
  end;
  reset(f);
  count := 0;
  while not eof(f) do
  begin
    setlength(arr, count + 1);
    readln(f, ram);
    arr[count] := ram;
    inc(count);
  end;
  close(f);
  case c of
    1:
    vstavka(arr);
    2:
    RadixSort(arr);
  end;
  writeln('Отсортировано в файл answer.txt: ');
  assign(answer, 'answer.txt');
  rewrite(answer);
  for i := 0 to length(arr) - 1 do
    write(answer, arr[i] + ' ');
    close(answer);
end.