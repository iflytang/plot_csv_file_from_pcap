%% tsf
% ======== cal bandwidth =================
p_len = size(pkts_info,1);
segment = 1;
segment_len = 0.01;     % timescale uint, adjust it
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