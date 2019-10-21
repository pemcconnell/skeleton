skeleton
===

`foo` is a tool for ... It requires no internet connection to run, nor does it depend on any external libraries.

## install

`go get -u github.com/pemcconnell/foo`

Alternatively you can download a binary suited for your distribution and architecture via the [releases](releases) page.

## usage

In its simplest form you can just run `foo` and will print the result to stdout.

```sh
foo
```

## flags

You can view the flags at any time using `foo -h`.

If you would like to instruct `foo` to print results to a particular file you can run:

```sh
foo --out foo.json
# save output to foo.json. This is the same as running foo > foo.json, with some additional helper output
```

## development

### dependencies

- `something`
- `shell`

### build

```sh
./build.sh
```

### test

```sh
./test.sh
```

### clean

```sh
sh clean.sh
```

## contributing

All contributions welcome! Please check [CONTRIBUTING.md](CONTRIBUTING.md) for some guidance.
