# 🔊 Bol

An [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh) plugin, that prints a random quote when you open a terminal.

![Screenshot](images/preview.png)

## How to install

1. Clone this repository in `oh-my-zsh` custom plugins directory:

```bash
git clone https://github.com/ikhurramraza/bol ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/bol
```

2. Add the plugin to the list of plugins inside `~/.zshrc`:

```bash

plugins=(bol)
```

3. Start a new terminal session.

## How to add your own favourites

Adding a quoute is as simple as adding a .txt file in the quotes directory.

A one liner would be:

```bash
echo "Code is like humor. If you have to explain it, it’s bad.\n—Cory House\n" > ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/bol/quotes/bad-code.txt
```

If you have a good quote that you would like to share with everyone, please open a PR. :)
