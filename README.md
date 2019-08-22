# taRgrey

S25R + tarpitting + greylisting - a tarpit + greylisting policy server.

http://k2net.hakuba.jp/targrey/index.en.html

## Environment variables

- `TZ`: timezone used for logging, defaults to UTC

## Persistent volumes

- `/var/spool/postfix/postgrey`: greylist triplets - owner 100, group 101, mode 0770

## Network ports

- `10023/tcp`

## Usage

```shell
make run
```

## Stop

```shell
make clean
```

## Build

```shell
make build
```

## Build & run

```shell
make
```

## Debug image contents

```shell
make debug
```
