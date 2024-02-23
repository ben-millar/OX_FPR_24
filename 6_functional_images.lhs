> module Images where
> import Data.Complex
> import Bitmaps

> type CF = Complex Float
> point :: CF
> point = (-1.0):+0.5

> type Image c = CF -> c

> cols :: Image Bool
> cols = even . floor . realPart

For example:

    ghci> pbmRender "test.pbm" ( sample ( grid 90 90 (0.05:+0.05) (8.95:+8.95) ) cols )

Question 1:

> line :: Int -> Float -> Float -> [Float]
> line n x1 x2 = [ x1 + fromIntegral i * step | i <- [0..n-1] ]
>   where step = (x2-x1) / fromIntegral (n-1)

> grid :: Int -> Int -> CF -> CF -> Grid CF
> grid m n (px :+ py) (qx :+ qy) = [ [ x:+y | x <- xs ] | y <- ys ]
>   where
>     xs = line m px qx
>     ys = line n qy py


Question 2:

> sample :: Grid CF -> Image c -> Grid c
> sample zss f = map (map f) zss


Question 3:

> rows :: Image Bool
> rows = even . floor . imagPart


Question 4:

> chequer :: Image Bool
> chequer img = rows img && cols img


Question 5:

> rings :: Image Bool
> rings = even . floor . magnitude

For example:

    ghci> pbmRender "test.pbm" ( sample ( grid 100 100 (-(10.0:+10.0)) (10.0:+10.0) ) rings )


Question 6:

> wedges :: Int -> Image Bool
> wedges n m = even(floor((phase m) / (pi / fromIntegral(n))))

For example:

    ghci> pbmRender "test.pbm" ( sample ( grid 100 100 (-(10.0:+10.0)) (10.0:+10.0) ) (wedges 12) )


Question 7:

% >   where remainder n = 