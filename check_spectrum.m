function is_available = check_spectrum(center_frequency, bandwidth, spectrum, frequency_vector, threshold)
    is_available = true;
    
    frequency_index = find_frequency_index(frequency_vector, center_frequency);
    
    left_pointer = frequency_index;
    right_pointer = frequency_index;
    
    while (frequency_vector(right_pointer) - frequency_vector(left_pointer)) < bandwidth
        if spectrum(left_pointer) > threshold || spectrum(right_pointer) > threshold
            is_available = false;
            return
        end
        if mod(right_pointer - left_pointer, 2) == 0
            left_pointer = left_pointer - 1;
        else
            right_pointer = right_pointer + 1;
        end
    end
end


