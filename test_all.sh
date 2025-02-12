#!/bin/bash

########
#
# test_all.sh
#
# SCRIPT TO CHECK YOUR ECM1410 WORKSHOP 05 SUBMISSION
#
# Please download and copy this file into the tests directory
#
# to test please run the following command in the CodeSpace terminal
#
# bash ./tests/test_all.sh
#
# NOTE: The actual test script will include some additional checks
#       but these should test most of the functionality in your 
#       submitted work works as expected and matches the expected output
#       Please run on your code and fix any mismatches.
#
# If you think there is a problem with the test please email
# p.lewis2@exeter.ac.uk 
# and please check the module announcements in your email/ELE 
# in case bug fixes or notable changes to the instructions are made
#           
########



read -r -d '' t01CopyArrayApp << EOM
original values: [1, 1, 2, 3, 4, 4]
unique values: [1, 2, 3, 4]
EOM

read -r -d '' t02PassByValueApp << EOM
After the method: red
       5
EOM

read -r -d '' t03StringFormatApp << EOM
name: Oscar                Age:  22 Height: 1.52m
My space height would be 155.5cm
On Mars I would be approximately 12 years old.
EOM

read -r -d '' t04AuthorApp << EOM
Author[name=Richard Osman,email=noone@nowhere.com,gender=m]
name is: Richard Osman
email is: osman@murderclub.com
gender is: m
EOM

read -r -d '' t06BookShopApp << EOM
Book[name=Data Mining Handbook,authors={Author[name=Robert Nisbet,email=,gender=u]},price=27.95,qty=10]
Book[name=Mastering COBOL,authors={Author[name=Roger Hutty,email=,gender=u]},price=4.95,qty=10]
Book[name=Intro to COBOL,authors={Author[name=Paul Murrill,email=,gender=u]},price=7.35,qty=4]
Book[name=Making Software,authors={Author[name=Andy Oram,email=,gender=u]},price=35.00,qty=5]
Book[name=OO Design Using Java,authors={Author[name=James Nino,email=,gender=u],Author[name=Frederick Hosch,email=,gender=u]},price=30.00,qty=6]
Book[name=Objects First with Java,authors={Author[name=David Barnes,email=,gender=u],Author[name=Michael Kolling,email=,gender=u]},price=29.50,qty=4]
| Data Mining Handbook    | Robert Nisbet                |  27.95 | 010 |
| Mastering COBOL         | Roger Hutty                  |   4.95 | 010 |
| Intro to COBOL          | Paul Murrill                 |   7.35 | 004 |
| Making Software         | Andy Oram                    |  35.00 | 005 |
| OO Design Using Java    | James Nino,Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes,Michael Kolling |  29.50 | 004 |
Search for term(s) 'making software' in title...
| Data Mining Handbook    | Robert Nisbet                |  27.95 | 010 |
| Mastering COBOL         | Roger Hutty                  |   4.95 | 010 |
| Intro to COBOL          | Paul Murrill                 |   7.35 | 004 |
| Making Software         | Andy Oram                    |  35.00 | 004 |
| OO Design Using Java    | James Nino,Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes,Michael Kolling |  29.50 | 004 |
Removing all books with term 'cobol' in title...
Removed 2 books
| Data Mining Handbook    | Robert Nisbet                |  27.95 | 010 |
| Making Software         | Andy Oram                    |  35.00 | 004 |
| OO Design Using Java    | James Nino,Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes,Michael Kolling |  29.50 | 004 |
EOM

# Iterate over all Java files in the directory
for java_file in *App.java; do
    # Compile the Java file
    javac "$java_file"
done

java CopyArrayApp 1 1 2 3 4 4 > ./tests/t01CopyArrayApp.out
java PassByValueApp | tail -n 1 > ./tests/t02PassByValueApp.out
java PassByValueApp | wc -l >> ./tests/t02PassByValueApp.out
java StringFormatApp Oscar 22 1.52 > ./tests/t03StringFormatApp.out
java AuthorApp > ./tests/t04AuthorApp.out
# java BookApp > ./tests/05_BookApp.out
java BookShopApp > ./tests/t06BookShopApp.out

for student in ./tests/*.out; do
    #t01CopyArrayApp=$(<./tests/t01CopyArrayApp.out)
    ref=$(basename $student)
    ref="${ref%.*}"
    var="$(diff -B -y --suppress-common-lines $student <(echo "${!ref}") | wc -l)"
    if [[ $var -eq 0 ]]; then
        echo "$student: PASS"
    else
        echo "$student: FAIL"
        diff -B $student <(echo "${!ref}")

    fi
done
