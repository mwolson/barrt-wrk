# barrt-wrk - wrk support for BARRT (A Bash Rspec-like Regression Test framework)

## Use it

Install these two modules from npm:

```sh
npm i --save barrt
npm i --save barrt-wrk
```

Edit the `setup.sh` file in your test suite to include the following:

```sh
#!/bin/bash

modules=$(dirname "$BASH_SOURCE")/node_modules

. "$modules"/barrt/setup.sh
. "$modules"/barrt-wrk/setup.sh

# other setup tasks...
```

Create a `runner.sh` file in your test suite with these contents:

```sh
#!/bin/bash

modules=$(dirname "$BASH_SOURCE")/node_modules

exec "$modules"/barrt/runner.sh
```

## API

The following are provided as bash functions:

### Performing a wrk request

`record_wrk $wrk_arguments...`

### Expectations

`expect_wrk_socket_errors`

### Utility

`inspect_next_wrk`

## License

MIT
