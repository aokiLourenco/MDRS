% Task 6
% In the previous Task 5, it was assumed that the link between the company router and its ISP
% does not introduce transmission/propagation errors (the typical case of a wired access network).
% In this Task 6, it is assumed that the link is provided by a wireless access network (for example,
% through a 4G/5G mobile network). In this case, when a packet reaches the company router with
% at least one error, the packet is discarded (recall the FCS field of IEEE 802 frames). So, packets
% can be lost in this system by two reasons: (i) they can be dropped in the input queue, or (ii) they
% can be discarded after being transmitted.

%---------------------------------
% 6.a. Develop Sim2 by changing the provided Sim1 to consider that the link introduces a BER
% (Bit Error Rate) given by b. The input parameters of Sim2 must be all the input parameters
% of Sim1 plus parameter b. The performance parameters estimated by Sim2 must be the
% same as the ones of Sim1. The stopping criterion of Sim2 must be time instant when the
% link finishes the transmission of the Pth packet without errors (i.e., the packets with errors do not count for the stopping criterion)

%---------------------------------
% 6.b. Develop a MATLAB script to run Sim2 100 times with a stopping criterion of P = 10000
% at each run and to compute the estimated values and the 90% confidence intervals of all
% performance parameters when  = 1800 pps, C = 10 Mbps, f = 1.000.000 Bytes and b = 10-6.
% Compare these results with the results of 5.b and take conclusions. 
% Results (recall that these are simulation results):
% PacketLoss (%) = 4.91e-01 +- 1.22e-02
% Av. Packet Delay (ms) = 4.34e+00 +- 1.23e-01
% Max. Packet Delay (ms) = 2.24e+01 +- 8.72e-01
% Throughput (Mbps) = 8.85e+00 +- 2.03e-02

lambda = 1800;
C = 10;
f = 1000000;
P = 10000;
b = 10^-6;
numRuns = 100;

PL_results = zeros(1, numRuns);
APD_results = zeros(1, numRuns);
MPD_results = zeros(1, numRuns);
TT_results = zeros(1, numRuns);

for i = 1:numRuns
    [PL, APD, MPD, TT] = Sim2(lambda, C, f, P, b);
    PL_results(i) = PL;
    APD_results(i) = APD;
    MPD_results(i) = MPD;
    TT_results(i) = TT;
end

% PL_mean = mean(PL_results);
% PL_std = std(PL_results);
% PL_CI = 1.96 * PL_std / sqrt(nRuns);

% APD_mean = mean(APD_results);
% APD_std = std(APD_results);
% APD_CI = 1.96 * APD_std / sqrt(nRuns);

% MPD_mean = mean(MPD_results);
% MPD_std = std(MPD_results);
% MPD_CI = 1.96 * MPD_std / sqrt(nRuns);

% TT_mean = mean(TT_results);
% TT_std = std(TT_results);
% TT_CI = 1.96 * TT_std / sqrt(nRuns);

% Calculate means
PL_mean = mean(PL_results);
APD_mean = mean(APD_results);
MPD_mean = mean(MPD_results);
TT_mean = mean(TT_results);

% 90% confidence interval z-score
z = 0.1; % z = 100(1-a)%

% Calculate confidence intervals
PL_ci = norminv(1-z/2)*sqrt(var(PL_results) / numRuns);
APD_ci = norminv(1-z/2)*sqrt(var(APD_results) / numRuns);
MPD_ci = norminv(1-z/2)*sqrt(var(MPD_results) / numRuns);
TT_ci = norminv(1-z/2)*sqrt(var(TT_results) / numRuns);

fprintf('\n------------ 6.b. ------------')
fprintf('\nPacketLoss (%%) = %.2e +- %.2e', PL_mean, PL_ci);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n', APD_mean, APD_ci);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n', MPD_mean, MPD_ci);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', TT_mean, TT_ci);

%%

% 6.c. Repeat the experiment 6.b but now consider f = 10.000 Bytes. Justify the differences
% between these results and the results of 5.d. Results (recall that these are simulation results):
% PacketLoss (%) = 1.49e+00 +- 3.68e-02
% Av. Packet Delay (ms) = 2.95e+00 +- 2.05e-02
% Max. Packet Delay (ms) = 8.97e+00 +- 1.76e-02
% Throughput (Mbps) = 8.68e+00 +- 1.45e-02

f = 10000;

PL_results = zeros(1, numRuns);
APD_results = zeros(1, numRuns);
MPD_results = zeros(1, numRuns);
TT_results = zeros(1, numRuns);

for i = 1:numRuns
    [PL, APD, MPD, TT] = Sim2(lambda, C, f, P, b);
    PL_results(i) = PL;
    APD_results(i) = APD;
    MPD_results(i) = MPD;
    TT_results(i) = TT;
end

% Calculate means
PL_mean = mean(PL_results);
APD_mean = mean(APD_results);
MPD_mean = mean(MPD_results);
TT_mean = mean(TT_results);

% Calculate confidence intervals
PL_ci = norminv(1-z/2)*sqrt(var(PL_results) / numRuns);
APD_ci = norminv(1-z/2)*sqrt(var(APD_results) / numRuns);
MPD_ci = norminv(1-z/2)*sqrt(var(MPD_results) / numRuns);
TT_ci = norminv(1-z/2)*sqrt(var(TT_results) / numRuns);

fprintf('\n------------ 6.c. ------------')
fprintf('\nPacketLoss (%%) = %.2e +- %.2e', PL_mean, PL_ci);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n', APD_mean, APD_ci);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n', MPD_mean, MPD_ci);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', TT_mean, TT_ci);

%%

% 6.d. Repeat the experiment 6.c but now consider f = 2.000 Bytes. Justify the differences
% between these results and the results of experiment 5.e. 
% Results (recall that these are simulation results):
% PacketLoss (%) = 1.08e+01 +- 5.83e-02
% Av. Packet Delay (ms) = 9.50e-01 +- 1.89e-03
% Max. Packet Delay (ms) = 2.70e+00 +- 7.42e-03
% Throughput (Mbps) = 7.04e+00 +- 1.10e-02

f = 2000;

PL_results = zeros(1, numRuns);
APD_results = zeros(1, numRuns);
MPD_results = zeros(1, numRuns);
TT_results = zeros(1, numRuns);

for i = 1:numRuns
    [PL, APD, MPD, TT] = Sim2(lambda, C, f, P, b);
    PL_results(i) = PL;
    APD_results(i) = APD;
    MPD_results(i) = MPD;
    TT_results(i) = TT;
end

% Calculate means
PL_mean = mean(PL_results);
APD_mean = mean(APD_results);
MPD_mean = mean(MPD_results);
TT_mean = mean(TT_results);

% Calculate confidence intervals
PL_ci = norminv(1-z/2)*sqrt(var(PL_results) / numRuns);
APD_ci = norminv(1-z/2)*sqrt(var(APD_results) / numRuns);
MPD_ci = norminv(1-z/2)*sqrt(var(MPD_results) / numRuns);
TT_ci = norminv(1-z/2)*sqrt(var(TT_results) / numRuns);

fprintf('\n------------ 6.d. ------------')
fprintf('\nPacketLoss (%%) = %.2e +- %.2e', PL_mean, PL_ci);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n', APD_mean, APD_ci);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n', MPD_mean, MPD_ci);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', TT_mean, TT_ci);

%%

% Task 7
% In Task 5, it was assumed that the link between the company router and its ISP supports a flow
% of data packets. In this task, consider that, besides the flow of data packets, the link also supports
% n VoIP (Voice over IP) packet flows. Each VoIP flow generates packets with size uniformly
% distributed between 110 Bytes and 130 Bytes, and the time between packet arrivals is uniformly
% distributed between 16 milliseconds and 24 milliseconds2.

% 7.a. Develop Sim3 by changing the provided Sim1 to consider the n additional VoIP packet flows3.
% Consider that packets of all flows (data and VoIP) are queued on a single queue served with a FIFO scheduling discipline. 
% The input parameters of Sim3 should be all the input parameters of Sim1 plus parameter n. 
% The performance parameters estimated by Sim3 should be:
% PLdata − Packet Loss of data packets (%)
% PLVoIP − Packet Loss of VoIP packets (%)
% APDdata − Average Delay of data packets (milliseconds)
% APDVoIP − Average Delay of VoIP packets (milliseconds)
% MPDdata − Maximum Delay of data packets (milliseconds)
% MPDVoIP − Maximum Delay of VoIP packets (milliseconds)
% TT − Transmitted Throughput (data + VoIP) (Mbps)

%---------------------------------

% 7.b. Develop a MATLAB script to run Sim3 100 times with a stopping criterion of P = 10000
% at each run and to compute the estimated values and the 90% confidence intervals of all
% performance parameters when  = 1800 pps, C = 10 Mbps, f = 1.000.000 Bytes (~1 MByte) and n = 20. 
% Results (recall that these are simulation results):
% PacketLoss of data (%) = 0.00e+00 +- 0.00e+00
% PacketLoss of VoIP (%) = 0.00e+00 +- 0.00e+00
% Av. Packet Delay of data (ms) = 2.03e+01 +- 1.94e+00
% Av. Packet Delay of VoIP (ms) = 1.99e+01 +- 1.95e+00
% Max. Packet Delay of data (ms) = 5.34e+01 +- 3.50e+00
% Max. Packet Delay of VoIP (ms) = 5.30e+01 +- 3.49e+00
% Throughput (Mbps) = 9.82e+00 +- 1.77e-02

lambda = 1800;
C = 10;
f = 1000000;
P = 10000;
n = 20;
numRuns = 100;

PLdata_results = zeros(1, numRuns);
PLVoIP_results = zeros(1, numRuns);
APDdata_results = zeros(1, numRuns);
APDVoIP_results = zeros(1, numRuns);
MPDdata_results = zeros(1, numRuns);
MPDVoIP_results = zeros(1, numRuns);
TT_results = zeros(1, numRuns);

for i = 1:numRuns
    [PLdata, PLVoIP, APDdata, APDVoIP, MPDdata, MPDVoIP, TT] = Sim3(lambda, C, f, P, n);
    PLdata_results(i) = PLdata;
    PLVoIP_results(i) = PLVoIP;
    APDdata_results(i) = APDdata;
    APDVoIP_results(i) = APDVoIP;
    MPDdata_results(i) = MPDdata;
    MPDVoIP_results(i) = MPDVoIP;
    TT_results(i) = TT;
end

% Calculate means
PLdata_mean = mean(PLdata_results);
PLVoIP_mean = mean(PLVoIP_results);
APDdata_mean = mean(APDdata_results);
APDVoIP_mean = mean(APDVoIP_results);
MPDdata_mean = mean(MPDdata_results);
MPDVoIP_mean = mean(MPDVoIP_results);
TT_mean = mean(TT_results);

% Calculate confidence intervals
PLdata_ci = norminv(1-z/2)*sqrt(var(PLdata_results) / numRuns);
PLVoIP_ci = norminv(1-z/2)*sqrt(var(PLVoIP_results) / numRuns);
APDdata_ci = norminv(1-z/2)*sqrt(var(APDdata_results) / numRuns);
APDVoIP_ci = norminv(1-z/2)*sqrt(var(APDVoIP_results) / numRuns);
MPDdata_ci = norminv(1-z/2)*sqrt(var(MPDdata_results) / numRuns);
MPDVoIP_ci = norminv(1-z/2)*sqrt(var(MPDVoIP_results) / numRuns);
TT_ci = norminv(1-z/2)*sqrt(var(TT_results) / numRuns);

fprintf('\n------------ 7.b. ------------')
fprintf('\nPacketLoss of data (%%) = %.2e +- %.2e', PLdata_mean, PLdata_ci);
fprintf('PacketLoss of VoIP (%%) = %.2e +- %.2e\n', PLVoIP_mean, PLVoIP_ci);
fprintf('Av. Packet Delay of data (ms) = %.2e +- %.2e\n', APDdata_mean, APDdata_ci);
fprintf('Av. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', APDVoIP_mean, APDVoIP_ci);
fprintf('Max. Packet Delay of data (ms) = %.2e +- %.2e\n', MPDdata_mean, MPDdata_ci);
fprintf('Max. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', MPDVoIP_mean, MPDVoIP_ci);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', TT_mean, TT_ci);

%%

% 7.c. Repeat the experiment 7.b but now consider f = 10.000 Bytes (~10 KBytes) Justify the
% differences between these results and the results of experiment 7.b. 
% Results (recall that these are simulation results):
% PacketLoss of data (%) = 2.62e+00 +- 8.52e-02
% PacketLoss of VoIP (%) = 3.63e-01 +- 2.27e-02
% Av. Packet Delay of data (ms) = 3.99e+00 +- 3.91e-02
% Av. Packet Delay of VoIP (ms) = 3.67e+00 +- 4.03e-02
% Max. Packet Delay of data (ms) = 9.01e+00 +- 1.27e-02
% Max. Packet Delay of VoIP (ms) = 8.78e+00 +- 1.87e-02
% Throughput (Mbps) = 9.42e+00 +- 1.60e-02

f = 10000;

PLdata_results = zeros(1, numRuns);
PLVoIP_results = zeros(1, numRuns);
APDdata_results = zeros(1, numRuns);
APDVoIP_results = zeros(1, numRuns);
MPDdata_results = zeros(1, numRuns);
MPDVoIP_results = zeros(1, numRuns);
TT_results = zeros(1, numRuns);

for i = 1:numRuns
    [PLdata, PLVoIP, APDdata, APDVoIP, MPDdata, MPDVoIP, TT] = Sim3(lambda, C, f, P, n);
    PLdata_results(i) = PLdata;
    PLVoIP_results(i) = PLVoIP;
    APDdata_results(i) = APDdata;
    APDVoIP_results(i) = APDVoIP;
    MPDdata_results(i) = MPDdata;
    MPDVoIP_results(i) = MPDVoIP;
    TT_results(i) = TT;
end

% Calculate means
PLdata_mean = mean(PLdata_results);
PLVoIP_mean = mean(PLVoIP_results);
APDdata_mean = mean(APDdata_results);
APDVoIP_mean = mean(APDVoIP_results);
MPDdata_mean = mean(MPDdata_results);
MPDVoIP_mean = mean(MPDVoIP_results);
TT_mean = mean(TT_results);

% Calculate confidence intervals
PLdata_ci = norminv(1-z/2)*sqrt(var(PLdata_results) / numRuns);
PLVoIP_ci = norminv(1-z/2)*sqrt(var(PLVoIP_results) / numRuns);
APDdata_ci = norminv(1-z/2)*sqrt(var(APDdata_results) / numRuns);
APDVoIP_ci = norminv(1-z/2)*sqrt(var(APDVoIP_results) / numRuns);
MPDdata_ci = norminv(1-z/2)*sqrt(var(MPDdata_results) / numRuns);
MPDVoIP_ci = norminv(1-z/2)*sqrt(var(MPDVoIP_results) / numRuns);
TT_ci = norminv(1-z/2)*sqrt(var(TT_results) / numRuns);

fprintf('\n------------ 7.c. ------------')
fprintf('\nPacketLoss of data (%%) = %.2e +- %.2e', PLdata_mean, PLdata_ci);
fprintf('PacketLoss of VoIP (%%) = %.2e +- %.2e\n', PLVoIP_mean, PLVoIP_ci);
fprintf('Av. Packet Delay of data (ms) = %.2e +- %.2e\n', APDdata_mean, APDdata_ci);
fprintf('Av. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', APDVoIP_mean, APDVoIP_ci);
fprintf('Max. Packet Delay of data (ms) = %.2e +- %.2e\n', MPDdata_mean, MPDdata_ci);
fprintf('Max. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', MPDVoIP_mean, MPDVoIP_ci);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', TT_mean, TT_ci);

%%

% 7.d. Repeat the experiment 7.c but now consider f = 2.000 Bytes (~2 KBytes) Justify the
% differences between these results and the results of experiment 7.b and 7.c. 
% Results (recall that these are simulation results):
% PacketLoss of data (%) = 1.26e+01 +- 7.96e-02
% PacketLoss of VoIP (%) = 1.97e+00 +- 4.20e-02
% Av. Packet Delay of data (ms) = 9.88e-01 +- 2.26e-03
% Av. Packet Delay of VoIP (ms) = 7.41e-01 +- 2.60e-03
% Max. Packet Delay of data (ms) = 2.71e+00 +- 7.36e-03
% Max. Packet Delay of VoIP (ms) = 2.59e+00 +- 1.14e-02
% Throughput (Mbps) = 7.74e+00 +- 1.23e-02

f = 2000;

PLdata_results = zeros(1, numRuns);
PLVoIP_results = zeros(1, numRuns);
APDdata_results = zeros(1, numRuns);
APDVoIP_results = zeros(1, numRuns);
MPDdata_results = zeros(1, numRuns);
MPDVoIP_results = zeros(1, numRuns);
TT_results = zeros(1, numRuns);

for i = 1:numRuns
    [PLdata, PLVoIP, APDdata, APDVoIP, MPDdata, MPDVoIP, TT] = Sim3(lambda, C, f, P, n);
    PLdata_results(i) = PLdata;
    PLVoIP_results(i) = PLVoIP;
    APDdata_results(i) = APDdata;
    APDVoIP_results(i) = APDVoIP;
    MPDdata_results(i) = MPDdata;
    MPDVoIP_results(i) = MPDVoIP;
    TT_results(i) = TT;
end

% Calculate means
PLdata_mean = mean(PLdata_results);
PLVoIP_mean = mean(PLVoIP_results);
APDdata_mean = mean(APDdata_results);
APDVoIP_mean = mean(APDVoIP_results);
MPDdata_mean = mean(MPDdata_results);
MPDVoIP_mean = mean(MPDVoIP_results);
TT_mean = mean(TT_results);

% Calculate confidence intervals
PLdata_ci = norminv(1-z/2)*sqrt(var(PLdata_results) / numRuns);
PLVoIP_ci = norminv(1-z/2)*sqrt(var(PLVoIP_results) / numRuns);
APDdata_ci = norminv(1-z/2)*sqrt(var(APDdata_results) / numRuns);
APDVoIP_ci = norminv(1-z/2)*sqrt(var(APDVoIP_results) / numRuns);
MPDdata_ci = norminv(1-z/2)*sqrt(var(MPDdata_results) / numRuns);
MPDVoIP_ci = norminv(1-z/2)*sqrt(var(MPDVoIP_results) / numRuns);
TT_ci = norminv(1-z/2)*sqrt(var(TT_results) / numRuns);

fprintf('\n------------ 7.d. ------------')
fprintf('\nPacketLoss of data (%%) = %.2e +- %.2e', PLdata_mean, PLdata_ci);
fprintf('PacketLoss of VoIP (%%) = %.2e +- %.2e\n', PLVoIP_mean, PLVoIP_ci);
fprintf('Av. Packet Delay of data (ms) = %.2e +- %.2e\n', APDdata_mean, APDdata_ci);
fprintf('Av. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', APDVoIP_mean, APDVoIP_ci);
fprintf('Max. Packet Delay of data (ms) = %.2e +- %.2e\n', MPDdata_mean, MPDdata_ci);
fprintf('Max. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', MPDVoIP_mean, MPDVoIP_ci);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', TT_mean, TT_ci);

%%

% 7.e. Develop Sim4 by changing Sim3 so that VoIP packets are given higher priority 
% than data packets in the queue. 

% Develop a MATLAB script to run Sim4 100 times with a stopping
% criterion of P = 10000 at each run and to compute the estimated values and the 90%
% confidence intervals of all performance parameters when  = 1800 pps, C = 10 Mbps, f =
% 1.000.000 Bytes (~1 MByte) and n = 20. 
% Compare these results with the results of 7.b andtake conclusions. 
% Results (recall that these are simulation results):
% PacketLoss of data (%) = 0.00e+00 +- 0.00e+00
% PacketLoss of VoIP (%) = 0.00e+00 +- 0.00e+00
% Av. Packet Delay of data (ms) = 2.35e+01 +- 2.34e+00
% Av. Packet Delay of VoIP (ms) = 5.59e-01 +- 1.39e-03
% Max. Packet Delay of data (ms) = 5.95e+01 +- 3.76e+00
% Max. Packet Delay of VoIP (ms) = 1.38e+00 +- 4.31e-03
% Throughput (Mbps) = 9.83e+00 +- 2.01e-02

lambda = 1800;
C = 10;
f = 1000000;
P = 10000;
n = 20;
numRuns = 100;

PLdata_results = zeros(1, numRuns);
PLVoIP_results = zeros(1, numRuns);
APDdata_results = zeros(1, numRuns);
APDVoIP_results = zeros(1, numRuns);
MPDdata_results = zeros(1, numRuns);
MPDVoIP_results = zeros(1, numRuns);
TT_results = zeros(1, numRuns);

for i = 1:numRuns
    [PLdata, PLVoIP, APDdata, APDVoIP, MPDdata, MPDVoIP, TT] = Sim4(lambda, C, f, P, n);
    PLdata_results(i) = PLdata;
    PLVoIP_results(i) = PLVoIP;
    APDdata_results(i) = APDdata;
    APDVoIP_results(i) = APDVoIP;
    MPDdata_results(i) = MPDdata;
    MPDVoIP_results(i) = MPDVoIP;
    TT_results(i) = TT;
end

% Calculate means
PLdata_mean = mean(PLdata_results);
PLVoIP_mean = mean(PLVoIP_results);
APDdata_mean = mean(APDdata_results);
APDVoIP_mean = mean(APDVoIP_results);
MPDdata_mean = mean(MPDdata_results);
MPDVoIP_mean = mean(MPDVoIP_results);
TT_mean = mean(TT_results);

% Calculate confidence intervals
PLdata_ci = norminv(1-z/2)*sqrt(var(PLdata_results) / numRuns);
PLVoIP_ci = norminv(1-z/2)*sqrt(var(PLVoIP_results) / numRuns);
APDdata_ci = norminv(1-z/2)*sqrt(var(APDdata_results) / numRuns);
APDVoIP_ci = norminv(1-z/2)*sqrt(var(APDVoIP_results) / numRuns);
MPDdata_ci = norminv(1-z/2)*sqrt(var(MPDdata_results) / numRuns);
MPDVoIP_ci = norminv(1-z/2)*sqrt(var(MPDVoIP_results) / numRuns);
TT_ci = norminv(1-z/2)*sqrt(var(TT_results) / numRuns);

fprintf('\n------------ 7.e. ------------')
fprintf('\nPacketLoss of data (%%) = %.2e +- %.2e', PLdata_mean, PLdata_ci);
fprintf('PacketLoss of VoIP (%%) = %.2e +- %.2e\n', PLVoIP_mean, PLVoIP_ci);
fprintf('Av. Packet Delay of data (ms) = %.2e +- %.2e\n', APDdata_mean, APDdata_ci);
fprintf('Av. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', APDVoIP_mean, APDVoIP_ci);
fprintf('Max. Packet Delay of data (ms) = %.2e +- %.2e\n', MPDdata_mean, MPDdata_ci);
fprintf('Max. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', MPDVoIP_mean, MPDVoIP_ci);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', TT_mean, TT_ci);

%%

% 7.f. Repeat the experiment 7.e but now consider f = 10.000 Bytes (~10 KBytes). Compare
% these results with the results of 7.c and take conclusions. 
% Results (recall that these are simulation results):
% PacketLoss of data (%) = 2.66e+00 +- 6.99e-02
% PacketLoss of VoIP (%) = 3.45e-01 +- 2.47e-02
% Av. Packet Delay of data (ms) = 4.36e+00 +- 3.71e-02
% Av. Packet Delay of VoIP (ms) = 5.34e-01 +- 1.61e-03
% Max. Packet Delay of data (ms) = 9.96e+00 +- 2.58e-02
% Max. Packet Delay of VoIP (ms) = 1.38e+00 +- 4.83e-03
% Throughput (Mbps) = 9.43e+00 +- 1.52e-02

f = 10000;

PLdata_results = zeros(1, numRuns);
PLVoIP_results = zeros(1, numRuns);
APDdata_results = zeros(1, numRuns);
APDVoIP_results = zeros(1, numRuns);
MPDdata_results = zeros(1, numRuns);
MPDVoIP_results = zeros(1, numRuns);
TT_results = zeros(1, numRuns);

for i = 1:numRuns
    [PLdata, PLVoIP, APDdata, APDVoIP, MPDdata, MPDVoIP, TT] = Sim4(lambda, C, f, P, n);
    PLdata_results(i) = PLdata;
    PLVoIP_results(i) = PLVoIP;
    APDdata_results(i) = APDdata;
    APDVoIP_results(i) = APDVoIP;
    MPDdata_results(i) = MPDdata;
    MPDVoIP_results(i) = MPDVoIP;
    TT_results(i) = TT;
end

% Calculate means
PLdata_mean = mean(PLdata_results);
PLVoIP_mean = mean(PLVoIP_results);
APDdata_mean = mean(APDdata_results);
APDVoIP_mean = mean(APDVoIP_results);
MPDdata_mean = mean(MPDdata_results);
MPDVoIP_mean = mean(MPDVoIP_results);
TT_mean = mean(TT_results);

% Calculate confidence intervals
PLdata_ci = norminv(1-z/2)*sqrt(var(PLdata_results) / numRuns);
PLVoIP_ci = norminv(1-z/2)*sqrt(var(PLVoIP_results) / numRuns);
APDdata_ci = norminv(1-z/2)*sqrt(var(APDdata_results) / numRuns);
APDVoIP_ci = norminv(1-z/2)*sqrt(var(APDVoIP_results) / numRuns);
MPDdata_ci = norminv(1-z/2)*sqrt(var(MPDdata_results) / numRuns);
MPDVoIP_ci = norminv(1-z/2)*sqrt(var(MPDVoIP_results) / numRuns);
TT_ci = norminv(1-z/2)*sqrt(var(TT_results) / numRuns);

fprintf('\n------------ 7.f. ------------')
fprintf('\nPacketLoss of data (%%) = %.2e +- %.2e', PLdata_mean, PLdata_ci);
fprintf('PacketLoss of VoIP (%%) = %.2e +- %.2e\n', PLVoIP_mean, PLVoIP_ci);
fprintf('Av. Packet Delay of data (ms) = %.2e +- %.2e\n', APDdata_mean, APDdata_ci);
fprintf('Av. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', APDVoIP_mean, APDVoIP_ci);
fprintf('Max. Packet Delay of data (ms) = %.2e +- %.2e\n', MPDdata_mean, MPDdata_ci);
fprintf('Max. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', MPDVoIP_mean, MPDVoIP_ci);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', TT_mean, TT_ci);

%%

% 7.g. Repeat the experiment 7.f but now consider f = 2.000 Bytes (~2 KBytes). Compare these
% results with the results of 7.d and take conclusions. 
% Results (recall that these are simulation results):
% PacketLoss of data (%) = 1.27e+01 +- 6.47e-02
% PacketLoss of VoIP (%) = 1.63e+00 +- 4.18e-02
% Av. Packet Delay of data (ms) = 1.04e+00 +- 2.24e-03
% Av. Packet Delay of VoIP (ms) = 4.34e-01 +- 1.14e-03
% Max. Packet Delay of data (ms) = 2.94e+00 +- 1.67e-02
% Max. Packet Delay of VoIP (ms) = 1.38e+00 +- 5.71e-03
% Throughput (Mbps) = 7.73e+00 +- 1.15e-02

f = 2000;

PLdata_results = zeros(1, numRuns);
PLVoIP_results = zeros(1, numRuns);
APDdata_results = zeros(1, numRuns);
APDVoIP_results = zeros(1, numRuns);
MPDdata_results = zeros(1, numRuns);
MPDVoIP_results = zeros(1, numRuns);
TT_results = zeros(1, numRuns);

for i = 1:numRuns
    [PLdata, PLVoIP, APDdata, APDVoIP, MPDdata, MPDVoIP, TT] = Sim4(lambda, C, f, P, n);
    PLdata_results(i) = PLdata;
    PLVoIP_results(i) = PLVoIP;
    APDdata_results(i) = APDdata;
    APDVoIP_results(i) = APDVoIP;
    MPDdata_results(i) = MPDdata;
    MPDVoIP_results(i) = MPDVoIP;
    TT_results(i) = TT;
end

% Calculate means
PLdata_mean = mean(PLdata_results);
PLVoIP_mean = mean(PLVoIP_results);
APDdata_mean = mean(APDdata_results);
APDVoIP_mean = mean(APDVoIP_results);
MPDdata_mean = mean(MPDdata_results);
MPDVoIP_mean = mean(MPDVoIP_results);
TT_mean = mean(TT_results);

% Calculate confidence intervals
PLdata_ci = norminv(1-z/2)*sqrt(var(PLdata_results) / numRuns);
PLVoIP_ci = norminv(1-z/2)*sqrt(var(PLVoIP_results) / numRuns);
APDdata_ci = norminv(1-z/2)*sqrt(var(APDdata_results) / numRuns);
APDVoIP_ci = norminv(1-z/2)*sqrt(var(APDVoIP_results) / numRuns);
MPDdata_ci = norminv(1-z/2)*sqrt(var(MPDdata_results) / numRuns);
MPDVoIP_ci = norminv(1-z/2)*sqrt(var(MPDVoIP_results) / numRuns);
TT_ci = norminv(1-z/2)*sqrt(var(TT_results) / numRuns);

fprintf('\n------------ 7.g. ------------')
fprintf('\nPacketLoss of data (%%) = %.2e +- %.2e', PLdata_mean, PLdata_ci);
fprintf('PacketLoss of VoIP (%%) = %.2e +- %.2e\n', PLVoIP_mean, PLVoIP_ci);
fprintf('Av. Packet Delay of data (ms) = %.2e +- %.2e\n', APDdata_mean, APDdata_ci);
fprintf('Av. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', APDVoIP_mean, APDVoIP_ci);
fprintf('Max. Packet Delay of data (ms) = %.2e +- %.2e\n', MPDdata_mean, MPDdata_ci);
fprintf('Max. Packet Delay of VoIP (ms) = %.2e +- %.2e\n', MPDVoIP_mean, MPDVoIP_ci);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', TT_mean, TT_ci);
