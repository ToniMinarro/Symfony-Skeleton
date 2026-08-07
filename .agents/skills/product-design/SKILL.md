---
name: product-design
description: Review and improve user-facing Minarro Labs interfaces for task clarity, visual hierarchy, consistency, responsiveness, accessibility and complete interaction states without gratuitous redesign.
---

# Product Design Review

Use for any meaningful user-facing screen, flow or component change.

## Design from the task outward

Start with the user's primary job, frequency, context and constraints. Identify
the primary action and make it the easiest thing to understand and perform.
Avoid designing from database entities or internal implementation language.

## Evaluate the complete experience

Review and improve:

- information architecture and domain terminology;
- visual hierarchy and primary/secondary action emphasis;
- navigation and number of decisions/clicks needed;
- density, spacing, alignment, typography and visual noise;
- reuse of existing components, tokens and interaction patterns;
- mobile/responsive layout and touch targets;
- semantic HTML, keyboard operation, visible focus and contrast;
- empty, loading, validation, error, success and disabled states;
- confirmation/undo/guardrails for destructive operations;
- feedback latency and perceived responsiveness.

## Design principles

- Prefer clarity over novelty.
- Prefer progressive disclosure over showing every option at once.
- Prefer a coherent existing pattern over a bespoke component.
- Improve obvious rough edges encountered in the changed flow when the fix is
  small and low-risk, but do not turn a focused ticket into a redesign project.
- Do not use colour alone to communicate status.
- Do not hide essential functionality behind hover-only interactions.
- Treat copy and labels as part of interface design.
- Avoid generic admin-table aesthetics when the workflow benefits from a more
  task-oriented presentation.

## Evidence

For significant visual changes, inspect the rendered result when tooling permits
and provide screenshots or equivalent evidence. Validate the critical flow at
at least one narrow/mobile and one normal desktop width when applicable.

## Output

Return only findings that improve the product. Categorize concrete problems as
blocker/important/optional when reviewing existing work. When implementing,
apply improvements directly and summarize the most meaningful design decisions.
