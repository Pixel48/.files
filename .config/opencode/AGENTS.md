# OpenCode Agent Configuration Guidelines

This document provides comprehensive guidelines for developing, configuring, and maintaining agents in the OpenCode ecosystem. It ensures consistency across JSON configurations, agent files, and agent behaviors, promoting reliable and secure AI-assisted development workflows.

## Overview

OpenCode agents are specialized AI assistants designed for specific coding and development tasks. Each agent is defined in a Markdown file with YAML frontmatter specifying its capabilities, permissions, and behavior parameters. Agents operate within defined tool permissions to perform tasks safely and efficiently.

## Commands

### Linting and Formatting

Maintain code quality and consistency using these commands:

- **Lint JSON configs**: `prettier --check "**/*.json"` - Checks JSON formatting without modifying files
- **Format JSON configs**: `prettier --write "**/*.json"` - Automatically formats all JSON files
- **Lint agent files**: `markdownlint "agent/**/*.md"` - Validates Markdown syntax and style in agent files
- **Format agent files**: `markdownlint --fix "agent/**/*.md"` - Auto-fixes common Markdown issues
- **Check YAML syntax**: `yamllint agent/*.md` - Validates YAML frontmatter in agent files
- **Format YAML**: `yamlfmt agent/*.md` - Formats YAML frontmatter consistently

### Validation

Ensure configurations are correct and agents function properly:

- **Validate opencode.json**: Manual review against the schema at https://opencode.ai/config.json
- **Test agent configs**: Load and verify YAML frontmatter syntax in all agent files
- **Check agent syntax**: `opencode agent list` - Verifies all agents load correctly without errors
- **Run agent tests**: `opencode agent test <agent_name>` - Tests agent functionality with mock inputs
- **Validate tool permissions**: `opencode agent validate-permissions` - Ensures tool permissions are consistent

## Code Style Guidelines

### Agent Files

Agent files follow a strict structure for consistency and reliability:

- **Format**: Markdown with YAML frontmatter at the top
- **Naming**: Lowercase, descriptive names matching the file name (e.g., `write.md` for write agent)
- **Frontmatter Fields**:
  - `description`: Brief, clear description of the agent's purpose
  - `mode`: Agent mode (typically "subagent" for specialized agents)
  - `temperature`: Model temperature setting (0.0-1.0, lower for deterministic tasks)
  - `tools`: Boolean flags for available tools (edit, bash, todowrite, etc.)
  - `permission`: Permission levels for tools ("allow", "ask", "deny")
- **Content**: Detailed instructions following the frontmatter, written in second person ("You are a...")
- **Length**: Keep instructions concise but comprehensive, focusing on core responsibilities

### JSON Configurations

Main configuration files must follow these standards:

- **Indentation**: 2 spaces, no tabs
- **Quotes**: Double quotes for all strings
- **Commas**: Trailing commas allowed for easier maintenance
- **Structure**: Modular organization with clear key hierarchies
- **Comments**: Minimal inline comments; use self-documenting key names
- **Validation**: Always validate against the official schema

### Markdown Content

- **Headers**: Use proper hierarchy (H1 for titles, H2 for sections, etc.)
- **Lists**: Consistent bullet styles and indentation
- **Code Blocks**: Specify language for syntax highlighting
- **Links**: Use relative paths where possible, absolute URLs for external references

### Bash Permission Structure

Bash permissions in agent configurations MUST follow a strict structure to ensure security and maintainability. Always start with a default deny policy using `"*"`: `"deny"`, then organize specific command permissions by grouping related commands together. Within each category, list allowed commands first, followed by commands that require user confirmation (ask), then denied commands. For commands with subcommands, specify permissions hierarchically.

This structure provides:
- **Security**: Default deny ensures only explicitly permitted commands can be executed
- **Readability**: Grouping by tool or category makes permissions easier to review and maintain
- **Tool-based grouping**: Commands are organized logically by their purpose or tool (e.g., git commands, package managers, file operations)
- **Separation**: Add a blank line between categories for better readability

#### Required Structure

```yaml
permission:
  bash:
    "*": "deny"

    # Category 1
    "command1": "allow"
    "command1 something_dangerous_but_needed": "ask"
    "command2 ok": "allow"
    "command2 other_ok": "allow"
    "command2 other_ok danger_but_agent_needs": "ask"
    "command2 other_ok danger_subcmd": "deny"
    "command2 danger": "ask"
    "command2 big_no_no": "deny"

    # Category 2
    "command3": "allow"
    "command4": "ask"
    # ... additional categories as needed
```

When adding new bash permissions, always follow this exact pattern to maintain consistency across agent configurations. Commands must be grouped by category with blank lines separating groups, and a blank line after the default deny. Category comments should use the format "# Category Name" without brackets. As shown in the example above, within each category, list "allow" permissions first, followed by "ask" permissions, then "deny" permissions. For commands with subcommands, specify permissions hierarchically to provide granular control.

## File Organization

Maintain a clean, predictable project structure:

- **`agent/`**: Directory containing individual agent configuration files (.md)
  - Each agent has its own file (e.g., `write.md`, `test.md`)
  - Files are named after their primary function
- **`opencode.json`**: Main configuration file at the root level
  - Contains global settings, keybinds, and model configurations
- **`.gitignore`**: Excludes sensitive files, logs, and generated content
- **Documentation**: Keep related docs in appropriate locations (e.g., `.docs/` for generated docs)

### Agent Specialization

- **Single-purpose agents**: Focus on one primary task (e.g., `write.md` for documentation)
- **Combined agents**: Handle related functionalities (e.g., `review.md` for code review and critique)
- **Specialized agents**: Provide guidance (e.g., `recommend.md` for technology recommendations)
- **Utility agents**: Support development workflows (e.g., `config.md` for system configuration)

## Agent Behavior

Agents must follow these behavioral principles:

- **Permission Adherence**: Strictly respect tool permissions defined in YAML frontmatter
- **Safety First**: Avoid unsafe operations, data exposure, or system modifications without confirmation
- **Accuracy**: Generate up-to-date, accurate documentation and code
- **Tool Usage**: Use tools appropriately for file operations, searches, and edits
- **Convention Following**: Adhere to standard project organization (GitHub/GitLab patterns, conventional file locations)
- **User Interaction**: Ask for confirmation on potentially destructive actions
- **Documentation Standards**: Maintain clear, comprehensive, and current project documentation
- **Error Handling**: Gracefully handle errors and provide helpful feedback

## Organization-Specific Behaviors

Different agents have specialized behaviors based on their roles:

- **write**: Generates documentation files, uses `.docs` directory, adapts to repository type (GitHub/GitLab)
- **deploy**: Handles CI/CD configuration, detects platform (.github/workflows/ vs .gitlab-ci.yml)
- **test**: Organizes and manages tests in conventional locations (`test/`, `spec/`, `__tests__/`)
- **config**: Manages configuration files (`config/`, `.env`, `package.json`), ensures safe modifications
- **security**: Audits security-related files (`.env`, certificates, secrets), identifies vulnerabilities
- **recommend**: Provides technology, framework, and tooling recommendations based on project needs
- **research**: Researches and retrieves online documentation, provides information from web sources
- **optimize**: Analyzes code performance, suggests optimizations for efficiency and speed
- **debug**: Troubleshoots issues, analyzes logs and error messages
- **refactor**: Improves code structure without changing functionality
- **review**: Performs code reviews, provides feedback on quality and best practices
- **explain**: Clarifies code functionality, explains complex concepts
- **mentor**: Provides learning guidance and best practice recommendations

## Troubleshooting

### Common Issues and Solutions

- **Permission Denied Errors**:
  - Check YAML frontmatter permissions for the specific tool
  - Ensure the tool is enabled in the `tools` section
  - Verify permission level ("allow", "ask", "deny") matches the operation

- **Model Not Found**:
  - Verify model configuration in `opencode.json` matches available models
  - Check provider settings and API keys
  - Ensure model name is correctly spelled and formatted

- **Agent Not Responding**:
  - Validate YAML frontmatter syntax (use `yamllint`)
  - Check file naming matches agent expectations
  - Verify agent mode and temperature settings are valid

- **Tool Execution Failures**:
  - Confirm tool permissions allow the operation
  - Check for system-level permissions (e.g., file write access)
  - Review command syntax and parameters

- **Configuration Validation Errors**:
  - Run `opencode agent validate-permissions` to check consistency
  - Manually review `opencode.json` against the schema
  - Ensure all required fields are present in agent frontmatter

- **Performance Issues**:
  - Lower temperature settings for more deterministic responses
  - Check tool usage patterns for efficiency
  - Monitor for unnecessary tool calls

### Debugging Steps

1. Run `opencode agent list` to verify agent loading
2. Check YAML syntax with `yamllint agent/*.md`
3. Validate JSON with `prettier --check "**/*.json"`
4. Test individual agents with `opencode agent test <name>`
5. Review logs for specific error messages

## Examples

### Creating a New Agent

For a new agent focused on code refactoring:

```yaml
---
description: Agent that refactors code for improved structure and maintainability
mode: subagent
temperature: 0.1
tools:
  edit: true
  bash: false
  todowrite: true
  grep: true
  read: true
permission:
  edit: ask
  bash: deny
  todowrite: allow
  grep: allow
  read: allow
  webfetch: allow
---

You are a refactoring agent. Analyze code structure and suggest improvements for better maintainability, readability, and performance. Focus on SOLID principles, clean code practices, and modern language features. Always ask for confirmation before making changes. Use tools to search for patterns, read files, and propose edits. Avoid functional changes unless explicitly requested.
```

### Model Configuration in opencode.json

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "opencode/big-pickle",
  "provider": {
    "opencode": {
      "models": {
        "big-pickle": {
          "options": {
            "temperature": 0.1,
            "max_tokens": 4096
          }
        },
        "fast-model": {
          "options": {
            "temperature": 0.7,
            "max_tokens": 2048
          }
        }
      }
    }
  },
  "keybinds": {
    "leader": "ctrl+;",
    "app_exit": "ctrl+c,ctrl+d"
  }
}
```

### Agent with Multiple Permissions

Example of an agent with varied permission levels:

```yaml
---
description: Agent that handles deployment and CI/CD configuration
mode: subagent
temperature: 0.0
tools:
  edit: true
  bash: true
  todowrite: true
  webfetch: true
permission:
  edit: allow
  bash: ask
  todowrite: allow
  webfetch: allow
  grep: allow
---

You are a deployment agent. Configure CI/CD pipelines for GitHub Actions or GitLab CI. Detect the platform automatically and use appropriate configuration files. Ensure secure practices for secrets and environment variables. Test configurations before applying changes. Focus on reliable, automated deployment workflows.
```

### Best Practices

- Always test new agents with `opencode agent test` before deployment
- Use descriptive commit messages when updating agent configurations
- Document any custom tools or permissions in agent descriptions
- Regularly review and update agent permissions based on security requirements
- Maintain version control for all configuration changes