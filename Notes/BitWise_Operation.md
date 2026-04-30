Here's your cleaned-up Notion-ready version:

* * * * *

#### What are bitwise operations?

They work on **bits (0 and 1)** instead of full numbers. Operations happen bit by bit.

```
5 = 0101
3 = 0011

```

* * * * *

#### AND (`&`)

Output is `1` only when both bits are `1`, otherwise `0`. Keeps only the common `1` bits.

```
  0101  (5)
& 0011  (3)
------
  0001  → 1

```

#### OR (`|`)

Output is `1` when either bit is `1`. Combines bits from both sides.

```
  0101  (5)
| 0011  (3)
------
  0111  → 7

```

#### XOR (`^`)

Output is `1` when bits are different, `0` when they are the same. Highlights differences.

```
  0101  (5)
^ 0011  (3)
------
  0110  → 6

```

Two useful identities:

```
x ^ x = 0
x ^ 0 = x

```

#### NOT (`~`)

Flips every bit.

```
~ 0101 = 1010

```

* * * * *

#### Shift operators

**Left shift (`<<`)** --- shifts bits left, equivalent to multiplying by 2.

```
0011 (3) << 1 → 0110 (6)

```

**Right shift (`>>`)** --- shifts bits right, equivalent to dividing by 2.

```
0100 (4) >> 1 → 0010 (2)

```