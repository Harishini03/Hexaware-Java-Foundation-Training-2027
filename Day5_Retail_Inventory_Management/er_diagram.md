# ER Diagram – Retail Inventory Management

```mermaid
erDiagram
    CATEGORY ||--o{ PRODUCT : classifies
    SUPPLIER ||--o{ PRODUCT : supplies
    PRODUCT ||--o{ INVENTORY : stocked_as
    WAREHOUSE ||--o{ INVENTORY : stores

    CATEGORY {
        INT category_id PK
        VARCHAR category_name UK
    }
    SUPPLIER {
        INT supplier_id PK
        VARCHAR supplier_name UK
        VARCHAR supplier_phone
    }
    WAREHOUSE {
        INT warehouse_id PK
        VARCHAR warehouse_name UK
        VARCHAR city
    }
    PRODUCT {
        VARCHAR sku PK
        VARCHAR product_name
        INT category_id FK
        INT supplier_id FK
    }
    INVENTORY {
        VARCHAR sku PK, FK
        INT warehouse_id PK, FK
        INT quantity
        INT reorder_level
    }
```

## Relationships
- One category can classify many products; each product belongs to one category.
- One supplier can supply many products; each product references one supplier.
- One product can have inventory records in multiple warehouses.
- One warehouse can store many products.
- `inventory` resolves the many-to-many relationship between products and warehouses. Its composite primary key is `(sku, warehouse_id)`.

## Keys
- Primary keys: `category_id`, `supplier_id`, `warehouse_id`, `sku`, and composite `(sku, warehouse_id)`.
- Foreign keys: `product.category_id`, `product.supplier_id`, `inventory.sku`, `inventory.warehouse_id`.
- Unique keys: category name, supplier name and warehouse name.
