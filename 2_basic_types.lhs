
> import Data.Char

Question 1:

We can define the operations 'and' and 'or' using pattern matching as follows:

> and :: (Bool, Bool) -> Bool
> and (False, _) = False 
> and (True, x) = x

> or :: (Bool, Bool) -> Bool
> or (True, _) = True
> or (_, True) = True
> or (_, _) = False

Question 3:

Define a function that converts a digit character to its numeric equivalent.

> charToNum :: (Char) -> Int
> charToNum c = ord c - ord '0'

Question 4:

> showDate :: Int -> Int -> Int -> String
> showDate d m y = showDay d ++ " " ++ showMonth m ++ " " ++ show y
>   where
>       showMonth m = months !! (m-1)
>       months = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
>
>       showDay d = show d ++ suffix d
>       suffix d | (t/=1) && 1<=u && u<=3 = suffices !! (u-1)
>                | otherwise = "th"
>           where (t,u) = d `divMod` 10
>       suffices = ["st","nd","rd"]


Notes:
The pipeline:
map (map reverse) . map tails . map reverse

Is equivalent to the pipeline:
map (map reverse . tails . reverse)

> x &&&& y = if x then y else False
> x |||| y = if x then True else y