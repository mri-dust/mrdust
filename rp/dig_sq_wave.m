%% Define Red Pitaya as TCP/IP object

IP= '169.254.118.139';           % Input IP of your Red Pitaya...
port = 5000;
tcpipObj=tcpip(IP, port);

%% Open connection with your Red Pitaya

fopen(tcpipObj);
tcpipObj.Terminator = 'CR/LF';

%% Send SCPI command to Red Pitaya to turn ON LED1
% 
fprintf(tcpipObj, 'DIG:PIN:DIR OUT,DIO1_P');
% fprintf(tcpipObj, 'DIG:PIN:DIR OUT,DIO1_N');
% fprintf(tcpipObj,'DIG:PIN DIO1_N,1');
% fprintf(tcpipObj,'DIG:PIN LED1,1');
% pause(1)
% fprintf(tcpipObj,'DIG:PIN DIO1_N,0');





for c = 1:11
    fprintf(tcpipObj,'DIG:PIN DIO1_P,1');
    fprintf(tcpipObj,'DIG:PIN LED1,1');
    pause(0.00025)                       % Set time of output ON
    fprintf(tcpipObj,'DIG:PIN DIO1_P,0');
    fprintf(tcpipObj,'DIG:PIN LED1,0');
    pause(0.00025)

end

%% Close connection with Red Pitaya

fclose(tcpipObj);