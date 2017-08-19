# Exercism Vim script Track

![build status](https://travis-ci.org/exercism/vimscript.svg?branch=master)
[![Join the chat at https://gitter.im/exercism/vimscript](https://badges.gitter.im/exercism/vimscript.svg)](https://gitter.im/exercism/vimscript?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

We welcome any kind of contribution!

If you have a suggestion or question, create a new
[issue](https://github.com/exercism/vimscript/issues).

For code or fixing typos and similar things, open a
[pull request](https://github.com/exercism/vimscript/pulls).

Look at recent [commits](https://github.com/exercism/vimscript/commits/master)
to get a feeling on how to format your own ones.

Even if there are any uncertainties, go for it nevertheless. We can straighten
out everything in the process.

Thank you for contributing! :tada:

## Linting Vim files

If you add or change a Vim file, the CI will use vint to ensure best practices.
Therefore it's recommended idea to run it locally first, before creating a pull
request.

1. Install [vint](https://github.com/Kuniwak/vint#quick-start).
1. Recursively lint all Vim files:
    ```
    $ vint .
    ```

## Writing test files

#### Generating test files

Use the [generator](lib/generate.vim) to create Vader files from their canonical
test data:

```vim
" in Vim
:source lib/generate.vim
:Generate word-count
```

This would fetch the [canonical test data](https://raw.githubusercontent.com/exercism/x-common/master/exercises/word-count/canonical-data.json),
decode the JSON to Vim data types, iterate over the result, and put the tests in
a new unnamed buffer.

_This script requires Vim 7.4.1304+ for `json_decode()`. It also relies on the
netrw plugin (`:h netrw`), but that one is shipped and sourced by default._

#### Type mismatch exceptions

Older Vims don't like changing types for the same variable. If your tests use
global variables, `unlet!` them in a `Before` block at the top of the Vader file.

When each test uses `let expected = ...`, then put this at the top:

```vim
Before:
  unlet! expected
```

This is patched as of
[Vim 7.4.1546](https://github.com/vim/vim/commit/f6f32c38bf3319144a84a01a154c8c91939e7acf),
but we shouldn't assume versions in favor of compatibility.
