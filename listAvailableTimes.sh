#!/usr/bin/env sh
set -u
set -e

baseURL="https://evisaforms.state.gov/"
barCode="${1}"
curlOptions="-s -c cookieJar -b cookieJar"

curl ${curlOptions} -o /dev/null "${baseURL}default.asp?PostCode=STK&CountryCode=SWDN++++++\&CountryCodeShow=&PostCodeShow=&Submit=Submit"

searchPattern="(?<=<div align=center><a href=).*?(?= title=\"Click on this hyperlink to book an appointment\">Available \(\d{1,2}\)</a></div>)"
curl ${curlOptions} "${baseURL}make_calendar.asp?nbarcode=${barCode}&pc=STK" |
grep -oP "${searchPattern}" |
while read subURL; do
    echo "${baseURL}${subURL}"
done


