# Day 10 – Trigger Notes and Pitfalls

## 1. BEFORE vs AFTER

| BEFORE trigger | AFTER trigger |
|---|---|
| Runs before the row change is saved | Runs after the row change succeeds |
| Useful for validation or changing NEW values | Useful for audit records and related actions |
| Can reject the change with SIGNAL | Can record the successful change |
| Example: stop a price below cost | Example: write the old and new prices to price_audit |

## 2. OLD and NEW
- `OLD.selling_price` means the value before the update.
- `NEW.selling_price` means the value proposed by the update.
- In a BEFORE UPDATE trigger, the trigger can inspect both values and reject an invalid change.
- In an AFTER UPDATE trigger, the final saved values can be copied into an audit table.

## 3. Why does the trigger say FOR EACH ROW?
MySQL triggers are row-level. If one UPDATE changes five rows, the trigger runs five times—once for each affected row. MySQL does not provide statement-level triggers.

## 4. Two risks of triggers
1. **Hidden logic:** an UPDATE may look simple in application code, but a trigger can silently perform extra work. Developers may not know why another table changed.
2. **Cascading effects:** one trigger can write to another table and cause additional trigger activity, making debugging and performance harder.

## 5. When application code is better
Use application/service-layer logic when the rule needs several external checks, calls to another service, user-facing workflow, or complex business decisions. Application code is easier to test with normal unit tests and easier to observe. Keep a database constraint or trigger for rules that must be enforced for every database client.

## 6. Find triggers in the current schema
```sql
SELECT TRIGGER_NAME, EVENT_MANIPULATION, ACTION_TIMING, EVENT_OBJECT_TABLE
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = DATABASE();
```

## 7. Expected test interpretation
- A valid one-row update adds one audit row.
- A valid update affecting two products adds two audit rows.
- A below-cost update is rejected by the BEFORE trigger. The AFTER trigger does not run for that rejected row.
- InnoDB rolls back the failing statement, so valid rows in the same multi-row statement are not left partially updated if a trigger rejects one of those rows.

For submission, use screenshots from your own MySQL Workbench execution. The SQL file provides the test commands; it does not fabricate execution screenshots.
