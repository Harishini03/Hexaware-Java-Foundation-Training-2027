# Day 11 – Sample Run

Illustrative inputs:
- Category: DOMESTIC
- Units: 150
- Late payment: true
- Online payment: true

## Calculation
- First 100 units × ₹1.50 = ₹150.00
- Next 50 units × ₹2.50 = ₹125.00
- Energy charge = ₹275.00
- Fixed domestic charge = ₹50.00
- Amount before adjustments = ₹325.00
- Late surcharge (5%) = ₹16.25
- Amount after surcharge = ₹341.25
- Online rebate (2%) = ₹6.825
- Final amount = ₹334.425, displayed to two decimal places as ₹334.43

## Illustrative console output
    ===== ELECTRICITY BILLING =====
    Category (DOMESTIC/COMMERCIAL/INDUSTRIAL): DOMESTIC
    Units consumed: 150
    Late payment? (true/false): true
    Online payment? (true/false): true

    ----------- BILL -----------
    Category          : DOMESTIC
    Units             : 150
    Energy charge     : Rs. 275.00
    Fixed charge      : Rs. 50.00
    Late surcharge    : Rs. 16.25
    Online rebate     : Rs. 6.83
    Final bill        : Rs. 334.43
    ----------------------------

The program then prints a 12-month statement and prompts for meter readings. Enter 0 to finish the do-while loop.

This is expected/example output, not proof of a local run. Capture your actual terminal output after compiling with JDK 25.
