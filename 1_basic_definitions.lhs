Question 1:

A function which takes an integer and returns its square:

> square::Integer -> Integer
> square x = x * x

For example:

    ghci> square 3
    9

Next, a function `larger` which returns the larger of two arguments:

> larger::(Integer, Integer) -> Integer
> larger(x,y) = if x > y then x else y

For example:

    ghci> larger(3,6)
    6

Finally, a function `area` which, given the radius of a circle, returns its area:

> area::Double -> Double
> area r = pi * r * r

For example:

    ghci> area 5
    78.53981633974483


Question 2:

Below I'll list function definitions, followed by their applicative- and normal-order reduction sequences.

1. first 42 (double (add 1 2))

A:
    first 42 (double (add 1 2))
    first 42 (double (1 + 2))
    first 42 (double (3))
    first 42 (3 + 3)
    first 42 6
    42
N:
    first 42 (double (add 1 2))
    42

2. first 42 (double (add 1 infinity))

A:
    first 42 (double (add 1 infinity))
    first 42 (double (add 1 infinity + 1))
    first 42 (double (add 1 infinity + 1 + 1))
    ...
    undefined
N:
    first 42 (double (add 1 infinity))
    42

3. first infinity (double (add 1 2))

A: // My answer here is wrong! First takes 2 arguments, so it's going to process both arguments before it evaluates first
   // It will probably expand infinity first, left-to-right, and will diverge.
    first infinity (double (add 1 2))
    first infinity (double (1 + 2))
    first infinity (double (3))
    first infinity (3 + 3)
    first infinity 6
    infinity + 1
    infinity + 1 + 1
    ...
    undefined
N:
    first infinity (double (add 1 2))
    infinity + 1
    infinity + 1 + 1
    ...
    undefined

4. add (cond True 42 (1 + infinity)) 4

A:
    add (cond True 42 (1 + infinity)) 4
    add (cond True 42 (1 + infinity + 1)) 4
    add (cond True 42 (1 + infinity + 1 + 1)) 4
    ...
    undefined
N:
    add (cond True 42 (1 + infinity)) 4
    cond True 42 (1 + infinity) + 4
    42

5. twice double (add 1 2)

A:
    twice double (add 1 2)
    twice double (1 + 2)
    twice double 3
    double 3 + double 3
    3 + 3 + 3 + 3
    12

N:
    twice double (add 1 2)
    double double (add 1 2)
    double (add 1 2) + double (add 1 2)
    add 1 2 + add 1 2 + add 1 2 + add 1 2
    1 + 2 + add 1 2 + add 1 2 + add 1 2
    1 + 2 + 1 + 2 + add 1 2 + add 1 2
    1 + 2 + 1 + 2 + 1 + 2 + add 1 2
    1 + 2 + 1 + 2 + 1 + 2 + 1 + 2
    12

6. twice (add 1) 0

A:
add (add 1) 0

N:
add (add 1) 0
add 1 + 0


Question 3:

Given the following function definition:

> fact::Integer -> Integer
> fact 0 = 1
> fact n = n * fact (n - 1)

A reduction sequence could be given as:

fact 3
3 * fact (3 - 1)
3 * fact 2
3 * 2 * fact (2 - 1)
3 * 2 * fact 1
3 * 2 * 1 * fact (1 - 1)
3 * 2 * 1 * fact 0
3 * 2 * 1 * 1
6

Notes:
- Plus (+) is a strict argument, meaning it won't evaluate until both sides of the expression have been reduced to values.
