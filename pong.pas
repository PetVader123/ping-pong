uses GraphABC;

const
  BallSize = 10;
  SpeedX = 5;
  SpeedY = 5;
  PlatformWidth = 100;
  PlatformHeight = 20;
  PlatformSpeed = 20;

var
  BallX, BallY: integer;
  DirX, DirY: integer;
  PlatformX, PlatformY: integer;

procedure Initialize();
begin
  SetWindowSize(800, 600);
  BallX := WindowWidth div 2;
  BallY := WindowHeight div 2;
  DirX := SpeedX;
  DirY := SpeedY;
  PlatformX := (WindowWidth - PlatformWidth) div 2;
  PlatformY := WindowHeight - PlatformHeight - 30;
end;

procedure MoveBall();
begin
  BallX := BallX + DirX;
  BallY := BallY + DirY;

  // Обработка столкновений с краями окна
  if (BallX <= 0) or (BallX >= WindowWidth - BallSize) then DirX := -DirX;
  if (BallY <= 0) then DirY := -DirY;

  // Обработка столкновения с платформой
  if (BallY >= PlatformY - BallSize) and (BallX >= PlatformX) and (BallX <= PlatformX + PlatformWidth) then DirY := -DirY;
end;

procedure Draw();
begin
  ClearWindow;
  Circle(BallX, BallY, BallSize);
  Rectangle(PlatformX, PlatformY, PlatformX + PlatformWidth, PlatformY + PlatformHeight);
  Redraw;
end;

procedure ProcessKey(Key: integer);
begin
  case Key of
    VK_Left:  if PlatformX > 0 then PlatformX := PlatformX - PlatformSpeed;
    VK_Right: if PlatformX < WindowWidth - PlatformWidth then PlatformX := PlatformX + PlatformSpeed;
  end;
end;

begin
  Initialize();
  OnKeyDown := ProcessKey;
  while True do
  begin
    MoveBall();
    Draw();
    Sleep(10);
  end;
end.