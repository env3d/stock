# stock

Yahoo finance no longer allow direct downloading of CSV historical data.

This script is a workaround.

It's meant to be deployed as a really basic CGI script.

Test it using the following:

```shell
$ QUERY_STRING=TSLA ./symbol.sh
```
