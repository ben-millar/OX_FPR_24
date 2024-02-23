> module Bitmaps where

> type Grid a = [[a]]

> charRender :: Grid Char -> IO ()
> charRender = putStr . unlines

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

> charPalette, charPaletteBlocks :: [Char]
> charPalette = " .:oO8@"
> charPaletteBlocks = " \9617\9618\9619\9608"

> bwCharView :: Grid Bool -> Grid Char
> bwCharView = map (map (\ b -> if b then '*' else '.'))


Question 6:
Define a function, greyCharView, that converts a greyscale grid (where each cell is a float between 0 and 1) into a character grid,
parameterized on a palette such as charPalette.

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