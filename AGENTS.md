# AGENTS.md

This document provides guidance for coding agents working on this macOS configuration repository.

## Repository Purpose

This repository contains scripts, dotfiles, and configuration for setting up and maintaining a reproducible macOS development environment. The goal is to quickly bootstrap a new Mac or recover from a clean install with minimal manual intervention.

**Current scope includes:**
- Initial macOS setup automation (hostname, shell configuration)
- Package management via Homebrew (CLI tools, GUI apps)
- Mac App Store apps via Mas
- Git configuration with XDG Base Directory compliance
- Shell configuration (zsh, tmux)

The repository is meant to be cloned and executed via `./install.sh` on a fresh macOS installation.

## Role of Coding Agents

Coding agents assist with:

- Adding new packages to `Brewfile` or `Masfile`
- Creating modular setup scripts for specific tools or workflows
- Refactoring existing scripts for maintainability
- Updating documentation and inline guidance
- Implementing system-level macOS preference changes

## Guidelines for Safe, Incremental Changes

1. **Test changes locally first** - Scripts modify system state; ensure they run idempotently
2. **Preserve user data** - Never delete existing configurations without clear warnings
3. **Keep scripts modular** - Each `setup-*.sh` should have a single, clear responsibility
4. **Document assumptions** - If a script requires specific macOS version or hardware, state it clearly
5. **Maintain XDG compliance** - Respect `XDG_CONFIG_HOME` and related directories where appropriate

## Commit Message Convention

All commits **MUST** follow the [Conventional Commits specification](https://www.conventionalcommits.org/en/v1.0.0/).

Non-conforming commit messages are not allowed.

### Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Valid Types

| Type | When to Use |
|------|-------------|
| `feat` | New feature or capability (e.g., adding a new setup script, supporting a new macOS version) |
| `fix` | Bug fix (e.g., correcting a broken script path, fixing a package install order) |
| `docs` | Documentation changes only (e.g., updating this file, improving script comments) |
| `chore` | Routine tasks that don't change functionality (e.g., updating formula versions, formatting) |
| `refactor` | Code restructuring without functional change (e.g., extracting functions, reorganizing files) |
| `test` | Adding or modifying tests (e.g., script validation, configuration checks) |
| `build` | Build system or external dependency changes (e.g., modifying `Brewfile` structure) |
| `ci` | CI/CD configuration changes |

### Example Commit Messages

```
feat: add Homebrew bootstrap script
fix: correct zsh path export order
docs: update macOS setup instructions
chore: update brew formula versions
refactor: reorganize dotfiles directory structure
test: add validation for setup script
build: adjust makefile for macOS Sonoma
ci: add commit message linting workflow
```

### Additional Notes

- Keep descriptions concise and imperative mood ("add" not "added" or "adds")
- Use scopes when relevant (e.g., `feat(brew):`, `fix(git):`)
- Include body or footer when context requires explanation or relates to issues
- Breaking changes should be indicated with `BREAKING CHANGE:` in the footer

## Documentation

For detailed information about repository structure, setup scripts, and post-installation steps, refer to **README.md**.