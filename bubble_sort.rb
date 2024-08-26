require 'pry'

def bubble_sort(array_of_numbers)
    array_length = array_of_numbers.length
    for i in 1..array_length
        for j in 0...array_length-1
            if array_of_numbers[j] <= array_of_numbers[j+1] 
                next
            else 
                temp_placeholder = array_of_numbers[j]
                array_of_numbers[j] = array_of_numbers[j+1]
                array_of_numbers[j+1] = temp_placeholder
            end
        end
    end
    p array_of_numbers
end



# Test Cases:
bubble_sort([0,1,2,3,4,5,6,7,8,9])
bubble_sort([27,2,10,5,1,1,2])
bubble_sort([3,2,1])
bubble_sort([45,54,54,1,2,3,3,3,4,121,3,0,12])

