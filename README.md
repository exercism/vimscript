# Exercism Vim script Track

[![Configlet Status](https://github.com/exercism/vimscript/workflows/configlet/badge.svg)]
[![Exercise Test Status](https://github.com/exercism/vimscript/workflows/vimscript%20%2F%20main/badge.svg)]
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
