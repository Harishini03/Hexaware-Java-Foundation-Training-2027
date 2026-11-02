# MoSCoW Prioritisation and Planning Poker

## 1. MoSCoW method

- **Must have:** Essential for the first usable shopping journey.
- **Should have:** Important, but the first release can work without it.
- **Could have:** Helpful enhancement that can wait if time is limited.
- **Won't have this time:** Explicitly outside the current release scope.

The 12 backlog stories are prioritised in backlog.md. No story is marked Won't-have because all 12 are candidates for the product backlog; the Could-have story is not committed to the first release.

## 2. Planning Poker approach

Planning Poker is a team estimation activity. Each Developer selects a Fibonacci value independently, the team reveals estimates together, discusses differences, and agrees on a shared estimate. The values used here are **1, 2, 3, 5, 8 and 13**.

### Reference story

**GROC-02 – View product details = 2 points**

The team selects this as the reference story because it is a small, familiar outcome: display a product's name, price and availability. Other stories are compared with this baseline. Two points represent its relative effort and uncertainty, not two hours or two days.

### Example discussion and outlier

| Story | Initial votes (example) | Discussion | Agreed points |
|---|---|---|---:|
| GROC-02 View product details | 2, 2, 2 | Small, clear display behaviour; used as reference. | 2 |
| GROC-06 Change cart quantity | 3, 5, 8 | The 8-point vote raised stock-limit and recalculation concerns. The team clarified that this story updates quantity and validates available quantity; checkout remains separate. | 5 |

The 8-point estimate was the outlier. After clarifying the scope, the team agreed on 5. These are illustrative Planning Poker votes for this assignment, not actual votes from a live team.

## 3. Estimated backlog

| Story ID | Priority | Fibonacci points |
|---|---|---:|
| GROC-01 | Must | 3 |
| GROC-02 | Must | 2 |
| GROC-03 | Must | 3 |
| GROC-04 | Should | 5 |
| GROC-05 | Must | 3 |
| GROC-06 | Must | 5 |
| GROC-07 | Must | 3 |
| GROC-08 | Must | 5 |
| GROC-09 | Must | 3 |
| GROC-10 | Should | 5 |
| GROC-11 | Should | 2 |
| GROC-12 | Could | 3 |
| **Total** | | **42** |

Calculation: 3 + 2 + 3 + 5 + 3 + 5 + 3 + 5 + 3 + 5 + 2 + 3 = **42 story points**.

Story points express relative effort, complexity and uncertainty. They are not hours. The team's actual Sprint capacity should be used to decide how many stories to select; the full 42-point backlog is not assumed to fit into one Sprint.
