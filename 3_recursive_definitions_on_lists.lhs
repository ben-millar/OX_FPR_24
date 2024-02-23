Question 1: 

Write a recursive function, `prod::[Int] -> Int`, that calculates the product of a list of integers.

> prod :: [Int] -> Int
> prod []       = 1
> prod (x : xs) = x * prod xs

Question 2:

Write a resursive function, allTrue::[Bool] -> Bool, that determines whether every element of a list of booleans is True

> allTrue :: [Bool] -> Bool
> allTrue []       = True -- The neutral element of conjunction
> allTrue (x : xs) = x && allTrue(xs)

And, more generally:

> all' :: (a -> Bool) -> [a] -> Bool
> all' p []     = True
> all' p (x:xs) = p x && all p xs

Question 3:

Write a recursive function, allFalse::[Bool] -> Bool that determines whether every element of a list of booleans if False

> allFalse :: [Bool] -> Bool
> allFalse []       = True
> allFalse (x : xs) = not x && allFalse(xs)

Question 4:

Write a mapping function, decAll::[Int] -> [Int], that decrements each integer element on a list by one

> decAll :: [Int] -> [Int]
> decAll xs = map (+(-1)) xs

Question 5:
Write a function, convertIntBool::[Int] -> [Bool], that, given a list of integers, converts any zeroes to false and any other
numbers to true.

> convertIntBool :: [Int] -> [Bool]
> convertIntBool []     = []
> convertIntBool (x:xs) = toBool x : convertIntBool xs
>   where 
>       toBool 0 = False
>       toBool _ = True

Question 6:
Write a function, pairUp::[Int] -> [Char] -> [(Int,Char)], that pairs up corresponding elements of the two lists, stopping
when either list runs out:

> pairUp :: [Int] -> [Char] -> [(Int, Char)]
> pairUp (x:xs) (y:ys) = (x,y) : pairUp xs ys
> pairUp _ _           = []

For example:

    ghci> pairUp [1,2,3] ['a', 'b', 'c']
    [(1,'a'),(2,'b'),(3,'c')]

Question 7:
Write a function, takePrefix::Int -> [a] -> [a], that returns the prefix of the specified length of the given list.

> takePrefix :: Int -> [a] -> [a]
> takePrefix _ [] = []
> takePrefix n (x:xs)
>   | n > 0     = x : takePrefix (n-1) xs
>   | otherwise = []

For example:

    ghci> takePrefix 4 "Oxford"
    "Oxfo"

Question 8:
Write a function, dropPrefix::Int -> [a] -> [a], that drops a prefix of the specified length of the given list.

> dropPrefix :: Int -> [a] -> [a]
> dropPrefix _ [] = []
> dropPrefix n (x:xs)
>   | n > 0     = dropPrefix (n-1) xs
>   | otherwise = x:xs

For example:

    ghci> dropPrefix 2 "Oxford"
    "ford"

Question 9:
Write a function, member::Eq a => [a] -> a -> Bool, that determines whether a given list contains a specified element.

> member :: Eq a => [a] -> a -> Bool
> member [] _ = False
> member (x:xs) t
>   | x == t    = True
>   | otherwise = member xs t

Alternatively:

> member' :: Eq a => [a] -> a -> Bool
> member' [] _     = False
> member' (x:xs) t = (x==t) || member' xs t

This second example allows us to use lazy evaluation to prevent us from needing to explore the other side of the branch if (x==t) is true

For example:

    ghci> member ['a', 'b', 'c'] 'b'
    True

    ghci> member ['a', 'b', 'c'] 'd'
    False

Question 10:
Write a function, equals::Eq a => [a] -> [a] -> Bool. that determines whether two lists contain the same elements in the same order.

> equals :: Eq a => [a] -> [a] -> Bool -- Eq a => is a typeclass constraint, ensuring the abstract type a is within the typeclass Eq
> equals [] [] = True
> equals (x:xs) (y:ys)
>   | x == y    = equals xs ys
>   | otherwise = False
> equals _ _    = False

Alternatively

> equals' :: Eq a => [a] -> [a] -> Bool -- Eq a => is a typeclass constraint, ensuring the abstract type a is within the typeclass Eq
> equals' [] []         = True
> equals' (x:xs) (y:ys) = (x==y) && equals' xs ys
> equals' _ _           = False

For example:

    ghci> equals [] []
    True

    ghci> equals [] [2]
    False

    ghci> equals [2,1] [1,2]
    False

    ghci> equals [2,1] [2,1]
    True

Question 11:
Write a function, select::[a] -> Int -> a, that returns the element of the list at the given position.

% > select :: [a] -> Int -> a
% > select xs i = if i > ((length xs) - 1)

Question 12:
Write a function, largest, which calculates the largest value in a list of integers.

> largest :: [Int] -> Int
> largest []     = minBound
> largest (x:xs) = max x largest xs