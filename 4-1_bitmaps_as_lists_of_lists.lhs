> type Grid a = [[a]]

Question 1:
Define a function to render a character grid to the console.

> catPic :: Grid Char
> catPic =
>    ["  *       *  ",
>     " * *     * * ",
>     " *  *****  * ",
>     "*           *",
>     "*  *     *  *",
>     "*     *     *",
>     " *   ***   * ",
>     "   *******   "]

> charRender :: Grid Char -> IO()
> charRender = putStr . unlines

Question 2:
Define functions to produce character bitmaps of:
    1. A solid square;
    2. A hollow square;
    3. A right-angled triangle.

All of a given side length.

> solidSquare :: Int -> Grid Char
> solidSquare n = [ [ '*' | x <- [0..n-1] ] | y <- [0..n-1] ]

> solidSquare' :: Int -> Grid Char
> solidSquare' n = replicate n (replicate n '*')

For example:

    ghci> (charRender . solidSquare) 3
    ***
    ***
    ***
    ghci> charRender $ solidSquare 3
    ***
    ***
    ***

> hollowSquare :: Int -> Grid Char
> hollowSquare n = [ [ f x y | x <- [0..n-1] ] | y <- [0..n-1] ]
>   where f x y = if x == 0 || y == 0 || x == n-1 || y == n-1 then '*' else '.'

> hollowSquare' :: Int -> Grid Char
> hollowSquare' n = [edge] ++ replicate (n-2) middle ++ [edge]
>   where
>       edge = replicate n '*'
>       middle = "*" ++ replicate (n-2) '.' ++ "*"

% > rightTriangle :: Int -> Grid Char