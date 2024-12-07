//Roan H. Jagunap BSCS 4B - AI | CCS 238 - Programming Languages | C++ (Compiled)

#include <iostream>
#include <string>
#include <unordered_map>
#include <chrono>  // For measuring execution time

using namespace std;

// Function to display title with a box
void displayTitle() {
    string title = "Mid Level Programming Language | C++ | Roman Numeral Modifier";
    int box_width = title.size() + 4;
    cout << "+" << string(box_width, '-') << "+\n";
    cout << "|  " << title << "  |\n";
    cout << "+" << string(box_width, '-') << "+\n";
}

// Function to convert integer to Roman numeral
string integerToRoman(int num) {
    int values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    string symbols[] = {"M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"};
    string roman;

    cout << "\nConverting " << num << " to Roman numeral:\n";
    for (int i = 0; i < 13; i++) {
        while (num >= values[i]) {
            cout << "Subtract " << values[i] << ", add '" << symbols[i] << "' to result\n";
            roman += symbols[i];
            num -= values[i];
        }
    }
    cout << "Final Roman numeral: " << roman << endl;
    return roman;
}

// Function to convert Roman numeral to integer
int romanToInteger(const string &roman) {
    unordered_map<char, int> roman_values = {{'I', 1}, {'V', 5}, {'X', 10}, {'L', 50}, {'C', 100}, {'D', 500}, {'M', 1000}};
    int total = 0, prev_value = 0;

    cout << "\nConverting " << roman << " to integer:\n";
    for (int i = roman.size() - 1; i >= 0; --i) {
        int value = roman_values[roman[i]];

        if (value < prev_value) {
            cout << "Found numeral '" << roman[i] << "', value: " << value << "\n";
            cout << "Subtract " << value << " because it's less than the previous value\n";
            total -= value;
        } else {
            cout << "Found numeral '" << roman[i] << "', value: " << value << "\n";
            cout << "Add " << value << endl;
            total += value;
        }

        prev_value = value;
    }
    cout << "Final integer value: " << total << endl;
    return total;
}

int main() {
    // Display the title with the box
    displayTitle();
    
    string user_name;
    cout << "What is your name? ";
    getline(cin, user_name);
    cout << "Hello, " << user_name << "! Welcome to the Enhanced Roman Numeral Modifier.\n";

    while (true) {
        string choice;
        cout << "\nWhat would you like to convert? Type '1' for integer to Roman numeral, '2' for Roman numeral to integer, or '3' for both conversions: ";
        cin >> choice;

        // Start measuring time
        auto start = chrono::high_resolution_clock::now();

        if (choice == "1") {
            int integer;
            cout << "\nEnter an integer: ";
            cin >> integer;
            string roman_numeral = integerToRoman(integer);
            cout << "\nThe integer " << integer << " was converted to Roman numeral: " << roman_numeral << endl;

        } else if (choice == "2") {
            string roman;
            cout << "\nEnter a Roman numeral: ";
            cin >> roman;
            int integer_value = romanToInteger(roman);
            cout << "\nThe Roman numeral '" << roman << "' was converted to integer: " << integer_value << endl;

        } else if (choice == "3") {
            int integer;
            cout << "\nEnter an integer: ";
            cin >> integer;

            // Convert integer to Roman numeral
            string roman_numeral = integerToRoman(integer);
            cout << "\nThe integer " << integer << " was converted to Roman numeral: " << roman_numeral << endl;

            // Convert the Roman numeral back to integer
            int integer_value = romanToInteger(roman_numeral);
            cout << "\nThe Roman numeral '" << roman_numeral << "' was converted back to integer: " << integer_value << endl;

        } else {
            cout << "\nInvalid choice. Please enter '1', '2', or '3'.\n";
            continue;
        }

        // End measuring time
        auto end = chrono::high_resolution_clock::now();
        chrono::duration<double> execution_time = end - start;
        cout << "\nExecution time: " << execution_time.count() << " seconds\n";

        string another_conversion;
        cout << "\nWould you like to convert another? Type 'yes' to continue or 'no' to exit: ";
        cin >> another_conversion;
        if (another_conversion != "yes") {
            cout << "\nThank you for using the Enhanced Roman Numeral Modifier, " << user_name << "! Goodbye and have a good day ahead.\n";
            break;
        }
    }

    return 0;
}
