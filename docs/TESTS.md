# SETUP

This track uses two tools to run the test suite and ensure best practices:

1. [vader.vim](https://github.com/junegunn/vader.vim)
2. [vint](https://github.com/Kuniwak/vint)

#### Running tests

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
    let testfile = printf('%s/%s.vader', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(testfile)
      echoerr 'File does not exist: '. testfile
      return
    endif
    source %
    execute 'Vader' testfile
  else
    let sourcefile = printf('%s/%s.vim', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
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

#### Linting Vim files

1. Install [vint](https://github.com/Kuniwak/vint#quick-start).
1. Recursively lint all Vim files:
    ```
    $ vint .
    ```

For more detailed information about the Vim script track, please see the
[help page](http://exercism.io/languages/vimscript).
