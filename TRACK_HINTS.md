# TRACK HINTS

- [Intro](#intro)
- [Running tests](#running-tests)
- [Writing tests](#writing-tests)
- [Linting Vim files](#linting-vim-files)

## Intro

This track uses two tools to run the test suite and ensure best practices:

1. [vader.vim](https://github.com/junegunn/vader.vim)
2. [vint](https://github.com/Kuniwak/vint)

## Running tests

1. Install [vader.vim](https://github.com/junegunn/vader.vim/#installation).
1. Open your solution:
    ```
    $ vim exercise.vim
    ```
1. Source the current file to make its global functions available to Vim:
    ```
    :source %
    ```
1. Run the tests:
    ```
    :Vader exercise.vader
    ```

Paths may vary.

If you want a convenient shortcut to the above steps, put this in your vimrc:

```vim
function! s:exercism_tests()
  if expand('%:e') == 'vim'
    let testfile = printf('%s/%s.vader', expand('%:h'),
          \ tr(expand('%:h:t'), '-', '_'))
    if !filereadable(testfile)
      echoerr 'File does not exist: '. testfile
      return
    endif
    source %
    execute 'Vader' testfile
  else
    let sourcefile = printf('%s/%s.vim', expand('%:h'),
          \ tr(expand('%:h:t'), '-', '_'))
    if !filereadable(sourcefile)
      echoerr 'File does not exist: '. sourcefile
      return
    endif
    execute 'source' sourcefile
    Vader
  endif
endfunction

autocmd BufRead *.{vader,vim}
      \ command! -buffer Test call s:exercism_tests()
```

Afterwards open any `.vim` or `.vader` file from an exercise directory and run
the `:Test` command.

## Writing tests

#### Type mismatch exceptions

Older Vims don't like changing types for the same variable. If your tests use
global variables, unlet them in a `Before` block at the top of the Vader file.

When each test uses `let expected = ...`, then put this at the top:

```vim
Before:
  unlet! expected
```

This is patched as of
[Vim 7.4.1546](https://github.com/vim/vim/commit/f6f32c38bf3319144a84a01a154c8c91939e7acf),
but we shouldn't assume versions in favor of compatibility.

## Linting Vim files

1. Install [vint](https://github.com/Kuniwak/vint#quick-start).
1. Recursively lint all Vim files:
    ```
    $ vint .
    ```

For more detailed information about the Vim script track, please see the
[help page](http://exercism.io/languages/vimscript).
