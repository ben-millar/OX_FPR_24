> module Images where
> import Data.Complex
> import Bitmaps

> type CF = Complex Float

> point :: CF
> point = (-1.0) :+ 0.5

> type Image c = CF -> c

> cols :: Image Bool
> cols = even . floor . realPart

----------------------------------------------------------------------

Q1

There's a hint to try a one-dimensional version first:

> line :: Int -> Float -> Float -> [Float]
> line n x1 x2 = [ x1 + fromIntegral i * step | i <- [0..n-1] ]
>   where step = (x2-x1) / fromIntegral (n-1)

> grid :: Int -> Int -> CF -> CF -> Grid CF
> grid m n (px :+ py) (qx :+ qy) = [ [ x:+y | x <- xs ] | y <- ys ]
>   where
>     xs = line m px qx
>     ys = line n qy py

Q2

> sample :: Grid CF -> Image c -> Grid c
> sample zss f = map (map f) zss