function [PLdata, PLVoIP, APDdata, APDVoIP, MPDdata, MPDVoIP, TT] = Sim4(lambda, C, f, P, n)
    % INPUT PARAMETERS:
    %  lambda - data packet rate (packets/sec)
    %  C      - link bandwidth (Mbps)
    %  f      - queue size (Bytes)
    %  P      - number of data packets (stopping criterium)
    %  n      - number of additional VoIP flows
    % OUTPUT PARAMETERS:
    %  PLdata  - packet loss of data packets (%)
    %  PLVoIP  - packet loss of VoIP packets (%)
    %  APDdata - average packet delay of data packets (milliseconds)
    %  APDVoIP - average packet delay of VoIP packets (milliseconds)
    %  MPDdata - maximum packet delay of data packets (milliseconds)
    %  MPDVoIP - maximum packet delay of VoIP packets (milliseconds)
    %  TT      - transmitted throughput (data + VoIP) (Mbps)

    % Events:
    ARRIVAL = 0;        % Arrival of a packet (data or VoIP)
    DEPARTURE = 1;      % Departure of a packet

    % State variables:
    STATE = 0;          % 0 - connection is free; 1 - connection is occupied
    QUEUEOCCUPATION = 0; % Occupation of the queue (in Bytes)
    QUEUE = [];         % Queue for storing packet size, arrival time, type (data/VoIP), and priority

    % Statistical Counters (for both data and VoIP):
    TOTALPACKETS_data = 0;
    LOSTPACKETS_data = 0;
    TRANSPACKETS_data = 0;
    TRANSBYTES_data = 0;
    DELAYS_data = 0;
    MAXDELAY_data = 0;

    TOTALPACKETS_VoIP = 0;
    LOSTPACKETS_VoIP = 0;
    TRANSPACKETS_VoIP = 0;
    TRANSBYTES_VoIP = 0;
    DELAYS_VoIP = 0;
    MAXDELAY_VoIP = 0;

    % Initializing the simulation clock:
    Clock = 0;
    data = 1;
    VoIP = 0;

    % Initialize the List of Events with the first ARRIVAL (data and VoIP):
    tmp_data = Clock + exprnd(1/lambda);
    EventList = [ARRIVAL, tmp_data, GeneratePacketSize(), tmp_data, data];
    for i = 1:n
        tmp_VoIP = Clock + (20 * rand() / 1000);
        EventList = [EventList; ARRIVAL, tmp_VoIP, GenerateVoIPPacketSize(), tmp_VoIP, VoIP];
    end

    % Simulation loop:
    while TRANSPACKETS_data + TRANSPACKETS_VoIP < P                % Stopping criterium for data packets
        EventList = sortrows(EventList, 2);    % Order EventList by time
        Event = EventList(1, 1);               % Get first event
        Clock = EventList(1, 2);               % and all
        PacketSize = EventList(1, 3);          % associated
        ArrInstant = EventList(1, 4);          % parameters.
        PacketType = EventList(1, 5);          % Packet type (data or VoIP)
        EventList(1, :) = [];                  % Eliminate first event
        
        switch Event
            case ARRIVAL    % If first event is an ARRIVAL
                if PacketType == data
                    TOTALPACKETS_data = TOTALPACKETS_data + 1;
                    tmp_data = Clock + exprnd(1/lambda); % Schedule next data packet arrival
                    EventList = [EventList; ARRIVAL, tmp_data, GeneratePacketSize(), tmp_data, data];
                else
                    TOTALPACKETS_VoIP = TOTALPACKETS_VoIP + 1;
                    tmp_VoIP = Clock + (16 + (24-16)*rand()) / 1000; % Uniformly distributed between 16 and 24 ms
                    EventList = [EventList; ARRIVAL, tmp_VoIP, GenerateVoIPPacketSize(), tmp_VoIP, VoIP];
                end

                if STATE == 0
                    STATE = 1;
                    EventList = [EventList; DEPARTURE, Clock + 8*PacketSize/(C*10^6), PacketSize, Clock, PacketType];
                else
                    if QUEUEOCCUPATION + PacketSize <= f
                        if PacketType == VoIP
                            QUEUE = [PacketSize, Clock, PacketType; QUEUE];  % Enqueue VoIP packet at the front
                        else
                            QUEUE = [QUEUE; PacketSize, Clock, PacketType];  % Enqueue data packet at the end
                        end
                        QUEUEOCCUPATION = QUEUEOCCUPATION + PacketSize;
                    else
                        if PacketType == data
                            LOSTPACKETS_data = LOSTPACKETS_data + 1;
                        else
                            LOSTPACKETS_VoIP = LOSTPACKETS_VoIP + 1;
                        end
                    end
                end

            case DEPARTURE    % If first event is a DEPARTURE
                if PacketType == data
                    TRANSPACKETS_data = TRANSPACKETS_data + 1;
                    TRANSBYTES_data = TRANSBYTES_data + PacketSize;
                    DELAYS_data = DELAYS_data + (Clock - ArrInstant);
                    if Clock - ArrInstant > MAXDELAY_data
                        MAXDELAY_data = Clock - ArrInstant;
                    end
                else
                    TRANSPACKETS_VoIP = TRANSPACKETS_VoIP + 1;
                    TRANSBYTES_VoIP = TRANSBYTES_VoIP + PacketSize;
                    DELAYS_VoIP = DELAYS_VoIP + (Clock - ArrInstant);
                    if Clock - ArrInstant > MAXDELAY_VoIP
                        MAXDELAY_VoIP = Clock - ArrInstant;
                    end
                end

                if QUEUEOCCUPATION > 0
                    % Serve the next packet in the queue (VoIP first)
                    EventList = [EventList; DEPARTURE, Clock + 8*QUEUE(1,1)/(C*10^6), QUEUE(1,1), QUEUE(1,2), QUEUE(1,3)];
                    QUEUEOCCUPATION = QUEUEOCCUPATION - QUEUE(1,1);
                    QUEUE(1,:) = [];
                else
                    STATE = 0;
                end
        end
    end

    % Performance parameters determination:
    PLdata = 100*LOSTPACKETS_data/TOTALPACKETS_data;  % Packet Loss for data
    PLVoIP = 100*LOSTPACKETS_VoIP/TOTALPACKETS_VoIP;  % Packet Loss for VoIP

    APDdata = 1000*DELAYS_data/TRANSPACKETS_data;    % Average Delay for data (ms)
    APDVoIP = 1000*DELAYS_VoIP/TRANSPACKETS_VoIP;    % Average Delay for VoIP (ms)

    MPDdata = 1000*MAXDELAY_data;                    % Maximum Delay for data (ms)
    MPDVoIP = 1000*MAXDELAY_VoIP;                    % Maximum Delay for VoIP (ms)

    TT = 1e-6*(TRANSBYTES_data + TRANSBYTES_VoIP)*8/Clock;   % Transmitted Throughput (Mbps)
end

function out = GeneratePacketSize()
    aux = rand();
    aux2 = [65:109 111:1517];
    if aux <= 0.19
        out = 64;
    elseif aux <= 0.19 + 0.23
        out = 110;
    elseif aux <= 0.19 + 0.23 + 0.17
        out = 1518;
    else
        out = aux2(randi(length(aux2)));
    end
end

function out = GenerateVoIPPacketSize()
    out = randi([110,130]);
end