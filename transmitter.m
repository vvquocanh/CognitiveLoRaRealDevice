clear;
clc;
close all;

% Receiver
platform = "B210";
serial_number = "30AC2A3";

master_clock_rate = 60e6;
interpolation_factor = 4;
tx_gain = 60;

% LoRa Signal
bandwidth = 250e3;
spreading_factor = 7;
message = "Hello World!";
power = 0;
df = 0;

file = get_shared_data_file();
signal_transmitting_center_frequency = file.Data(1);

disp(signal_transmitting_center_frequency);

tx = comm.SDRuTransmitter(...
    Platform = platform, ...
    SerialNum = serial_number, ...
    ChannelMapping=1, ...
    MasterClockRate = master_clock_rate, ...
    InterpolationFactor=interpolation_factor,...
    CenterFrequency = signal_transmitting_center_frequency, ...
    Gain = tx_gain);

sampling_frequency = tx.MasterClockRate / tx.InterpolationFactor;

transmitted_signal = LoRa_Tx(message, bandwidth, spreading_factor, power, sampling_frequency, df);

while (true)
    tx(transmitted_signal);
    if (file.Data(1) ~= signal_transmitting_center_frequency)
        signal_transmitting_center_frequency = file.Data(1);
        release(tx);
        disp("New center frequency: ", num2str(signal_transmitting_center_frequency));
        tx.CenterFrequency = signal_transmitting_center_frequency;
    end
end

release(tx);