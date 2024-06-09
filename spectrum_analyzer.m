clear;
clc;
close all;

platform = 'B210';
serial_number = '31E344A';
master_clock_rate = 60e6;
decimation_factor = 4;
center_frequency = 1500e6;
output_data_type = 'double';
gain = 40;
sample_per_frame = 1536;

current_signal_center_frequency = 1504e6;
bandwidth = 250e3;

rx = comm.SDRuReceiver( ...
    Platform = platform, ...
    SerialNum = serial_number,...
    MasterClockRate = master_clock_rate, ...
    DecimationFactor = decimation_factor,...
    CenterFrequency = center_frequency,...
    OutputDataType = output_data_type, ...
    SamplesPerFrame=sample_per_frame, ...
    Gain=gain);

sampleRate = rx.MasterClockRate/rx.DecimationFactor;
scope = spectrumAnalyzer( ...
    SampleRate = sampleRate , ...
    FrequencyOffset = center_frequency, ...
    Method="welch", ...
    AxesScaling = "manual");

file = get_shared_data_file();
file.Data(1) = current_signal_center_frequency;

interference_threshold = -5;
absent_threshold = -55;
start_frequency = 1494e6;
end_frequency = 1506e6;

while (true)
    data = rx();
    scope(data);
    spectrum_data = getSpectrumData(scope);
    is_available = check_spectrum(current_signal_center_frequency, bandwidth, spectrum_data.Spectrum{1, 1}, spectrum_data.FrequencyVector{1, 1}, interference_threshold);
    if is_available == false 
        current_signal_center_frequency = find_spectrum(bandwidth, start_frequency, end_frequency, spectrum_data.FrequencyVector{1, 1}, spectrum_data.Spectrum{1, 1}, absent_threshold);
        disp(current_signal_center_frequency);
        file.Data(1) = current_signal_center_frequency;
    end
end

release(rx);
release(scope);