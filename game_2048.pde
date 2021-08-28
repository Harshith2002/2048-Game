int[][]board=new int[4][4];
int score,high_score,alive;
void setup()
{
  size(500,600);
  restart_game();
}

void draw()
{
  background(225);
  fill(150);
  rect(0,100,600,600,10);
  for(int j=0;j<board.length;j++)
  {
    for(int i=0;i<board[j].length;i++)
    {
      float x=120*i+20;
      float y=120*j+120;
      fill(200);
      rect(x,y,100,100,5);
      if(board[j][i]>0)
      {
        if(board[j][i]==2)
        {
          fill(238,228,218);
        }
        else if(board[j][i]==4)
        {
          fill(237,224,200);
        }
        else if(board[j][i]==8)
        {
          fill(242,177,121);
        }
        else if(board[j][i]==16)
        {
          fill(245,149,99);
        }
        else if(board[j][i]==32)
        {
          fill(246,124,95);
        }
        else if(board[j][i]==64)
        {
          fill(246,94,59);
        }
        else if(board[j][i]==128)
        {
          fill(237,207,114);
        }
        else if(board[j][i]==256)
        {
          fill(237,204,97);
        }
        else if(board[j][i]==512)
        {
          fill(237,200,80);
        }
        else if(board[j][i]==1024)
        {
          fill(237,197,63);
        }
        else if(board[j][i]==2048)
        {
          fill(237,194,46);
        }
        rect(x,y,100,100,5);
        if(board[j][i]==2 || board[j][i]==4)
        {
          fill(0);
        }
        else
        {
          fill(255);
        }
        textAlign(CENTER);
        textSize(40);
        text(""+board[j][i],x,y+30,100,100);
      }
    }
  }
  textAlign(CENTER);
  textSize(30);
  fill(0);
  text("2048 GAME",150,0,200,50);
  
  textAlign(LEFT);
  textSize(24);
  fill(0);
  text("Score:"+score,0,40,250,50);
  
  if(score>=high_score)
  {
    high_score=score;
  }
  textSize(20);
  fill(0);
  text("High Score:"+high_score,0,70,250,50);
  
  fill(255,0,0);
  rect(400,50,90,30,5);
  fill(0);
  textSize(20);
  text("Restart",410,53,250,50);
  if(mouseX>400 && mouseX<490 && mouseY>50 && mouseY<80)
  {
    if(mousePressed)
    {
      restart_game();
    }
  }
  
  if(alive==0)
  {
    fill(255,100);
    rect(0,0,600,600,0);
    fill(0);
    textAlign(CENTER);
    textSize(30);
    text("Game Over!! Click to play again",0,250,500,50);
    text("Your Score:"+score,100,300,300,50);
    if(mousePressed)
    {
      restart_game();
    }
  }
}

void restart_game()
{
  board=new int[4][4];
  score=0;
  alive=1;
  noStroke();
  game();
}

void game()
{
  ArrayList<Integer> xs=new ArrayList<Integer>();
  ArrayList<Integer> ys=new ArrayList<Integer>();
  for(int j=0;j<board.length;j++)
  {
    for(int i=0;i<board[j].length;i++)
    {
      if(board[j][i]==0)
      {
        xs.add(i);
        ys.add(j);
      }
    }
  }
  int rand=(int)random(0,xs.size());
  int x=xs.get(rand);
  int y=ys.get(rand);
  board[y][x]=random(0,1)<0.9?2:4;
}

int [][]move(int dy,int dx,boolean updated_score)
{
  int [][]Board=new int[4][4];
  for(int j=0;j<4;j++)
  {
    for(int i=0;i<4;i++)
    {
      Board[j][i]=board[j][i];
    }
  }
  boolean moved=false;
  if(dx!=0 || dy!=0)
  {
    int d=dx!=0?dx:dy;
    for(int p=0;p<board.length;p++)
    {
      for(int t=(d>0?board.length-2:1);t!=(d>0?-1:board.length);t=t-d)
      {
        int y=dx!=0?p:t;
        int x=dx!=0?t:p;
        int tx=x,ty=y;
        if(Board[y][x]==0)
        {
          continue;
        }
        for(int i=(dx!=0?x:y)+d;i!=(d>0?board.length:-1);i+=d)
        {
          int a=dx!=0?y:i;
          int b=dx!=0?i:x;
          if(Board[a][b]!=0 && Board[a][b]!=board[y][x])
          {
            break;
          }
          if(dx!=0)
          {
            tx=i;
          }
          else
          {
            ty=i;
          }
        }
        if((dx!=0 && tx==x) || (dy!=0 && ty==y))
        {
          continue;
        }
        else if(Board[ty][tx]==board[y][x])
        {
          Board[ty][tx]*=2;
          if(updated_score)
          {
            score=score+Board[ty][tx];
            moved=true;
          }
        }
        else if((dx!=0 && tx!=x) || (dy!=0 && ty!=y))
        {
          Board[ty][tx]=Board[y][x];
          moved=true;
        }
        if(moved==true)
        {
          Board[y][x]=0;
        }
      }
    }
  }
  if(moved==true)
  {
    return Board;
  }
  else
  {
    return null;
  }
}

boolean end()
{
  int []dx={1,-1,0,0};
  int []dy={0,0,1,-1};
  boolean out=true;
  for(int i=0;i<4;i++)
  {
    if(move(dy[i],dx[i],false)!=null)
    {
      out=false;
    }
  }
  return out;
}

void keyPressed()
{
  if(alive==1)
  {
    int k=keyCode;
    int dy=k==UP?-1:(k==DOWN?1:0);
    int dx=k==LEFT?-1:(k==RIGHT?1:0);
    int [][]updated_board=move(dy,dx,true);
    if(updated_board!=null)
    {
      board=updated_board;
      game();
    }
    if(end()==true)
    {
      alive=0;
    }
  }
}
