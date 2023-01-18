require 'ruby2d'



set title: '4 in a Row'
set background: '#34495E'

puts "Enter number of rows"
@rows = gets.to_i
puts "Enter number of columns"
@columns = gets.to_i

def checkIsDimensionValid()
  isValid = 0;
  while(isValid==0)
    if(@rows>@columns)
      if(@rows-@columns>2 or @rows<6 or @columns<7)
        puts "Choose correct field dimension!\nMinimum dimensions are 6x7\nThe number of rows and columns must not differ by more than 2 (e.g. 6x8, 9x9, 10x12 are fine, but 8x11 is not).\n"
        puts "Enter rows again"
        @rows = gets.to_i
        puts "Enter column again"
        @columns = gets.to_i
      else
        isValid=1;
      end
    else
      if(@columns-@rows>2 or @rows<6 or @columns<7)
        puts "Choose correct field dimension!\nMinimum dimensions are 6x7\n5The number of rows and columns must not differ by more than 2 (e.g. 6x8, 9x9, 10x12 are fine, but 8x11 is not).\n"
        puts "Enter rows again"
        @rows = gets.to_i
        puts "Enter column again"
        @columns = gets.to_i
      else
        isValid=1
      end
    end
  end
end

checkIsDimensionValid()
# Create a 2D array to represent the game board
board = Array.new(@rows) { Array.new(@columns) { 0 } }

# Create Player1 Steps
@Steps1 = Array.new()

# Create Player2 Steps
@Steps2 = Array.new()

GRID_SIZE = 60
WIDTH = @columns
HEIGHT = @rows+3
GRID_COLOR = Color.new("#ff0000")

set width: WIDTH * GRID_SIZE
set height: HEIGHT * GRID_SIZE

# Create a player 1 and player 2
player1 = 1
player2 = 2


def chooseFieldDimension()
  boardWidth = 6
  boardHeight = 7
  helpwidth = 0
  helpheight = 0

  Image.new('gameTitle.png', x: (WIDTH*GRID_SIZE)/2-65, y: (HEIGHT*GRID_SIZE)/2-220)
  Image.new('chooseboardtext.png', x: (WIDTH*GRID_SIZE)/2-106, y: (HEIGHT*GRID_SIZE)/2-120)

  /Creating control buttons for changing WIDTH size/
  pluswidth = Image.new('plus.png', x: (WIDTH*GRID_SIZE)/2-94, y: (HEIGHT*GRID_SIZE)/2-56)
  minuswidth = Image.new('minus.png', x: (WIDTH*GRID_SIZE)/2-94, y: (HEIGHT*GRID_SIZE)/2-16)

  /Creating control buttons for changing HEIGHT size/
  plusheight = Image.new('plus.png', x: (WIDTH*GRID_SIZE)/2+60, y: (HEIGHT*GRID_SIZE)/2-56)
  minusheight = Image.new('minus.png', x: (WIDTH*GRID_SIZE)/2+60, y: (HEIGHT*GRID_SIZE)/2-16)

  placeforwidthsize = Image.new('field4field.png', x: (WIDTH*GRID_SIZE)/2-45, y: (HEIGHT*GRID_SIZE)/2-37)
  placeforheightsize = Image.new('field4field.png', x: (WIDTH*GRID_SIZE)/2+11, y: (HEIGHT*GRID_SIZE)/2-37)
  superx = Image.new('x.png', x: (WIDTH*GRID_SIZE)/2-2.5, y: (HEIGHT*GRID_SIZE)/2-29)


  newGame = Image.new('newGame.png', x: (WIDTH*GRID_SIZE)/2-49, y: (HEIGHT*GRID_SIZE)/2+40)
  loadGame = Image.new('loadGame.png', x: (WIDTH*GRID_SIZE)/2-51, y: (HEIGHT*GRID_SIZE)/2+84)

  whatisX = Text.new(
    boardWidth,
    x: (WIDTH*GRID_SIZE)/2-32, y: (HEIGHT*GRID_SIZE)/2-27,
    font: 'averta.woff',
    style: 'bold',
    size: 16,
    color: 'white'
  )

  whatisY = Text.new(
    boardHeight,
    x: (WIDTH*GRID_SIZE)/2+24, y: (HEIGHT*GRID_SIZE)/2-27,
    font: 'averta.woff',
    style: 'bold',
    size: 16,
    color: 'white'
  )

  on :mouse_down do |event|
    puts event.x, event.y

    if pluswidth.contains?(event.x, event.y)
      if(boardWidth+helpwidth>=9 and boardWidth+helpwidth>0 )
        helpwidth+=1
        whatisX.remove
        whatisX = Text.new(
          boardWidth+helpwidth,
          x: (WIDTH*GRID_SIZE)/2-35, y: (HEIGHT*GRID_SIZE)/2-27,
          font: 'averta.woff',
          style: 'bold',
          size: 16,
          color: 'white'
        )
      elsif(boardWidth+helpwidth>5)
        helpwidth+=1
        whatisX.remove
        whatisX = Text.new(
          boardWidth+helpwidth,
          x: (WIDTH*GRID_SIZE)/2-32, y: (HEIGHT*GRID_SIZE)/2-27,
          font: 'averta.woff',
          style: 'bold',
          size: 16,
          color: 'white'
        )
      end
    elsif minuswidth.contains?(event.x, event.y)
      if(boardWidth+helpwidth>=9 and boardWidth+helpwidth>0 )
        helpwidth-=1
        whatisX.remove
        whatisX = Text.new(
          boardWidth+helpwidth,
          x: (WIDTH*GRID_SIZE)/2-35, y: (HEIGHT*GRID_SIZE)/2-27,
          font: 'averta.woff',
          style: 'bold',
          size: 16,
          color: 'white'
        )
      elsif(boardWidth+helpwidth>6)
        helpwidth-=1
        whatisX.remove
        whatisX = Text.new(
          boardWidth+helpwidth,
          x: (WIDTH*GRID_SIZE)/2-32, y: (HEIGHT*GRID_SIZE)/2-27,
          font: 'averta.woff',
          style: 'bold',
          size: 16,
          color: 'white'
        )
      end


    elsif plusheight.contains?(event.x, event.y)
      if(boardHeight+helpheight>=9 and boardHeight+helpheight>0 )
        helpheight+=1
        whatisY.remove
        whatisY = Text.new(
          boardHeight+helpheight,
          x: (WIDTH*GRID_SIZE)/2+20, y: (HEIGHT*GRID_SIZE)/2-27,
          font: 'averta.woff',
          style: 'bold',
          size: 16,
          color: 'white'
        )
      elsif(boardHeight+helpheight>6)
        helpheight+=1
        whatisY.remove
        whatisY = Text.new(
          boardHeight+helpheight,
          x: (WIDTH*GRID_SIZE)/2+24, y: (HEIGHT*GRID_SIZE)/2-27,
          font: 'averta.woff',
          style: 'bold',
          size: 16,
          color: 'white'
        )
      end
    elsif minusheight.contains?(event.x, event.y)
      if(boardHeight+helpheight>10 and boardHeight+helpheight>0 )
        helpheight-=1
        whatisY.remove
        whatisY = Text.new(
          boardHeight+helpheight,
          x: (WIDTH*GRID_SIZE)/2+20, y: (HEIGHT*GRID_SIZE)/2-27,
          font: 'averta.woff',
          style: 'bold',
          size: 16,
          color: 'white'
        )
      elsif(boardHeight+helpheight>7)
        helpheight-=1
        whatisY.remove
        whatisY = Text.new(
          boardHeight+helpheight,
          x: (WIDTH*GRID_SIZE)/2+24, y: (HEIGHT*GRID_SIZE)/2-27,
          font: 'averta.woff',
          style: 'bold',
          size: 16,
          color: 'white'
        )
      end
    elsif newGame.contains?(event.x, event.y)
      board2 = Array.new(@rows+helpwidth) { Array.new(@columns+helpheight) { 0 } }
      @rows = @rows+helpwidth
      @columns = @columns+helpheight
      draw_board(board2)
      playGame(board2)
    end
  end

end

/Function which draw steps from Steps Array/
def drawHistory(steps1,steps2)
  redSteps = @Steps1.join(', ')
  yellowSteps = @Steps2.join(', ')
  redSteps ='Red : '+ redSteps
  yellowSteps ='Yellow : '+ yellowSteps
  Text.new(redSteps, x: 10 , y: (HEIGHT-1) * GRID_SIZE-50, size: 13)
  Text.new(yellowSteps, x: 10 , y: (HEIGHT-1) * GRID_SIZE-30, size: 13)
end

# Method that draw board 
def draw_board(board)
  # Iterate over the rows and columns of the board
  board.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      # Set the fill color based on the value of the cell
      case cell
      when 0
        imageName = "emptyCircle.png"
      when 1
        imageName = "redCircle.png"
      when 2
        imageName = "yellowCircle.png"
      end

      # Draw a circle at the given position with the specified color/image
      Image.new("box.png",x: j * 60, y: (i+1) * 60)
      Image.new(imageName, x: j * 60 + 10 , y: (i+1) * 60 + 10)
      # Draw buttons for Load Game and Save Game
      @loadgame = Image.new("loadGame.png", x: 10 , y: HEIGHT * GRID_SIZE - 47)
      @savegame = Image.new("saveGame.png", x: 123 , y: HEIGHT * GRID_SIZE - 47)
    end
  end
end

# Method that draws either Red (1) Player won or Yellow (2) won
def win_board(board,player)
  clear
  if(player==1)
    Image.new("player1Wins.png", x: (WIDTH * GRID_SIZE) / 2 - 100, y: (HEIGHT * GRID_SIZE) / 2 - 50)
  elsif(player==2)
    Image.new("player2Wins.png", x: (WIDTH * GRID_SIZE) / 2 - 100, y: (HEIGHT * GRID_SIZE) / 2 - 50)
  else
    Image.new("DRAW.png", x: (WIDTH * GRID_SIZE) / 2 - 100, y: (HEIGHT * GRID_SIZE) / 2 - 50)
  end
end


# Method that check if field is available
def checkFieldIsFree(board,column)
  # We define helprows and it will return us first available row, it iterate from bottom to top
  helprows = HEIGHT-4
  while helprows >=0
      if(board[helprows][column]==0)
          return helprows
      else
          helprows-=1
      end
  end
  return -1
end

# Method that fill 2D array
def inputInField(board,column,player)
  # First we check if field is empty and we store it into variable
  fieldDestination = checkFieldIsFree(board,column)
  # If it is we 
  if(fieldDestination >= 0)
      board[fieldDestination][column]=player
      if(player==1)
        @Steps1.push(column+1)
      else
        @Steps2.push(column+1)
      end
      clear
  else
      Image.new("chooseAnotherField.png", x: WIDTH * GRID_SIZE - 214 , y: 13) 
  end
end

# Method that check if game is draw
def check_draw(board)
  (0...HEIGHT-4).each do |row|
    (0...WIDTH).each do |column|
      if board[row][column]==0 
        return false
      end
    end
  end
  return true
end

# Function to check if a player has won the game
def check_win(board, piece)
  # Check for horizontal win
  board.each do |row|
    count = 0
    row.each do |cell|
      count += 1 if cell == piece
      count = 0 if cell != piece
      return true if count == 4
    end
  end

  # Check for vertical win
  (0...WIDTH-1).each do |column|
    count = 0
    (0...HEIGHT-4).each do |row|
      count += 1 if board[HEIGHT-4-row][column] == piece
      count = 0 if board[HEIGHT-4-row][column] != piece
      return true if count == 4
    end
  end

  # Check diagonal win, from right to left
  (0...HEIGHT-6).each do |row|
    (0...WIDTH-3).each do |column|
      count = 0
      (0...4).each do |offset|
        count += 1 if board[row+offset][column+offset] == piece
        count = 0 if board[row+offset][column+offset] != piece
        return true if count == 4
      end
    end
  end

  #Check diagonal win from left to right
  (3...HEIGHT-3).each do |row|
    (0...WIDTH-3).each do |column|
      count = 0
      (0...4).each do |offset|
        count += 1 if board[row-offset][column+offset] == piece
        count = 0 if board[row-offset][column+offset] != piece
        return true if count == 4
      end
    end
  end

  # No win found
  return false
end

# Method that end game, clear board and create workspace for displaying winner
def endGame(board,piece)
  if(check_win(board, piece))
    clear
    win_board(board,piece)
    return 1
  elsif(check_draw(board))
    clear
    win_board(board,3)
    return 1
  end
end

# Main method for game - It declare circle moving and what program does when field is choosed
def playGame(board)
  drawHistory(@Steps1,@Steps2)
  currentPlayer = 1
  igrac = Image.new("redCircle.png", x: 10 , y: 10, width: 40, height: 40)
  counter = 0
  counter1 = 0
  on :key_down do |event|
    case event.key
    when 'right'
      if(igrac.x<(WIDTH-1) * GRID_SIZE)
        igrac.x +=60
          counter+=1
      end
    when 'left'
      if(igrac.x>10)
        igrac.x-=60
          counter-=1
      end
    when 'space'
      fieldDestination = checkFieldIsFree(board,counter)
      inputInField(board,counter,currentPlayer)
      draw_board(board)
      result = endGame(board,currentPlayer)
      counter = 0
      if(currentPlayer == 1 && fieldDestination>=0 && result!=1)
        igrac.remove
        igrac = Image.new("yellowCircle.png", x: 10 , y: 10, width: 40, height: 40)
        currentPlayer = 2
        drawHistory(@Steps1,@Steps2)
      elsif(currentPlayer == 2 && fieldDestination>=0 && result!=1)
        igrac.remove
        igrac = Image.new("redCircle.png", x: 10 , y: 10, width: 40, height: 40)
        currentPlayer = 1
        drawHistory(@Steps1,@Steps2)
      elsif(currentPlayer == 1 && fieldDestination==-1 && result!=1)
        igrac.remove
        igrac = Image.new("redCircle.png", x: 10 , y: 10, width: 40, height: 40)
        currentPlayer = 1 
      elsif(currentPlayer == 2 && fieldDestination==-1 && result!=1)
        igrac.remove
        igrac = Image.new("yellowCircle.png", x: 10 , y: 10, width: 40, height: 40)
        currentPlayer = 2
      end
    end
  end

  on :mouse_down do |event|
    puts event.x, event.y
    if @loadgame.contains?(event.x, event.y)
      clear
      board = loadGame()
      currentPlayer = loadPlayer().to_i
      if(currentPlayer==1)
        igrac.remove
        igrac = Image.new("redCircle.png", x: 10 , y: 10, width: 40, height: 40)
      elsif(currentPlayer==2)
        igrac.remove
        igrac = Image.new("yellowCircle.png", x: 10 , y: 10, width: 40, height: 40)
      end
      @Steps1 = loadSteps1()
      @Steps2 = loadSteps2()
      drawHistory(@Steps1,@Steps2)
      draw_board(board)
    elsif @savegame.contains?(event.x,event.y)
      saveGame(board)
      savePlayer(currentPlayer)
      saveSteps1(@Steps1)
      saveSteps2(@Steps2)
    end
  end
end

def loadGame()
  filename = "save.txt"
  file = File.open(filename)
  file_data = file.read
  @loadedgame = Image.new("gameLoaded.png", x: WIDTH * GRID_SIZE - 132 , y: HEIGHT * GRID_SIZE - 47)
  if(@savedgame) 
    @savedgame.remove
  end
  return eval(file_data)
end

def loadSteps1()
  filename = "steps1.txt"
  file = File.open(filename)
  file_data = file.read
  return eval(file_data)
end

def loadSteps2()
  filename = "steps2.txt"
  file = File.open(filename)
  file_data = file.read
  return eval(file_data)
end

def loadPlayer()
  filename = "player.txt"
  file = File.open(filename)
  file_data = file.read
  return file_data
end

def saveGame(board)
  filename = "save.txt"
  File.open(filename, "w") { |f| f.write "#{Time.now}" }
  File.write(filename, board)
  if(@loadedgame) 
    @loadedgame.remove
  end
  @savedgame = Image.new("gameSaved.png", x: WIDTH * GRID_SIZE - 123 , y: HEIGHT * GRID_SIZE - 47)
end

def savePlayer(player)
  filename = "player.txt"
  File.open(filename, "w") { |f| f.write "#{Time.now}" }
  File.write(filename, player)
end

def saveSteps1(steps)
  filename = "steps1.txt"
  File.open(filename, "w") { |f| f.write "#{Time.now}" }
  File.write(filename, steps)
end

def saveSteps2(steps)
  filename = "steps2.txt"
  File.open(filename, "w") { |f| f.write "#{Time.now}" }
  File.write(filename, steps)
end

#chooseFieldDimension()
draw_board(board)
playGame(board)
show



