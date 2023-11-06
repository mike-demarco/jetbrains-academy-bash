#!/usr/bin/env bash
# add your solution
touch operation_history.txt
echo 'Welcome to the basic calculator!' >> operation_history.txt
echo 'Enter an arithmetic operation or type 'quit' to quit:' >> operation_history.txt

arr_length="${#user_input[@]}"
value1="${user_input[0]}"
operation="${user_input[1]}"
value2="${user_input[2]}"

re_number="^[+-]?[0-9]*.?[0-9]*\s[\/\+\-\*\^]\s[-+]?[0-9]*.?[0-9]*$"

while true;
do
	read -a user_input >> operation_history.txt
	if [ "$arr_length" == "3" ] && [[ "$user_input" =~ $re_string ]]; then
		case "$operation" in
		 '+' )
			arithmetic_result=$(echo "scale=2; value1 + value2" | bc -l)
			printf "%s\n" "$arithmetic_result" >> operation_history.txt
			break
			;;
		 '-' )
			arithmetic_result=$(echo "scale=2; value1 - value2" | bc -l)
			printf "%s\n" "$arithmetic_result" >> operation_history.txt
			break
			;;
		 '*' )
			arithmetic_result=$(echo "scale=2; value1 * value2" | bc -l)
			printf "%s\n" "$arithmetic_result" >> operation_history.txt
			break
			;;
		 '/' )
			arithmetic_result=$(echo "scale=2; value1 / value2" | bc -l)
			printf "%s\n" "$arithmetic_result" >> operation_history.txt
			break
			;;
		 '^' )
			arithmetic_result=$(echo "scale=2; value1 ^ value2" | bc -l)
			printf "%s\n" "$arithmetic_result" >> operation_history.txt
			break
			;;
	elif [ "$line_number_input" = 'quit' ]; then
		echo 'Goodbye!' >> operation_history.txt
		break
	else
		echo "Operation check failed!" >> operation_history.txt
	fi
done