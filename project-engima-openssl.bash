#!/usr/bin/bash
# write your code here
echo -e "Welcome to the Enigma!\n"
while true; do
	echo "0. Exit"
	echo "1. Create a file"
	echo "2. Read a file"
	echo "3. Encrypt a file"
	echo "4. Decrypt a file"
	echo "Enter an option:"
	read -r user_input_option
	case "$user_input_option" in
		'0')
			echo "See you later!"
			break
			;;
		'1')
			echo "Enter the filename:"
			read -r user_input_filename
			regex_filename="^[a-zA-Z.]+$"
			if [[ "$user_input_filename" =~ $regex_filename ]]; then
				echo "Enter a message:"
				read -r user_input_message
				regex_message="^[A-Z ]*$"
				if [[ "$user_input_message" =~ $regex_message ]]; then
					touch "$user_input_filename"
					echo "$user_input_message" >> "$user_input_filename"
					echo "The file was created successfully!"
				else
					echo "This is not a valid message!"
				fi		
			else
				echo "File name can contain letters and dots only!"
			fi
			;;
		'2')
			echo "Enter the filename:"
			read -r user_input_filename
			regex_filename="[a-zA-Z.]$"
			if [[ "$user_input_filename" =~ $regex_filename ]] && [ -e "$user_input_filename" ]; then
				echo "File content:"
				cat "$user_input_filename"
			else
				echo "File not found!"
			fi
			;;
		'3' )
			echo "Enter the filename:"
			read -r user_input_filename
			regex_filename="[a-zA-Z.]$"
			if [[ "$user_input_filename" =~ $regex_filename ]] && [ -e "$user_input_filename" ]; then
				echo "Enter password:"
				read -r user_input_password
				regex_filename="[a-zA-Z.]$"
				openssl enc -aes-256-cbc -e -pbkdf2 -nosalt -in "$user_input_filename" -out "${user_input_filename}.enc" -pass pass:"$user_input_password" &>/dev/null
				exit_code=$?
				if [[ $exit_code -eq 0 ]]; then
					echo "Success"
					rm "$user_input_filename"
				else
					echo "Fail"
				fi
			else
				echo "File not found!"
			fi
			;;
		'4' )
			echo "Enter the filename:"
			read -r user_input_filename
			regex_filename="[a-zA-Z.]$"
			if [[ "$user_input_filename" =~ $regex_filename ]] && [ -e "$user_input_filename" ]; then
				echo "Enter password:"
				read -r user_input_password
				regex_filename="[a-zA-Z.]$"
				filename=$(basename $user_input_filename .enc)
				openssl enc -aes-256-cbc -d -pbkdf2 -nosalt -in "$user_input_filename" -out "$filename" -pass pass:"$user_input_password" &>/dev/null
				exit_code=$?
				if [[ $exit_code -eq 0 ]]; then
					echo "Success"
					rm "${user_input_filename}"
				else
					echo "Fail"
				fi
			else
				echo "File not found!"
			fi
			;;
		* )
			echo -e "Invalid option!\n"
			;;
	esac
done