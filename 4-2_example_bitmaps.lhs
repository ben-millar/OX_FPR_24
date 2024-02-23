> module Bitmaps where

> type Grid a = [[a]]

> catPic :: Grid Char
> catPic = 
>   [ "  *     *  ",
>     " * *   * * ",
>     " *  ***  * ",
>     "*         *",
>     "*  *   *  *",
>     "*    *    *",
>     " *       * ",
>     "  *******  " ]


Q1

> charRender :: Grid Char -> IO ()
> charRender css = putStr (unlines css)

I could have written:

  charRender css = (putStr . unlines) css

or equivalently

  charRender = putStr . unlines

Remember the definition of function composition:

  (f . g) x = f (g x)

----------------------------------------------------------------------

Q2

> solidSquare :: Int -> Grid Char
> solidSquare n = replicate n (replicate n '*')

A more sophisticated but more flexible approach:

> solidSquare' :: Int -> Grid Char
> solidSquare' n = [ [ '*' | x <- [0..n-1] ] | y <- [0..n-1] ]

Refactor the above to separate the square grid from the choice of pixels:

> solidSquare'' :: Int -> Grid Char
> solidSquare'' n = squarePic n (\ x y -> True)

> squarePic :: Int -> (Int -> Int -> Bool) -> Grid Char
> squarePic n p = [ [ if p x y then '*' else '.' | x <- [0..n-1] ] | y <- [0..n-1] ]

Assembly from first principles:

> hollowSquare :: Int -> Grid Char
> hollowSquare 1 = ["*"]
> hollowSquare n = [edge] ++ replicate (n-2) middle ++ [edge]
>   where
>     edge = replicate n '*'
>     middle = "*" ++ replicate (n-2) '.' ++ "*"

or pixel by pixel:

> hollowSquare' :: Int -> Grid Char
> hollowSquare' n = [ [ f x y | x <- [0..n-1] ] | y <- [0..n-1] ]
>   where f x y = if x==0 || y==0 || x==n-1 || y==n-1 then '*' else '.'

which is another instance of squarePic:

> hollowSquare'' :: Int -> Grid Char
> hollowSquare'' n = squarePic n p
>   where p x y = x==0 || y==0 || x==n-1 || y==n-1 

Assembly from first principles:

> rightTriangle :: Int -> Grid Char
> rightTriangle 1 = ["*"]
> rightTriangle n = map ('.':) (rightTriangle (n-1)) ++ [replicate n '*']

or, kind of halfway between:

> rightTriangle' :: Int -> Grid Char
> rightTriangle' n = [ row i | i <- [1..n] ]
>   where
>     row i = replicate (n-i) '.' ++ replicate i '*'

or again it could be an instance of squarePic.


Q3

> bwCharView :: Grid Bool -> Grid Char
> bwCharView = map (map (\ b -> if b then '*' else '.'))

> catBitmap :: Grid Bool
> catBitmap = [ 
>     [False,False,True,False,False,False,False,False,True,False,False],
>     [False,True,False,True,False,False,False,True,False,True,False],
>     [False,True,False,False,True,True,True,False,False,True,False],
>     [True,False,False,False,False,False,False,False,False,False,True],
>     [True,False,False,True,False,False,False,True,False,False,True],
>     [True,False,False,False,False,True,False,False,False,False,True],
>     [False,True,False,False,False,False,False,False,False,True,False],
>     [False,False,True,True,True,True,True,True,True,False,False]
>   ]

> fprBitmap :: Grid Bool
> fprBitmap = [
>     [ f, f, f, f, f, f, f, f, f, f, f, f, f, f, f, f, f, f ],
>     [ f, t, t, t, t, f, f, t, t, t, f, f, f, t, t, t, f, f ],
>     [ f, t, f, f, f, f, f, t, f, f, t, f, f, t, f, f, t, f ],
>     [ f, t, t, t, f, f, f, t, t, t, f, f, f, t, t, t, f, f ],
>     [ f, t, f, f, f, f, f, t, f, f, f, f, f, t, f, f, t, f ],
>     [ f, t, f, f, f, f, f, t, f, f, f, f, f, t, f, f, t, f ],
>     [ f, f, f, f, f, f, f, f, f, f, f, f, f, f, f, f, f, f ] ]
>   where f = False ; t = True

----------------------------------------------------------------------

> type Point = (Integer,Integer)

> catPoints :: [Point]
> catPoints = 
>   [(2,0),(8,0),(1,1),(3,1),(7,1),(9,1),(1,2),(4,2),(5,2),(6,2),
>    (9,2),(0,3),(10,3),(0,4),(3,4),(7,4),(10,4),(0,5),(5,5),
>    (10,5),(1,6),(9,6),(2,7),(3,7),(4,7),(5,7),(6,7),(7,7),(8,7)]

Q4

> pointsBitmap :: [Point] -> Grid Bool
> pointsBitmap zs = [ [ p x y | x <- [0..w] ]
>                   | y <- [0..h] ]
>   where
>     w = maximum (map fst zs)
>     h = maximum (map snd zs)
>     p x y = (x,y) `elem` zs


Q5

> gridPoints :: Grid Bool -> [Point]
> gridPoints bss = [ (x,y)
>                  | (bs,y) <- zip bss [0..], (b,x) <- zip bs [0..], b ]


----------------------------------------------------------------------

> logoShades :: Grid Float
> logoShades = [
>     [h,h,h,h,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
>     [0,h,h,h,h,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
>     [0,h,h,h,h,0,0,h,1,1,1,h,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
>     [0,0,h,h,h,h,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
>     [0,0,0,h,h,h,h,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0],
>     [0,0,0,h,h,h,h,0,0,h,1,1,1,h,0,0,h,h,h,h,h,h,h,h,h,h],
>     [0,0,0,0,h,h,h,h,0,0,1,1,1,1,0,0,0,h,h,h,h,h,h,h,h,h],
>     [0,0,0,0,0,h,h,h,h,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0],
>     [0,0,0,0,h,h,h,h,0,0,1,1,1,1,1,h,0,0,h,h,h,h,h,h,h,h],
>     [0,0,0,h,h,h,h,0,0,h,1,1,1,1,1,1,0,0,0,h,h,h,h,h,h,h],
>     [0,0,0,h,h,h,h,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0],
>     [0,0,h,h,h,h,0,0,1,1,1,1,0,h,1,1,1,h,0,0,0,0,0,0,0,0],
>     [0,h,h,h,h,0,0,h,1,1,1,h,0,0,1,1,1,1,0,0,0,0,0,0,0,0],
>     [0,h,h,h,h,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0],
>     [h,h,h,h,0,0,1,1,1,1,0,0,0,0,0,h,1,1,1,h,0,0,0,0,0,0]
>   ] where h = 0.5

% > bwCharView :: Grid Bool -> Grid Char
% > bwCharView = map (map (\ b -> if b then '*' else '.'))

> charPalette, charPaletteBlocks :: [Char]
> charPalette = " .:oO8@"
> charPaletteBlocks = " \9617\9618\9619\9608"

Question 6:
Define a function, greyCharView, that converts a greyscale grid (where each cell is a float between 0 and 1) into a character
grid, parameterized on a palette such as charPalette.

% > greyCharView :: [Char] -> Grid Float -> Grid Char
% > greyCharView c g = map (map (\ v -> c !! floor (fromIntegral(length c - 1) * v) )) g

> greyCharView :: [Char] -> Grid Float -> Grid Char
> greyCharView c g = map (map (pixel c)) g

> pixel :: [Char] -> Float -> Char
> pixel cs 1.0 = last cs
> pixel cs x = cs !! floor (fromIntegral (length cs) * x)

For example:

    ghci> charRender(greyCharView charPalette logoShades)
    ....  ::::                
     ....  ::::               
     ....  .:::.              
      ....  ::::              
       ....  ::::             
       ....  .:::.  ..........
        ....  ::::   .........
         ....  ::::           
        ....  :::::.  ........
       ....  .::::::   .......
       ....  ::::::::         
      ....  :::: .:::.        
     ....  .:::.  ::::        
     ....  ::::    ::::       
    ....  ::::     .:::.  


> fprGreymap :: Grid Float
> fprGreymap = [
>   [ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ],
>   [ 0,a,a,a,a,0,0,b,b,b,0,0,0,1,1,1,0,0 ],
>   [ 0,a,0,0,0,0,0,b,0,0,b,0,0,1,0,0,1,0 ],
>   [ 0,a,a,a,0,0,0,b,b,b,0,0,0,1,1,1,0,0 ],
>   [ 0,a,0,0,0,0,0,b,0,0,0,0,0,1,0,0,1,0 ],
>   [ 0,a,0,0,0,0,0,b,0,0,0,0,0,1,0,0,1,0 ],
>   [ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ] ]
>   where a = 1/3 ; b = 2/3

> data RGB = RGB Int Int Int
> 
> instance Show RGB where
>   show (RGB r g b) = show r ++" "++ show g ++" "++ show b

> fprPixmap :: Grid RGB
> fprPixmap = [
>   [ b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b ],
>   [ b,r,r,r,r,b,b,o,o,o,b,b,b,y,y,y,b,b ],
>   [ b,r,b,b,b,b,b,o,b,b,o,b,b,y,b,b,y,b ],
>   [ b,r,r,r,b,b,b,o,o,o,b,b,b,y,y,y,b,b ],
>   [ b,r,b,b,b,b,b,o,b,b,b,b,b,y,b,b,y,b ],
>   [ b,r,b,b,b,b,b,o,b,b,b,b,b,y,b,b,y,b ],
>   [ b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b ] ]
>   where r = RGB 7 0 0 ; o = RGB 7 3 0 ; y = RGB 7 7 0 ; b = RGB 0 0 0
