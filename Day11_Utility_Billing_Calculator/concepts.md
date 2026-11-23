# Day 11 – Beginner Concepts

## 1. Progressive electricity slabs
Each portion of the consumption uses its own rate. For 150 units:
- First 100 units cost 100 × ₹1.50 = ₹150.
- Remaining 50 units cost 50 × ₹2.50 = ₹125.
- Total energy charge = ₹275.

The program does not charge all 150 units at the second rate.

## 2. Switch expression
The switch expression selects the fixed charge:
- DOMESTIC returns ₹50.
- COMMERCIAL returns ₹150.
- INDUSTRIAL returns ₹300.

The arrow syntax is supported by modern Java.

## 3. Operators and precedence
In the expression below, multiplication is evaluated before addition:
    100 * RATE_FIRST_100 + (units - 100) * RATE_101_TO_200

Parentheses make the intended order easier to understand.

The conditional operator uses the form:
    condition ? valueWhenTrue : valueWhenFalse

The program uses it to calculate the surcharge and rebate.

## 4. Loops
- for loop: used for the 12 monthly statement because the number of repetitions is known.
- do-while loop: used for meter readings because the prompt must appear at least once. Enter 0 to stop.

## 5. Primitive casting

### Integer division
5 / 2 gives 2 when both operands are integers. The decimal part is lost.
Use (double) 5 / 2 to get 2.5.

### Integer overflow
An int can store values only up to 2,147,483,647. Adding 1 to Integer.MAX_VALUE overflows.
Use long when the required whole-number range is larger.

### double to int
Casting 125.75 to int gives 125. The fractional part is discarded, not rounded.
For money, use a proper rounding method rather than relying on a cast.

## 6. Assumptions
The assignment sheet lists the slab ranges but does not provide numerical rates or fixed charges. The sample tariff values in this program are practice assumptions, not official electricity tariffs.
