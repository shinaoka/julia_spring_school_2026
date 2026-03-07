# AI Usage Policy For This Repository

This repository contains teaching materials. When a chapter or step provides a prompt for an AI assistant, the default pattern is to use two separate spells:

1. an execution spell
2. an explanation spell

The execution spell is short and action-oriented. The explanation spell is used immediately after that so the learner understands what happened.

## Student Assumptions

Assume the student:

- has just attended a lecture on Git and GitHub
- is roughly at the level of a senior undergraduate or first-year master's student
- has at least a little prior exposure to numerical computation

So the AI should not explain Git and GitHub from absolute zero every time, but it should still explain new Julia-specific ideas and computational concepts clearly.

## Standard Workflow

1. Copy the execution spell.
2. Paste it into the AI assistant.
3. Let the AI perform the requested action when possible.
4. Copy the explanation spell.
5. Ask the AI to explain what it just did, what changed, and how to verify the result.

## Spell Design

- Prefer short English spells.
- Keep the execution spell focused on one concrete task.
- Keep the explanation spell focused on understanding, not on doing new work.
- Do not mix execution and explanation into one long prompt unless there is a clear reason.
- If a step requires creating a project folder, prefer having the student create and enter the folder first, before using the execution spell.

## Canonical Example

Execution spell:

```text
Create a new Julia environment in the current working directory. Add BenchmarkTools and Plots as dependencies.
```

Explanation spell:

```text
Explain what you just did. Describe which files were created or updated, what each command or package operation means, whether the project environment or the global environment changed, and how I can verify the result.
```

## Required Behavior

- Do not treat the execution spell as black-box automation.
- After executing a task, always be ready to explain the concrete effects.
- When commands are involved, explain what each command does.
- When files are created or modified, name them explicitly and explain their roles.
- When environment state changes, explain which environment changed and how to verify it.
- Prefer understanding and reproducibility over speed.

## Tutorial-Specific Guidance

- If the learner is already inside the project directory, do not tell them to `git clone` unless the current step is explicitly about repository setup.
- In setup-oriented steps, explain the concrete effects on files such as `Project.toml` and `Manifest.toml`.
- In Julia environment setup, distinguish clearly between the project environment and the global environment.
- The explanation spell should cover what changed, why it changed, and how to confirm it locally.

## Writing Style

- The lecture notes are written in Japanese using the **である体** (da/dearu style), not the です/ます体 (desu/masu style).
- Do not mix styles. Use である, だ, する, ない consistently.
- Prompts (spells) given to AI assistants are also part of the lecture notes and should follow である体 in Japanese.

## Success Criterion

The learner should finish each AI-assisted step with both:

- the requested artifact or state change completed, and
- a clear understanding of what the AI did, what changed, and how to verify it.
