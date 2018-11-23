clf;
clear all;
close all;

%% tsf

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