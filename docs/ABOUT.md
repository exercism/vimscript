## ABOUT

[Vim](http://www.vim.org) is a decades old text editor that is still wildly
popular among programmers and people who like working in terminal emulators.

In Vim, keys don't always do the same things. It depends in which mode you're
in. You constantly switch between modes, there is a mode for navigation, a mode
for insertion, a mode for selecting regions of text, a mode for entering
commands, and so on. This sounds complicated, but you quickly get used to it.

The biggest difference to other editors is Vim's modal interface. If you use
Vim, you don't use complicated shortcuts, you speak a language.

E.g. when you hit `d` in normal mode, you initiate a delete action. Then you
have to choose the region to act upon. E.g. `dw` deletes until the end of the
current word. `dd` deletes the current line. If the cursor is anywhere in a
double quote, you can use `ci"` to change this quote.

You reduce the risk of
[carpal tunnel syndrome](https://en.wikipedia.org/wiki/Carpal_tunnel_syndrome)
by not hitting several keys at once, but but pressing single keys in sequence.

For convenience, often used keys at put on the homerow or near it, so you don't
have to move your hands back and forth all the time.

Yes, there's a lot to learn at first, but when you get it, you can edit text
faster and more precisely than with most other editors. There is a reason people
are still using Vim!

Vim has its own scripting language built in. It's called `Vimscript`, or `Vim
script`, or `VimL`, depending on who you ask. It's a real programming language
and you also use it to configure Vim. The configuration file, called `vimrc`, is
merely a sequence of Vim commands, functions, and expressions.

This means Vim's configuration is
[Turing complete](https://en.wikipedia.org/wiki/Turing_completeness). You can
start small, add a few lines to it, then add more, and you'll end up with entire
plugins. There's nothing you can't do.

#### Bonus

Take it with a grain of salt, but there is an
[editor war](https://en.wikipedia.org/wiki/Editor_war) going on between Vim
and Emacs for a long time already. :-)
