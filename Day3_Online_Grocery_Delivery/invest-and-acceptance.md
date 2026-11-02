# INVEST Review and Acceptance Criteria

## 1. INVEST checklist

INVEST means:
- **I – Independent:** The story can be developed with minimal dependency on other stories.
- **N – Negotiable:** Details can be discussed; the story is not a fixed technical contract.
- **V – Valuable:** It provides value to a user or stakeholder.
- **E – Estimable:** The team can estimate the work.
- **S – Small:** It is small enough to complete within a Sprint.
- **T – Testable:** The team can verify whether it works.

| Story | I | N | V | E | S | T | Review |
|---|---|---|---|---|---|---|---|
| GROC-01 View categories | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-02 View product details | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-03 Search by name | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-04 Filter by category | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-05 Add available product | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-06 Change cart quantity | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-07 Remove cart item | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-08 Review order amount | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-09 Choose delivery address | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-10 Receive confirmation | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-11 View order status | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |
| GROC-12 View delivery window | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | Pass |

The table records the team's review after the two oversized examples below were split into smaller, customer-visible outcomes. The stories are assumed to have basic product context and agreed acceptance criteria.

## 2. Two oversized stories and vertical rewrites

### Example A – Original story (too large)
"As a customer, I want the complete shopping experience, including browsing, searching, cart management, payment and delivery tracking, so that I can buy groceries online."

**Why it fails INVEST:** It combines many separate user outcomes, is too large to estimate reliably, and is difficult to test as one story.

**Vertical rewrites (customer-visible slices):**
1. As a customer, I want to view grocery categories so that I can find products by type. (GROC-01)
2. As a customer, I want to search for a product by name so that I can find it quickly. (GROC-03)
3. As a customer, I want to add an available product to my cart so that I can collect items for an order. (GROC-05)
4. As a customer, I want to review the item total and delivery fee so that I know the amount payable. (GROC-08)
5. As a customer, I want to view my order status so that I can follow its progress. (GROC-11)

These are vertical slices because each describes a user outcome, rather than splitting work into database, UI and API tasks.

### Example B – Original story (too large)
"As a customer, I want to manage all cart operations and checkout so that I can complete my purchase."

**Why it fails INVEST:** Adding items, changing quantities, removing items and reviewing the amount are separate behaviours. Combining them makes the story too broad.

**Vertical rewrites:**
1. GROC-05 – Add an available product to the cart.
2. GROC-06 – Change the quantity of a cart item.
3. GROC-07 – Remove an item from the cart.
4. GROC-08 – Review the amount before placing an order.

Each rewritten story can be discussed, estimated and tested separately.

## 3. Given / When / Then acceptance criteria for five stories

### GROC-01 – View grocery categories
- **Given** the customer opens the catalogue, **when** the catalogue loads, **then** the available grocery categories are displayed.
- **Given** the catalogue has no categories available, **when** the customer opens it, **then** a clear "No categories available" message is displayed.

### GROC-02 – View product details
- **Given** a product exists in the catalogue, **when** the customer selects it, **then** its name, price and availability are displayed.
- **Given** a product is unavailable, **when** the customer views its details, **then** the unavailable status is clearly shown.

### GROC-03 – Search by product name
- **Given** the catalogue contains matching products, **when** the customer enters a product name and searches, **then** matching products are displayed.
- **Given** no product matches the search text, **when** the customer searches, **then** a "No matching products found" message is displayed.

### GROC-05 – Add an available product to cart
- **Given** a product is available, **when** the customer selects Add to Cart, **then** the product is added and the cart count is updated.
- **Given** a product is unavailable, **when** the customer tries to add it, **then** the product is not added and an availability message is shown. **(Negative scenario.)**

### GROC-08 – Review order amount
- **Given** the cart contains items, **when** the customer opens the order summary, **then** the item total, delivery fee and final payable amount are shown.
- **Given** the cart is empty, **when** the customer opens the order summary, **then** the system shows an empty-cart message and does not show a misleading payable amount.
