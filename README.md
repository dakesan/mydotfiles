# Dotfiles Management with chezmoi

This repository manages dotfiles using [chezmoi](https://www.chezmoi.io/).

## Initial Setup

### Install chezmoi

```bash
# macOS
brew install chezmoi

# Ubuntu/Debian
sudo apt update
sudo apt install -y chezmoi

# Ubuntu (snap)
sudo snap install chezmoi --classic

# Or install from binary (all Linux distributions)
sh -c "$(curl -fsLS get.chezmoi.io)"

# Other platforms: https://www.chezmoi.io/install/
```

### Initialize from this repository

```bash
# Clone and apply dotfiles
chezmoi init --apply https://github.com/dakesan/mydotfiles.git
```

### Configure machine-specific variables

Edit `~/.local/share/chezmoi/.chezmoidata.toml` to set machine-specific values:

```toml
# Machine-specific data for chezmoi templates
obsidian_vault_path = "~/Documents/YourVaultName"
```

## Daily Operations

### Check what would change

```bash
# Show differences between dotfiles and target files
chezmoi diff
```

### Apply changes

```bash
# Apply all pending changes
chezmoi apply

# Apply with verbose output
chezmoi apply -v
```

### Edit dotfiles

```bash
# Edit a file with your $EDITOR
chezmoi edit ~/.zshrc

# Edit and apply immediately
chezmoi edit --apply ~/.zshrc
```

### Add new files

```bash
# Add a file to chezmoi management
chezmoi add ~/.newconfig

# Add a file as private (600 permissions)
chezmoi add --template ~/.config/secret/config.yml
```

### Update from repository

```bash
# Pull latest changes and apply (recommended)
chezmoi update

# Or use chezmoi git wrapper
chezmoi git pull
chezmoi apply

# Or manually
cd ~/.local/share/chezmoi
git pull
chezmoi apply
```

### Push changes to repository

```bash
# Using chezmoi git wrapper (recommended)
chezmoi git status                    # Check status
chezmoi git add .                     # Stage changes
chezmoi git commit -m "Description"   # Commit changes
chezmoi git push                      # Push to remote

# Or manually navigate to source directory
cd ~/.local/share/chezmoi
git status
git add .
git commit -m "Description of changes"
git push
```

## File Structure

### Naming Conventions

- `dot_filename` → `.filename` in home directory
- `private_dot_filename` → `.filename` with 600 permissions
- `symlink_filename` → symlink management
- `executable_filename` → executable file
- `filename.tmpl` → template file (processed with Go templates)

### Template Variables

Templates use Go template syntax with variables from `.chezmoidata.toml`:

```lua
path = "{{ .obsidian_vault_path | default "~/Documents/notes" }}"
```

### Privacy Controls

`.chezmoiignore` specifies files excluded from Git tracking:

```
.codex/config.toml
.claude/commands/
.claude/skills/
.codex/AGENTS.md
```

These files are still managed by chezmoi locally but won't be committed to the repository.

## Key Files

- `.chezmoidata.toml` - Machine-specific template variables (not tracked in Git)
- `.chezmoiignore` - Files to exclude from Git tracking
- `dot_codex/private_config.base.toml` - Shared configuration template
- `private_dot_config/nvim/lua/personal.lua.tmpl` - nvim personal config template

## Advanced Operations

### Re-add all dotfiles

```bash
chezmoi re-add
```

### Verify configuration

```bash
# Show what chezmoi would do
chezmoi apply --dry-run --verbose
```

### Merge changes manually

```bash
# Open merge tool for conflicts
chezmoi merge ~/.zshrc
```

### Forget a file

```bash
# Remove a file from chezmoi management
chezmoi forget ~/.oldconfig
```

## Troubleshooting

### Check chezmoi status

```bash
chezmoi status
```

### View chezmoi-managed files

```bash
chezmoi managed
```

### Verify template rendering

```bash
# Show how a template would be rendered
chezmoi cat ~/.config/nvim/lua/personal.lua
```

### Reset to repository state

```bash
# WARNING: This will discard local changes
cd ~/.local/share/chezmoi
git reset --hard origin/main
chezmoi apply
```

## Migration from Symlink-based Dotfiles

If migrating from a traditional `~/dotfiles` directory:

1. Remove old symlinks:
   ```bash
   # Find and remove dotfile symlinks
   find ~ -maxdepth 1 -type l -exec ls -l {} \; | grep dotfiles
   ```

2. Add real files to chezmoi:
   ```bash
   chezmoi add ~/.zshrc ~/.bashrc ~/.config/nvim
   ```

3. Verify and apply:
   ```bash
   chezmoi diff
   chezmoi apply
   ```

## References

- [chezmoi Documentation](https://www.chezmoi.io/)
- [chezmoi Quick Start](https://www.chezmoi.io/quick-start/)
- [Template Guide](https://www.chezmoi.io/user-guide/templating/)
