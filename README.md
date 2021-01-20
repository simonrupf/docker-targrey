# taRgrey

S25R + tarpitting + greylisting - a tarpit + greylisting policy server.

> taRgrey is a patch that makes postgrey into a tarpitting policy server.
> Tarpitting means response delay for blocking spam.
> taRgrey is designed to decrease false positives.

-- http://k2net.hakuba.jp/targrey/index.en.html

> The concept of the Selective SMTP Rejection (S25R) anti-spam system, [...] is
> so simple that a mail server accepts SMTP accesses from mail relay servers
> but rejects direct SMTP accesses from end-user's computers.

-- http://www.gabacho-net.jp/en/anti-spam/anti-spam-system.html

## Software stack

Postgrey is written for Perl 5.

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
