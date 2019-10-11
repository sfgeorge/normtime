#!/usr/bin/env bash

function normtime() {
  NORMTIME_VERSION=0.0.1.pre
  if [ --version == "$1" ]; then
    echo $NORMTIME_VERSION
    return
  fi

  awk -v time_offset="$2" -v date_pattern="([[:digit:]]{4})-([[:digit:]]{2})-([[:digit:]]{2}) ([[:digit:]]{2}):([[:digit:]]{2}):([[:digit:]]{2})[.]([[:digit:]]{3})" -v date_format='%Y-%m-%d %H:%M:%S' -v utc=1 '
    {
      match($0, date_pattern, matches)
      if (RLENGTH != -1)
      {
        original_unixtime=mktime(matches[1]" "matches[2]" "matches[3]" "matches[4]" "matches[5]" "matches[6], utc)
        ou=original_unixtime+("0."matches[7])
        normalized_unixtime=ou-time_offset
        new_time=strftime(date_format, normalized_unixtime, utc)
        nanoseconds=normalized_unixtime-int(normalized_unixtime)
        milliseconds_string=sprintf("%.3f", nanoseconds)
        split(milliseconds_string, milliparts, "[.]")
        milliseconds_int=milliparts[2]
        glue_time=new_time"."milliseconds_int

        sub(date_pattern, glue_time)
      }

      print
    }
  ' $1
}
