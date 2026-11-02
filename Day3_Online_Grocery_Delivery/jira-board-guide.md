# Jira Project and Board Setup Guide

## Suggested Jira project

- **Project name:** Online Grocery Delivery
- **Project type:** Scrum
- **Project key:** GROC
- **Board name:** Grocery Delivery Scrum Board
- **Issue types:** Epic and Story
- **Workflow columns:** To Do → In Progress → In Review → Done

## Epics to create

1. EPIC-1 – Browse and Search
2. EPIC-2 – Cart and Checkout
3. EPIC-3 – Delivery Tracking

Create the 12 stories from backlog.md and associate each story with its epic. Use the priority and story-point values in the backlog.

## Import the CSV

1. Open your Jira project and go to Issues or Jira settings → System → External system import → CSV (the exact menu can vary by Jira version and permissions).
2. Select jira_import.csv.
3. Map Summary, Issue Type, Description, Priority, Story Points, Epic Name and Epic Link to the matching Jira fields.
4. Import the three Epics first or use the import wizard's parent/epic mapping if it supports it.
5. Check that all 12 stories are linked to the correct epic and that story points and priorities are populated.
6. Open the Scrum board and configure the columns as To Do, In Progress, In Review and Done.
7. Add the DoD from dor-dod.md to the project description or a team documentation page.

## Sample board layout (prepared status view)

This is a suggested initial board layout. All items begin in To Do; no work is represented as already completed.

### To Do
- GROC-01 – View grocery categories (3, Must)
- GROC-02 – View product details (2, Must)
- GROC-03 – Search by product name (3, Must)
- GROC-04 – Filter products by category (5, Should)
- GROC-05 – Add available product to cart (3, Must)
- GROC-06 – Change cart quantity (5, Must)
- GROC-07 – Remove cart item (3, Must)
- GROC-08 – Review order amount (5, Must)
- GROC-09 – Choose delivery address (3, Must)
- GROC-10 – Receive order confirmation (5, Should)
- GROC-11 – View order status (2, Should)
- GROC-12 – View estimated delivery window (3, Could)

### In Progress
- None

### In Review
- None

### Done
- None

## Board export / screenshot

After the CSV is imported into your Jira workspace, take a screenshot of the board showing the columns and cards, or use Jira's available export option. Save that genuine Jira screenshot/export alongside this assignment. This repository contains the prepared CSV and board configuration guide, not a live Jira export.
