# JJ (Just Jump)

Created by Desmond Ip

A lightweight directory bookmarking tool for quick terminal navigation. Just a single bash script with fzf for fuzzy finding.

## Description

`jj` is a simple shell utility that helps you quickly navigate between directories using custom hotkeys. It provides explicit bookmarking functionality with memorable shortcuts.

The entire utility is contained in a single bash script (`jj.sh`), making it easy to install, understand, and modify.

## Features

- Single file implementation - just one bash script
- Save current directory with custom hotkeys
- Jump to saved locations instantly
- Fuzzy search through saved locations
- Human-readable storage format
- Explicit control over saved locations
- No complex installation or setup

## Usage

```bash
jj -s <hotkey>     # Save current directory
jj <hotkey>        # Jump to saved location
jj -l             # List saved locations (with fuzzy finder)
jj -c             # Clear all saved locations
jj -h             # Show help
```

Example:
```bash
cd ~/projects/my-app
jj -s app         # Save location as 'app'
cd ~
jj app           # Jump back to ~/projects/my-app
```

## Key Benefits

1. **Explicit Bookmarking**
   - Create memorable shortcuts for your important directories
   - Custom hotkeys for frequently used locations
   - Clear mapping between shortcuts and directories

2. **Predictable Navigation**
   ```bash
   jj -s work ~/work
   jj work        # Always goes to ~/work
   ```
   - Shortcuts remain constant
   - Easy to remember hotkeys
   - Reliable navigation

3. **Simple Storage**
   ```bash
   # ~/.jj_locations
   work:/Users/username/work
   proj:/Users/username/projects
   ```
   - Human-readable format
   - Easy to backup or share
   - Version control friendly
   - Simple to transfer between machines

4. **Team Friendly**
   - Share standard locations across team
   - Everyone gets same shortcuts
   - Good for standardizing project navigation

5. **Simplicity**
   - Single bash script (~100 lines)
   - No compilation needed
   - Easy to audit
   - Easy to customize

## Installation

1. Download the single file `jj.sh`
2. Add to your `.bashrc` or `.zshrc`:
```bash
source /path/to/jj.sh
```

That's it! No compilation or package managers needed.

## Requirements

- fzf (for fuzzy finding)
- Unix-like environment (macOS, Linux)

## Storage

Locations are stored in `~/.jj_locations` in a simple format:
```
hotkey:path
```

## License

MIT
