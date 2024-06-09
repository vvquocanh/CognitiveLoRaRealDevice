function frequency_index = find_frequency_index(frequency_vector, center_frequency)
    frequency_index = 0;
    for index = 1 : length(frequency_vector)
        if frequency_vector(index) == center_frequency
            frequency_index = index;
            return
        elseif frequency_vector(index) > center_frequency
            if (frequency_vector(index) - center_frequency) < (center_frequency - frequency_vector(index - 1))
                frequency_index = index;
            else
                frequency_index = index - 1;
            end
            return;
        end
    end
end
