## normtime

_Normalize timestamps in log files to make them easier to diff._


## Requirements

*Linux*

* `coreutils` package for `date`
* `gawk` package for `awk`

*Mac OS X*

* Install [Homebrew](https://brew.sh) or your favored package manager.
* `brew install coreutils` in order to get `gdate`.


## Usage

### Step 1: Grab the first timestamp in your log

    head -n 5 my-logfile.log

> [`2019-10-09 15:34:02.471`] manager.c: HTTP Manager logged on from 192.168.1.3
> [2019-10-09 23:42:02.477] features.c: Setting call duration limit to 28800.000 seconds.
> [2019-10-09 23:42:02.478] app_dial.c: Called SIP/192.168.1.2/13124450947
> [2019-10-09 23:42:04.174] res_rtp_asterisk.c: 0x7fd1ac0091e0 -- Strict RTP learning complete
> [2019-10-09 23:42:13.204] dial.c: Local/15555555555@context-00000001;1 answered


### Step 2: Convert the first timestamp in your log to a unix epoch timestamp

_Note: On Mac OS X, use `gdate` instead of `date`._

    date -u -d '2019-10-09 15:34:02.471' +%s

> `1570635242`


### Step 3: Normalize!

    ./bin/normtime.sh my-logfile.log 1570635242 | head -n 5

> [1970-01-01 00:00:00.471] manager.c: HTTP Manager logged on from 192.168.1.3
> [1970-01-01 08:08:00.477] features.c: Setting call duration limit to 28800.000 seconds.
> [1970-01-01 08:08:00.478] app_dial.c: Called SIP/192.168.1.2/13124450947
> [1970-01-01 08:08:02.174] res_rtp_asterisk.c: 0x7fd1ac0091e0 -- Strict RTP learning complete
> [1970-01-01 08:08:11.204] dial.c: Local/15555555555@context-00000001;1 answered


## Contributing

Improvements and Issues are welcome!


## License

normtime is released under the [MIT License](http://www.opensource.org/licenses/MIT).
