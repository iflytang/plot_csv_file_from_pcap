% @author: iflytang
% @date: 2018/11/21
% @Description: 1. convert selected column of *.pcap file into *.csv file
%                  with tshark
%               2. read *.csv file to plot bandwidth figure

clf;
clear all;
close all;

%%

file_name = 'equinix-chicago.dirA.20160406-125912.UTC.anon.csv';
row = 0;
col = 0;

lrow = row;
lcol = 0;
rrow = 10000000;
rcol = 1;
range = [lrow lcol rrow rcol];

% pkts_info = csvread(file_name, row, col, range);
pkts_info = csvread(file_name, row, col);

% ======== cal bandwidth =================
p_len = size(pkts_info,1);
segment = 1;
segment_len = 1;     % timescale uint, adjust it
segment_num = floor(pkts_info(p_len,1)/segment_len);
bandwidth = zeros(1, segment_num);
tmp_pkt_size = 0;
total_pkt_size = 0;
for i=1:p_len    
    if pkts_info(i,1) <= segment*segment_len
        tmp_pkt_size = tmp_pkt_size + pkts_info(i,2);
    else
        bandwidth(segment) = tmp_pkt_size * 8/segment_len;
        total_pkt_size = total_pkt_size + tmp_pkt_size;
        segment = segment + 1;
        tmp_pkt_size = 0;
    end
end
total_pkt_size = total_pkt_size + tmp_pkt_size;

bandwidth = bandwidth / 10e6;    % Mbps
total_pkt_size = roundn(total_pkt_size * 8 / (1024^3), -2);    % 小数点取2位，Gb

% =================== plot ============================
plot(bandwidth, '.-');
str1 = num2str(segment_len * 1000);
str2 = num2str(pkts_info(p_len,1));
str = ['timescale: ' , str1, 'ms / ', str2, 's'];
xlabel(str,  'fontsize', 10);
ylabel('bandwidth / Mbps', 'fontsize', 10);

str3 = num2str(total_pkt_size);
title_str = [' -- ', str3, 'Gb'];
title(strcat(file_name, title_str));

[max_band, max_index] = max(bandwidth);
fprintf('max_bandwidth is %.3f Mbps.\n', max_band);

%%