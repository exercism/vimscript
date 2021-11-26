## SETUP

This track uses two tools to run the test suite and ensure best practices:

1. [vader.vim](https://github.com/junegunn/vader.vim)
2. [vint](https://github.com/Kuniwak/vint)

#### Running tests

1. put this in your `$HOME/.vimrc` file (needs to be done only once):

    ```vim
    " Test Plugin
    " (see: https://github.com/junegunn/vader.vim/#installation)
    call plug#begin()
    Plug 'junegunn/vader.vim'
    call plug#end()

    " Test Harness
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

1. Install the test plugin (needs to be done only once)
    ```
    :PlugInstall
    ```
1. Open your solution:
    ```
    $ vim exercise.vim
    ```
1. Run the tests:
    ```
    :Test
    ```

**Note**: Paths may vary. replace `exercise` with the actual exercise name. For example, when running the tests for the `hello-world` exercise you'd open the solution using:
```
$ vim hello-world.vim
```

If you want a convenient shortcut to the above 
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
