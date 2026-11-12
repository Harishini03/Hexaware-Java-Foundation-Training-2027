# Normalisation to Third Normal Form (3NF)

## Original spreadsheet
SKU, product name, category, supplier name, supplier phone, warehouse, quantity, reorder level.

The original sheet repeats category, supplier and warehouse details whenever multiple products or stock records are entered. For the design, one SKU identifies one product, and stock quantity/reorder level is specific to a SKU at a warehouse.

## Functional dependencies used
- `SKU -> product_name, category_id, supplier_id`
- `category_id -> category_name`
- `supplier_id -> supplier_name, supplier_phone`
- `warehouse_id -> warehouse_name, city`
- `(SKU, warehouse_id) -> quantity, reorder_level`

Assumption: each SKU has one default supplier and one category. A product may be stored at many warehouses. Reorder level is maintained per SKU per warehouse.

## First Normal Form (1NF)
Each cell contains one atomic value; there are no lists or repeating groups in a cell. Each inventory row represents one SKU at one warehouse. The composite key is (SKU, warehouse).

## Second Normal Form (2NF)
The inventory facts `quantity` and `reorder_level` depend on the complete composite key (SKU, warehouse_id), not only on SKU or warehouse_id. Product, supplier, category and warehouse details are kept in their own entity tables instead of being repeated in the inventory relation.

## Third Normal Form (3NF)
Non-key attributes depend on the key, the whole key and nothing but the key:
- Product name/category/supplier references are stored with SKU in PRODUCT.
- Category name depends on category_id, so it is stored in CATEGORY.
- Supplier name/phone depend on supplier_id, so they are stored in SUPPLIER.
- Warehouse name/city depend on warehouse_id, so they are stored in WAREHOUSE.
- Quantity/reorder level depend on the composite inventory key.

This removes transitive dependencies such as SKU -> supplier_id -> supplier_phone from PRODUCT.

## Anomalies in the original spreadsheet
1. **Insertion anomaly:** A new supplier or warehouse cannot be recorded unless a product/stock row is also entered.
2. **Update anomaly:** If a supplier phone number appears in many rows, every copy must be updated. Missing one row leaves conflicting phone numbers.
3. **Deletion anomaly:** Deleting the only product row associated with a supplier or category can accidentally remove the only stored details about that supplier or category.

## Final decomposition
- CATEGORY(category_id PK, category_name UNIQUE)
- SUPPLIER(supplier_id PK, supplier_name UNIQUE, supplier_phone)
- WAREHOUSE(warehouse_id PK, warehouse_name UNIQUE, city)
- PRODUCT(sku PK, product_name, category_id FK, supplier_id FK)
- INVENTORY(sku PK/FK, warehouse_id PK/FK, quantity, reorder_level)

The decomposition preserves the listed dependencies and uses foreign keys to maintain referential integrity.
