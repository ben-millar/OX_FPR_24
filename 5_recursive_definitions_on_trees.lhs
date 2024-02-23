> data Tree a = Empty | Node (Tree a) a (Tree a) deriving Show

E.g.,

> t :: Tree Int
> t = Node (Node Empty 1 Empty) 3 (Node Empty 3 Empty)

Question 1:
Write a function, size :: Tree a -> Integer, that calculates the number of elements in a tree:

> size :: Tree a -> Integer
> size (Empty)      =   0
> size (Node l v r) = 1 + size l + size r

Question 2:
Write a function, tree :: [a] -> Tree that converts a list into a tree:

> tree :: [a] -> Tree a
> tree []     = Empty
> tree (x:xs) = Node Empty x (tree xs)

Question 3:
member

% > memberT :: Eq a => Tree a -> Bool
% > memberT v Empty        = False
% > memberT v (Node l v r) = (x==y) || memberT l || memberT r

Question 4:

> searchTree :: Ord a => [a] -> Tree a
> searchTree [] = Empty
> searchTree (x:xs) = insert (tree xs) x

% Insert a given value into our tree

> insert :: Tree a -> a -> Tree a
> insert Empty y = Node Empty y Empty
> insert (Node t x u) y
>   | y <= x = Node (insert y t) x u
>   | otherwise = Node t x (insert y u)

> createLeaf :: a -> Tree a
> createLeaf v = Node Empty v Empty