# Roan H. Jagunap | BSCS 4B - AI | CCS 238 - Programming Languages | Python (Interpreted)

import time  # Import the time module to measure execution time

# Function to display the title with a box around it
def display_title():
    title = "High Level Programming Language | Python | Roman Numeral Modifier"
    box_width = len(title) + 4
    print("+" + "-" * box_width + "+")
    print(f"|  {title}  |")
    print("+" + "-" * box_width + "+")

# Extended function to convert integer to Roman numeral, showing the steps on how it is converted
def integer_to_roman(num):
    val = [
        1000, 900, 500, 400,
        100, 90, 50, 40,
        10, 9, 5, 4,
        1
    ]
    syb = [
        "M", "CM", "D", "CD",
        "C", "XC", "L", "XL",
        "X", "IX", "V", "IV",
        "I"
    ]
    roman_num = ''
    print(f"\nConverting {num} to Roman numeral:")
    for i in range(len(val)):
        count = int(num / val[i])
        if count > 0:
            print(f"Subtract {val[i]}, add '{syb[i]}' to result {count} time(s)")
        roman_num += syb[i] * count
        num -= val[i] * count
    print(f"Final Roman numeral: {roman_num}")
    return roman_num

def roman_to_integer(roman):
    roman_values = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000}
    total = 0
    prev_value = 0

    print(f"\nConverting {roman} to integer:")

    # Iterate through the Roman numeral in reverse order
    for numeral in reversed(roman):
        value = roman_values[numeral]

        if value < prev_value:
            print(f"Found numeral '{numeral}', value: {value}")
            print(f"Subtract {value} because it's less than the previous value")
            total -= value
        else:
            print(f"Found numeral '{numeral}', value: {value}")
            print(f"Add {value}")
            total += value

        prev_value = value

    print(f"Final integer value: {total}")
    return total

def main():
    display_title()  # Display the title when the program starts

    user_name = input("What is your name? ")
    print(f"Hello, {user_name}! Welcome to the Enhanced Roman Numeral Modifier.")

    while True:
        # Start measuring time using perf_counter for high precision
        start_time = time.perf_counter()

        choice = input("\nWhat would you like to convert? Type '1' for integer to Roman numeral, '2' for Roman numeral to integer, or '3' for both conversions: ")

        if choice == '1':
            integer = int(input("\nEnter an integer: "))
            roman_numeral = integer_to_roman(integer)
            print(f"\nThe integer {integer} was converted to Roman numeral: {roman_numeral}")
        
        elif choice == '2':
            roman = input("\nEnter a Roman numeral: ").upper()
            integer_value = roman_to_integer(roman)
            print(f"\nThe Roman numeral '{roman}' was converted to integer: {integer_value}")

        elif choice == '3':
            integer = int(input("\nEnter an integer: "))
            
            # Convert integer to Roman numeral
            roman_numeral = integer_to_roman(integer)
            print(f"\nThe integer {integer} was converted to Roman numeral: {roman_numeral}")
            
            # Convert the generated Roman numeral back to integer
            integer_value = roman_to_integer(roman_numeral)
            print(f"\nThe Roman numeral '{roman_numeral}' was converted back to integer: {integer_value}")
        
        else:
            print("\nInvalid choice. Please enter '1', '2', or '3'.")

        # End measuring time using perf_counter
        end_time = time.perf_counter()
        execution_time = end_time - start_time
        print(f"\nExecution time: {execution_time:.9f} seconds")  # Prints up to 9 decimal places for higher precision

        another_conversion = input("\nWould you like to convert another? Type 'yes' to continue or 'no' to exit: ").lower()
        if another_conversion != 'yes':
            print(f"\nThank you for using the Enhanced Roman Numeral Modifier, {user_name}! Goodbye and have a good day ahead.")
            break

if __name__ == "__main__":
    main()
