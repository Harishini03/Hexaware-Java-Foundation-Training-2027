# Day 14 – Collection and Generics Notes

| Requirement | Collection / feature | Why it is used |
|---|---|---|
| SKU lookup and stock operations | HashMap | Fast average key-based lookup, update and removal |
| Product natural ordering | Comparable | Defines the default order on Product |
| Alternative product ordering | Comparator | Allows another order without changing Product |
| Last ten movements | ArrayDeque | Efficient insertion/removal at both ends |
| Reusable product/supplier storage | Repository<T extends InventoryEntity> | One type-safe repository works with different entity classes |
| Low-stock report | ArrayList | Stores matching products and can be sorted |

## Comparable versus Comparator
Comparable defines a class's natural ordering through compareTo(). Here products are ordered by category, then stock descending, then name. Comparator defines an external alternative order; the example sorts by product name without changing Product.

## HashMap ordering
HashMap does not promise iteration order. If predictable insertion order is required, LinkedHashMap can be used; if keys must remain sorted, TreeMap is appropriate.

## ArrayDeque
The activity log removes its oldest entry when it already contains ten entries, then appends the new movement. It therefore retains only the latest ten messages.

## Bounded generics
Repository<T extends InventoryEntity> accepts only types that implement InventoryEntity. This gives the repository access to getId() while retaining compile-time type safety.

## Wrapper classes
Autoboxing converts a primitive int to Integer; unboxing converts it back. Integer values in the commonly cached range (at least -128 to 127) may reuse instances. Do not compare wrapper values with ==; use equals() for value equality.
