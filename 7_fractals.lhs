> module Fractals where
> import Data.Complex
> import Bitmaps
> import Images

> next :: CF -> CF -> CF
> next c z = z * z + c

Question 1:

Define a function to compute the trajectory of values for a given c as an infinite list:

> mandelbrot :: CF -> [CF]
> mandelbrot c = iterate (next c) 0


Question 2:

Define a function to approximate whether a point has not yet diverged:

> fairlyClose :: CF -> Bool
> fairlyClose p = magnitude p < 100


Question 3:

Define a function that takes the first few elements of an infinite sequence:

> firstFew :: [CF] -> [CF]
> firstFew zs = take 200 zs


Question 4:

Define a function that takes a trajectory function like `mandelbrot` and yields a boolean image; black for the points c whose trajectory
is (approximately) bounded, and white for the points whos trajectory are (approximately) unbounded:

> approximate :: (CF -> [CF]) -> Image Bool
> approximate f = \ z -> all fairlyClose ( firstFew ( f z ) )


Question 5:

Define another function which takes a trajectory function and returns a float in the range 0-1 which describes how quickly that trajectory diverges:

> fuzzy :: (CF -> [CF]) -> Image Float
> fuzzy f = \ z -> ratio (map fairlyClose ( firstFew ( f z ) ) )
>   where
>       ratio zs = floatLen (filter id zs) / floatLen zs
>       floatLen zs = (fromIntegral . length) zs