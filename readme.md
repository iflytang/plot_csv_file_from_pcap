### How to use

- step 1: 
use 'tshark' command to select interested columns of *.pcap, example as follows:

```
tshark -r eth0.pcap -T fields -e frame.number -e frame.time_relative -e frame.len -E separator=, > test_eth0.csv
```

- step2:
read *.csv file and plot as figure. And the parameter ```segment_len``` controls the bandwidth precision, just to adjust it as you need.
run in matlab:
```
# with one step, need to reload data every runtime
>> plot_csv_bandwidth
>> plot_csv_bandwidth

# with two steps: read_cvs_file and plot_csv_file
>> read_csv_file
>> plot_csv_file
>> plot_csv_file
```