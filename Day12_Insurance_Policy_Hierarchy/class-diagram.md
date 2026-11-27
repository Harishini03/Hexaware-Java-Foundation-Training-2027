# Class Diagram – Day 12

```text
                 PolicyReport (interface)
                         ^
                         |
                  Policy (abstract)
          --------------------------------
          - policyNumber : String
          - holder : String
          - status : PolicyStatus
          + calculatePremium() : double
          + printSummary() : void
                         ^
       _________________|________________________
      |          |             |                |
 MotorPolicy HealthPolicy  TravelPolicy      HomePolicy

PolicyStatus (enum)
DRAFT | ACTIVE | LAPSED | CANCELLED
```

## Design explanation
- **Inheritance:** Each concrete policy extends the abstract Policy class.
- **Runtime polymorphism:** A Policy array stores different subclass objects. Calling calculatePremium through the common reference executes the correct overridden formula.
- **Encapsulation:** Policy number and holder are private; the policy number is validated during construction.
- **Open/Closed Principle:** The Policy abstraction is open for extension. HomePolicy is introduced as a new subclass without editing existing policy classes.
- **Arrays:** The rectangular 2D array stores equal monthly columns; the jagged array supports different branch counts in each region.
