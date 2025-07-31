# JJ (Just Jump)

Created by Desmond Ip

A lightweight directory bookmarking tool for quick terminal navigation.

## Description

`jj` is a simple shell utility that helps you quickly navigate between directories using custom hotkeys. Unlike automatic directory jumpers, `jj` gives you explicit control over your saved locations.

## Features

- Save current directory with custom hotkeys
- Jump to saved locations instantly
- Fuzzy search through saved locations
- Human-readable storage format
- Explicit control over saved locations

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

## Comparison with Zoxide

While [zoxide](https://github.com/ajeetdsouza/zoxide) is a powerful autojumper, `jj` takes a different approach:

### How They Work
- **jj**: Explicit bookmarking with custom hotkeys
- **zoxide**: Automatic learning based on directory visits

### Why Choose JJ Over Zoxide?

1. **Explicit Control**
   - No unwanted directories in your jump list
   - You decide what gets saved
   - No cleanup of unwanted entries needed

2. **Predictable Hotkeys**
   ```bash
   jj -s work ~/work
   jj work        # Always goes to ~/work
   ```
   - Hotkeys always map to the same location
   - No confusion with similar directory names
   - Better for muscle memory

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

## Installation

1. Download `jj.sh`
2. Add to your `.bashrc` or `.zshrc`:
```bash
source /path/to/jj.sh
```

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
