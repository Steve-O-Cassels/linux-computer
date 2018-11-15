## Set default shell to zsh

Unknown

```
sudo code ~/.bashrc
```

## Syntax highlighting

```
# Syntax highlighting fails when tabbing on an incomplete command e.g. with:

➜  k8s-
➜  ~ _fizsh-expand-or-complete-and-highlight:2: command not found: _zsh_highlight_highlighter_brackets_paint
_fizsh-expand-or-complete-and-highlight:3: command not found: _zsh_highlight_highlighter_main_paint
_fizsh-expand-or-complete-and-highlight:4: command not found: _zsh_highlight_highlighter_cursor_paint
_fizsh-expand-or-complete-and-highlight:5: command not found: _zsh_highlight_highlighter_pattern_paint
_fizsh-expand-or-complete-and-highlight:6: command not found: _zsh_highlight_highlighter_root_paint
```

This is because the `zsh-syntax-highlighting` module is not installed; 

To fix it, you need to install this module within your `/home/<your-user>/.oh-my-zsh/plugins` folder as per the install instructions:

https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#in-your-zshrc

