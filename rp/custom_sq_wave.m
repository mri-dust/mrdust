%% Define Red Pitaya as TCP/IP object
clc
clear all
close all
IP= '169.254.118.139';           % Input IP of your Red Pitaya...
port = 5000;
tcpipObj=tcpip(IP, port);

tcpipObj.InputBufferSize = 16384*64;
tcpipObj.OutputBufferSize = 16384*64;
flushinput(tcpipObj)
flushoutput(tcpipObj)

%% Open connection with your Red Pitaya and close previous
x=instrfind;
fclose(x);
fopen(tcpipObj);
tcpipObj.Terminator = 'CR/LF';

%% Calcualte arbitrary waveform with 16384 samples
% Values of arbitrary waveform must be in range from -1 to 1.
N=16383;
PULSE_WIDTH = N;

x=zeros(1,N+1);

for t = 1:N
    if mod(t, 2 * PULSE_WIDTH) < PULSE_WIDTH
        x(t) = 1;
    end
end
plot(x)
grid on

%% Convert waveforms to string with 5 decimal places accuracy
waveform_ch_1_0 =num2str(x,'%1.5f,');
% waveform_ch_2_0 =num2str(y,'%1.5f,');

% latest are empty spaces  “,”.
waveform_ch_1 =waveform_ch_1_0(1,1:length(waveform_ch_1_0)-3);
% waveform_ch_2 =waveform_ch_2_0(1,1:length(waveform_ch_2_0)-3);

%%

fprintf(tcpipObj,'GEN:RST');                     % Reset to default settings

fprintf(tcpipObj,'SOUR1:FUNC ARBITRARY');       % Set function of output signal
fprintf(tcpipObj,'SOUR2:FUNC ARBITRARY');       % {sine, square, triangle, sawu, sawd}

fprintf(tcpipObj,['SOUR1:TRAC:DATA:DATA ' waveform_ch_1])  % Send waveforms to Red Pitya
% fprintf(tcpipObj,['SOUR2:TRAC:DATA:DATA ' waveform_ch_2])

fprintf(tcpipObj,'SOUR1:VOLT 0.7');             % Set amplitude of output signal
% fprintf(tcpipObj,'SOUR2:VOLT 1');

fprintf(tcpipObj,'SOUR1:FREQ:FIX 4000');        % Set frequency of output signal
% fprintf(tcpipObj,'SOUR2:FREQ:FIX 4000');


fprintf(tcpipObj,'OUTPUT1:STATE ON');
% fprintf(tcpipObj,'OUTPUT2:STATE ON');

fclose(tcpipObj);