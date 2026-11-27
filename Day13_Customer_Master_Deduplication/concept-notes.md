# Day 13 – Concept Notes

## equals() and hashCode() contract
If two Customer objects are equal according to equals(), they must return the same hashCode(). HashSet uses the hash code to find a bucket and then equals() to check equality. Both methods therefore use the same normalised email field. Changing an object's equality field after inserting it into a hash-based collection can make lookup/removal unreliable.

## Class versus record
The Customer class manually defines equals(), hashCode() and toString(). CustomerRecord is a record: Java generates value-based implementations and accessors. Its compact constructor normalises email before the record is created. Record components are final, so their references cannot be reassigned after construction.

## String immutability and pool
String methods such as trim(), toLowerCase() and concat() return String values; they do not modify the original object. String literals can reuse an object from the string pool. The == operator checks whether references point to the same object, while equals() checks character content.

## StringBuilder and StringBuffer
- StringBuilder is mutable and generally faster for single-threaded string construction; it is not thread-safe.
- StringBuffer is mutable and synchronizes its methods, making its operations thread-safe but often slower.
- String is immutable and is useful when a value should not change.

## Interface types
- Notifier is a regular interface. Its default method provides inherited behavior; its static method is called through the interface name.
- Auditable is a marker interface: it has no methods and marks a class for a framework or application convention.
- CustomerValidator is a functional interface with one abstract method and can be implemented using a lambda expression.
