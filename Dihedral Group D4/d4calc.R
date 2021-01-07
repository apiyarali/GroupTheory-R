# d4calc.R - Symmetries of the square

# Create data frame of square labels
D4.makeDataFrame <- function() {
  DF <- data.frame(name=rep("",8),cfg=rep("",8),stringsAsFactors = FALSE)
  DF[1,] <- c("i","ABCD") #identity
  DF[2,] <- c("r","DABC") #90 degree
  DF[3,] <- c("s","CDAB") #180 degree
  DF[4,] <- c("t","BCDA") #270 degree
  DF[5,] <- c("w","DCBA") #horizontal flip
  DF[6,] <- c("x","BADC") #vertical flip
  DF[7,] <- c("y","CBAD") #diagonal / flip
  DF[8,] <- c("z","ADCB") #diagonal \ flip
  return(DF)
}

# Testing D4.makeDataFrame Function
# BiggsDF <- D4.makeDataFrame()
# BiggsDF

# Plot Square
D4.showConfigs <- function(DF){
  par(mar=c(1,1,1,1))
  plot(NULL,xlim=c(0,32),ylim = c(-1,3.5), asp = 1, axes = FALSE)
  
  xl <- yb <- 0
  xr <- yt <- 3
  y1 <- y2 <- 2.6
  y3 <- y4 <- 0.4

  
  for (i in 0:7){
    rect(xl, yb, xr, yt)

    lbl <- strsplit(DF[i+1,2],"")[[1]]
    
    x1 <- x4 <- (xl + 0.4)
    x2 <- x3 <- (xl + 2.6)
    xa <- (xl + 1.5)
    
    
    text(c(x1, x2, x3, x4),c(y1, y2, y3, y4),lbl)
    text(xl+1.5,-0.85,DF[i+1,1])
    
    xl <- xl + 4
    xr <- xr + 4
    segments(c(15.5,21.5, 23.5, 27.5), c(1.5, -0.5, -0.5, 3.5), 
             c(19.5,21.5, 27.5, 31.5), c(1.5, 3.5, 3.5, -0.5), lty = 2)
  }
  
}

# Test showConfig function (plot square)
# D4.showConfigs(BiggsDF)

# Show square based on button and the next square depending if rotation or reflection is applied
#abcd is a string of symbols, reading clockwise from the top of the square
D4.showSquare <- function(abcd){
  par(mar=c(1,1,1,1))
  plot(NULL,xlim=c(0,3),ylim = c(-1,3), asp = 1, axes = FALSE)
  rect(0, 0, 3, 3)
  lbl <- strsplit(abcd,"")[[1]]
  text(c(0.4,2.6,2.6, 0.4),c(2.6,2.6, 0.4, 0.4),lbl)
}

# Test showSquare function
# D4.showSquare("ABCD")

#a is one of the Biggs symbols for an operation.

# Apply the new configuration based on user input.
#The return value is the new configuration
D4.apply <- function(a,abcd){
  v <- strsplit(abcd,"")[[1]]   #select first component of list
  w <- switch(a,
              "i" = v,
              "r" = c(v[4],v[1],v[2],v[3]),
              "s" = c(v[3],v[4],v[1],v[2]),
              "t" = c(v[2],v[3],v[4],v[1]),
              "w" = c(v[4],v[3],v[2],v[1]),
              "x" = c(v[2],v[1],v[4],v[3]),
              "y" = c(v[3],v[2],v[1],v[4]),
              "z" = c(v[1],v[4],v[3],v[2])
  )
  s <- paste(w,collapse="") 
  return(s)
}

# Test apply funciton
# new <- D4.apply("s","ABCD")

# multiply two d4 square.
D4.multiply <- function(DF,a,b){
  #Look up the name, which occurs once and only once
  idx <- which.max(DF$name==b)
  #Find the corresponding configuration
  cfg <- DF$cfg[idx]
  #Apply the group operation to it
  newcfg <- D4.apply(a,cfg)
  # Look up the configuration
  idx <- which.max(DF$cfg==newcfg)
  return (DF$name[idx])
}
# D4.multiply(BiggsDF,"r","r")

#To use this with outer() we must vectorize it
vD4.multiply <- Vectorize(D4.multiply,c("a","b"))
#outer(c("i","r","s","x","y","z"),c("i","r","s","x","y","z"),"vD3.multiply", DF = BiggsDF)

