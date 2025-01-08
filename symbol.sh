#!/bin/bash

# Yahoo finance no longer allow direct downloading of CSV historical data
# This script is a workaround

current_timestamp=$(date +%s)
one_year_ago_timestamp=$(date -d "1 year ago" +%s)

echo 'Content-type: text/plain'
echo

echo 'Date,Open,High,Low,Close,Adj Close,Volume'
curl -s "https://query1.finance.yahoo.com/v7/finance/chart/$QUERY_STRING?period1=$one_year_ago_timestamp&period2=$current_timestamp&interval=1d&events=history&includeAdjustedClose=true" | \
jq -r '
.chart.result[0]
| .timestamp as $timestamps
| .indicators.quote[0] as $quote
| .indicators.adjclose[0].adjclose as $adjclose
| [ $timestamps | map(todate), [$quote.volume[]], [$quote.high[]], [$quote.open[]], [$quote.low[]], [$quote.close[]], [$adjclose[]]]
| transpose[]
| @csv
' | \
tr -d '"'			 