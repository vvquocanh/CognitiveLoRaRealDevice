function center_frequency = find_spectrum(required_bandwidth, start_frequency, end_frequency, frequencies, powers, threshold)  
    beginning_index = 0;
    last_index = 0;
    current_bandwith = 0;
    for index = find_frequency_index(frequencies, start_frequency):find_frequency_index(frequencies, end_frequency)
        if powers(index) <= threshold
            if beginning_index == 0
                beginning_index = index;
            end
            if last_index == 0
                last_index = index;
            else
                last_index = last_index + 1;
            end
            current_bandwitdh = current_bandwith + frequencies(last_index) - frequencies(beginning_index);
            % disp(["Last index: " num2str(last_index)]);
            % disp(["Beginning index: " num2str(beginning_index)]);
            if current_bandwitdh > required_bandwidth
                center_frequency = (frequencies(beginning_index) + frequencies(last_index)) / 2;
                return;
            end
        else
            beginning_index = 0;
            last_index = 0;
            current_bandwith = 0;
        end
    end

    center_frequency = 0;
end