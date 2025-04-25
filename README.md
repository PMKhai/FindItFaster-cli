# FindItFaster for Terminal

Advanced search tool for the terminal, similar to FindItFaster in VS Code.

## Requirements

Required tools (already installed on your machine):

- fzf: Fuzzy finder tool - [https://github.com/junegunn/fzf](https://github.com/junegunn/fzf)
- ripgrep (rg): Faster search tool than grep - [https://github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- bat: File display tool with syntax highlighting - [https://github.com/sharkdp/bat](https://github.com/sharkdp/bat)

## Installation

You can run the `finditfaster_setup.sh` script for a quick setup:

```bash
./finditfaster_setup.sh
```

This script will check for dependencies and add the necessary configuration to your `.zshrc`.

Alternatively, you can set it up manually:

1. The `finditfaster.sh` script file should be in your desired location.
2. Add the following line to your `~/.zshrc` file:

```bash
# Add FindItFaster
source /path/to/finditfaster.sh
```

Replace `/path/to/` with the full path to the directory containing the script file.

Example:

```bash
source ~/Documents/finditfaster.sh
```

1. Apply changes:

```bash
source ~/.zshrc
```

## Usage

### Available Commands

- `ff`: Find file by name
  - Open terminal and type `ff`
  - Use arrow keys to navigate, type to search
  - Enter to open the selected file in VS Code

- `fs <string>`: Find content within files
  - Can be used like: `fs "function search"` to find content
  - Or just type `fs` (without arguments) to find files by name (like the `ff` command)
  - When searching content: Displays all files containing the string
  - Enter to open the file at the line with the result

- `fp <pattern>`: Find file by pattern
  - Example: `fp "*.tsx"`
  - Displays all files matching the pattern
  - Enter to open the selected file

- `fd`: Find and change to directory
  - Type `fd`
  - Select a directory and press Enter to change to it

- `finditfaster_help`: Display usage instructions

## Shortcuts in fzf

- `Ctrl+K` / `Ctrl+J` or arrow keys: Move up/down
- `Enter`: Select the current item
- `Esc` / `Ctrl+C`: Exit
- `Ctrl+R`: Rotate display mode (for some commands)
- `?`: Show help

## Customization

You can edit the `finditfaster.sh` file to change options or add new commands.
