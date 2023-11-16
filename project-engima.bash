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
				# to shift through 3 letters, use this line for encryption:
				encrypted_content=$(cat "$user_input_filename" | tr "A-Z" "D-ZA-C")
				echo "$encrypted_content" >> "${user_input_filename}.enc"
				rm "$user_input_filename"
				echo "Success"
			else
				echo "File not found!"
			fi
			;;
		'4' )
			echo "Enter the filename:"
			read -r user_input_filename
			regex_filename="[a-zA-Z.]$"
			if [[ "$user_input_filename" =~ $regex_filename ]] && [ -e "$user_input_filename" ]; then
				# to shift through 3 letters, use this line for decryption:
				decrypted_content=$(cat "${user_input_filename}" | tr 'D-ZA-C' 'A-Z')	
				filename=$(basename $user_input_filename .enc)
				echo "$decrypted_content" >> "$filename"
				rm "${user_input_filename}"
				echo "Success"
			else
				echo "File not found!"
			fi
			;;
		* )
			echo -e "Invalid option!\n"
			;;
	esac
done