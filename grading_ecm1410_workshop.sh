
#!/bin/bash

if ! aha -v 2>&1 >/dev/null
then
    aha=cat
fi

if [ "$1" == "save_to_md" ]; then 
   echo "## ECM1410 Workshop 5" > grading_report_workshop5.md
   echo "#### Result of grading script" >> grading_report_workshop5.md
   bash "${BASH_SOURCE[0]}" | aha |  tail -n +10 | sed '$d' | sed '$d'  >> grading_report_workshop5.md
   exit 0
fi

read -r -d '' BookAppPWL << EOM

public class BookAppPWL {
    public static void main(String[] args) {
        Author osman = new Author("Richard Osman", "noone@nowhere.com", 'm');
        Author armstrong = new Author("Alexander Armstrong", "armstrong@classicfm.com", 'm');
        Author[] authors = {osman, armstrong};
        Book pointless = new Book("The Pointless Book", authors, 13.99, 12);

        System.out.println(pointless); // Test toString()
        System.out.println("name: " + pointless.getName()); // Test getter
        System.out.println("author names: " + pointless.getAuthorNames()); // Test getter
        System.out.println("price: " + pointless.getPrice()); // Test getter
        pointless.setQty(0); // Test setter
        System.out.println("qty: " + pointless.getQty()); // Test getter
        Author[] myauthors = pointless.getAuthors();
        for (Author a : myauthors) {
            System.out.println(a);
        }
        System.out.println("getAuthors: " ); // Test getter
        pointless.setPrice(14.99); // Test setter
        System.out.println(pointless); // Test toString()

         // Declare and allocate an array of Authors
Author[] authors2 = new Author[2];
authors2[0] = new Author("Pip Jones", "pjones@java.org", 'u');
authors2[1] = new Author("Bessie Carter", "b.carter@java.org", 'f');
// Declare and allocate a Book instance
Book javaDummy = new Book("Java for Dummies", authors2, 19.99, 99);
System.out.println(javaDummy); // toString()
    }
}
EOM

read -r -d '' Author << EOM
public class Author {
    private String name;
    private String email;
    private char gender;
    public Author(String name, String email, char gender){
        this.name = name;
        this.email = "email"; // faked 
        this.gender = gender;
    }

    public String getName(){
        return this.name; 
    }

    public String getEmail(){
        return this.email;
    }

    public char getGender(){
        return this.gender;
    }

    public void setEmail(String email){
        this.email = "setEmail";
    }

    public String toString(){
        String result = String.format("Author[name=%s,email=%s,gender=%c]", 
        this.name, this.email, this.gender);
        return result;
    }
   
}
EOM

read -r -d '' Book2 << EOM
import java.util.stream.*;
public class Book {
    private String name;
    private Author[] authors;
    private double price;
    private int qty;
    
    public static String cbook = "Book NOT tested by BookApp";
    public static String cgetName = "getName NOT tested by BookApp";
    public static String cgetAuthors = "getAuthors NOT tested by BookApp";
    public static String cgetPrice = "getPrice NOT tested by BookApp";
    public static String csetPrice = "setPrice NOT tested by BookApp";
    public static String csetQty = "setQty NOT tested by BookApp";
    public static String cgetQty = "getQty NOT tested by BookApp";
    public static String ctoString = "toString NOT tested by BookApp";
    public static String cgetAuthorNames = "getAuthorNames NOT tested by BookApp";
    public static int[] cm = new int[9];
    public Book(String name, 
                  Author[] authors,
                  double price,
                  int qty){
        this.name = name;
        this.authors = authors;
        this.price = price;
        this.qty = qty;
        cbook = "Book TESTED_OK by BookApp";
	cm[0] = 1;
    reportmethods();
        }

    public Book(String name, 
                  Author[] authors,
                  double price){
        this(name, authors, price, 0);
        cbook = "Book TESTED_OK by BookApp";
	cm[0] = 1;
    reportmethods();
    }

    public String getName(){
        cgetName = "getName TESTED_OK by BookApp";
	cm[1] = 1;
    reportmethods();
        return this.name;
        
    }

    public Author[] getAuthors(){
        cgetAuthors = "getAuthors TESTED_OK by BookApp";
	cm[2] = 1;
    reportmethods();
        return this.authors;
    }

    public double getPrice(){
        cgetPrice = "getPrice TESTED_OK by BookApp";
	cm[3] = 1;
    reportmethods();
        return this.price;
    }

    public void setPrice(double newPrice){
        csetPrice = "setPrice TESTED_OK by BookApp";
	cm[4] = 1;
    reportmethods();
        this.price = newPrice;
    }

    public void setQty(int newQty){
        csetQty = "setQty TESTED_OK by BookApp";
	cm[5] = 1;
    reportmethods();
        this.qty = newQty;
    }

    public int getQty(){
        cgetQty = "getQty TESTED_OK by BookApp";
	cm[6] = 1;
    reportmethods();
        return this.qty;
    }

    public String toString(){
        ctoString = "toString TESTED_OK by BookApp";
	cm[7] = 1;
    reportmethods();
        String authorString="";
        for (int i = 0; i < this.authors.length; i++) {
            authorString += authors[i].toString();
            if (i<this.authors.length-1){
                authorString += ",";
            }
          }
        String result = String.format("Book[name=%s,authors={%s},price=%.2f,qty=%d]", 
        this.name, authorString, this.price, this.qty);
        return result;
    }
   
    public String getAuthorNames(){
        cgetAuthorNames = "getAuthorNames TESTED_OK by BookApp";
	cm[8] = 1;

        String authorNames="";
        for (int i = 0; i < this.authors.length; i++) {
            authorNames += authors[i].getName();
            if (i<this.authors.length-1){
                authorNames += ",";
            }
          }
          reportmethods();
        return authorNames;
    }

    public static void reportmethods(){
        System.out.println("METHODS CHECKED: " + IntStream.of(cm).sum() );
        /*
        System.out.println("Book.java calls:");
        System.out.println(cbook);
        System.out.println(cgetName);
        System.out.println(cgetAuthors);
        System.out.println(cgetPrice);
        System.out.println(csetPrice);
        System.out.println(csetQty);
        System.out.println(cgetQty);
        System.out.println(ctoString);
        System.out.println(cgetAuthorNames);
        */
        return;
    }
}
EOM

read -r -d '' Book << EOM
import java.util.stream.*;
public class Book {
    private String name;
    private Author[] authors;
    private double price;
    private int qty;
    
    public static String cbook = "Book NOT tested by BookApp";
    public static String cgetName = "getName NOT tested by BookApp";
    public static String cgetAuthors = "getAuthors NOT tested by BookApp";
    public static String cgetPrice = "getPrice NOT tested by BookApp";
    public static String csetPrice = "setPrice NOT tested by BookApp";
    public static String csetQty = "setQty NOT tested by BookApp";
    public static String cgetQty = "getQty NOT tested by BookApp";
    public static String ctoString = "toString NOT tested by BookApp";
    public static String cgetAuthorNames = "getAuthorNames NOT tested by BookApp";
    public static int[] cm = new int[9];
    public Book(String name, 
                  Author[] authors,
                  double price,
                  int qty){
        this.name = name;
        this.authors = authors;
        this.price = price;
        this.qty = qty;
        cbook = "Book TESTED_OK by BookApp";
	cm[0] = 1;
    reportmethods();
        }

    public Book(String name, 
                  Author[] authors,
                  double price){
        this(name, authors, price, 0);
        cbook = "Book TESTED_OK by BookApp";
	cm[0] = 1;
    reportmethods();
    }

    public String getName(){
        cgetName = "getName TESTED_OK by BookApp";
	cm[1] = 1;
    reportmethods();
        return this.name;
        
    }

    public Author[] getAuthors(){
        cgetAuthors = "getAuthors TESTED_OK by BookApp";
	cm[2] = 1;
    reportmethods();
        return this.authors;
    }

    public double getPrice(){
        cgetPrice = "getPrice TESTED_OK by BookApp";
	cm[3] = 1;
    reportmethods();
        return this.price;
    }

    public void setPrice(double newPrice){
        csetPrice = "setPrice TESTED_OK by BookApp";
	cm[4] = 1;
    reportmethods();
        this.price = newPrice;
    }

    public void setQty(int newQty){
        csetQty = "setQty TESTED_OK by BookApp";
	cm[5] = 1;
    reportmethods();
        this.qty = newQty;
    }

    public int getQty(){
        cgetQty = "getQty TESTED_OK by BookApp";
	cm[6] = 1;
    reportmethods();
        return this.qty;
    }

    public String toString(){
        ctoString = "toString TESTED_OK by BookApp";
	cm[7] = 1;
    reportmethods();
        String authorString="";
        for (int i = 0; i < this.authors.length; i++) {
            authorString += authors[i].toString();
            if (i<this.authors.length-1){
                authorString += ",";
            }
          }
        String result = String.format("Book[name=%s,authors={%s},price=%.2f,qty=%d]", 
        this.name, authorString, this.price, this.qty);
        return result;
    }
   
    public String getAuthorNames(){
        cgetAuthorNames = "getAuthorNames TESTED_OK by BookApp";
	cm[8] = 1;

        String authorNames="";
        for (int i = 0; i < this.authors.length; i++) {
            authorNames += authors[i].getName();
            if (i<this.authors.length-1){
                authorNames += ",";
            }
          }
          reportmethods();
        return authorNames;
    }

    public static void reportmethods(){
        return;
    }
}
EOM

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

read -r -d '' t05BookAppPWL << EOM
Book[name=The Pointless Book,authors={Author[name=Richard Osman,email=noone@nowhere.com,gender=m],Author[name=Alexander Armstrong,email=armstrong@classicfm.com,gender=m]},price=13.99,qty=12]
name: The Pointless Book
author names: Richard Osman,Alexander Armstrong
price: 13.99
qty: 0
Author[name=Richard Osman,email=noone@nowhere.com,gender=m]
Author[name=Alexander Armstrong,email=armstrong@classicfm.com,gender=m]
getAuthors: 
Book[name=The Pointless Book,authors={Author[name=Richard Osman,email=noone@nowhere.com,gender=m],Author[name=Alexander Armstrong,email=armstrong@classicfm.com,gender=m]},price=14.99,qty=0]
Book[name=Java for Dummies,authors={Author[name=Pip Jones,email=pjones@java.org,gender=u],Author[name=Bessie Carter,email=b.carter@java.org,gender=f]},price=19.99,qty=99]
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

read -r -d '' t11CopyArrayApp << EOM
original values: [4, 88, 19, 0, 0, 1, 6, 6, 2, 98, 2]
unique values: [4, 88, 19, 0, 1, 6, 2, 98]
EOM


read -r -d '' t13StringFormatApp << EOM
name: Neil                 Age:  43 Height: 1.77m
My space height would be 181.1cm
On Mars I would be approximately 23 years old.
EOM

read -r -d '' t14AuthorApp << EOM
Author[name=Richard Osman,email=email,gender=m]
name is: Richard Osman
email is: setEmail
gender is: m
EOM

read -r -d '' t15BookAppTest << EOM
BOOKAPP AT LEAST TESTED 6 BOOK METHODS
EOM

read -r -d '' t17BookAppTest << EOM
BOOKAPP TESTED 9 BOOK METHODS
EOM

read -r -d '' t16BookShopAppTest << EOM
Book[name=Data Mining Handbook,authors={Author[name=Robert Nisbet,email=email,gender=u]},price=27.95,qty=10]
Book[name=Mastering COBOL,authors={Author[name=Roger Hutty,email=email,gender=u]},price=4.95,qty=10]
Book[name=Intro to COBOL,authors={Author[name=Paul Murrill,email=email,gender=u]},price=7.35,qty=4]
Book[name=Making Software,authors={Author[name=Andy Oram,email=email,gender=u]},price=35.00,qty=5]
Book[name=OO Design Using Java,authors={Author[name=James Nino,email=email,gender=u],Author[name=Frederick Hosch,email=email,gender=u]},price=30.00,qty=6]
Book[name=Objects First with Java,authors={Author[name=David Barnes,email=email,gender=u],Author[name=Michael Kolling,email=email,gender=u]},price=29.50,qty=4]
| Data Mining Handbook    | Robert Nisbet                |  27.95 | 010 |
| Mastering COBOL         | Roger Hutty                  |   4.95 | 010 |
| Intro to COBOL          | Paul Murrill                 |   7.35 | 004 |
| Making Software         | Andy Oram                    |  35.00 | 005 |
| OO Design Using Java    | James Nino,Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes,Michael Kolling |  29.50 | 004 |
Search for term(s) 'Data Mining Handbook' in title...
| Data Mining Handbook    | Robert Nisbet                |  27.95 | 009 |
| Mastering COBOL         | Roger Hutty                  |   4.95 | 010 |
| Intro to COBOL          | Paul Murrill                 |   7.35 | 004 |
| Making Software         | Andy Oram                    |  35.00 | 005 |
| OO Design Using Java    | James Nino,Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes,Michael Kolling |  29.50 | 004 |
Removing all books with term 'software' in title...
Removed 1 books
| Data Mining Handbook    | Robert Nisbet                |  27.95 | 009 |
| Mastering COBOL         | Roger Hutty                  |   4.95 | 010 |
| Intro to COBOL          | Paul Murrill                 |   7.35 | 004 |
| OO Design Using Java    | James Nino,Frederick Hosch   |  30.00 | 006 |
| Objects First with Java | David Barnes,Michael Kolling |  29.50 | 004 |
EOM


###########################

mkdir -p tmpdir
rm -f ./tmpdir/*.*
rm -f ./tests/*.out

cp Author.java ./tmpdir/.
cp Book.java ./tmpdir/.
cp AuthorApp.java ./tmpdir/.
cp BookApp.java ./tmpdir/.
cp BookShopApp.java ./tmpdir/.
cp CopyArrayApp.java ./tmpdir/.
cp PassByValueApp.java ./tmpdir/.
cp StringFormatApp.java ./tmpdir/.
echo "$BookAppPWL" > ./tmpdir/BookAppPWL.java

echo
echo "*************************************"
echo "* PHASE 1 COMPILING SUBMISSION CODE"
echo "*************************************"
echo 

# Iterate over all Java files in the directory
for java_file in ./tmpdir/*.java; do
    # Compile the Java file 
    javac -cp tmpdir "$java_file"
    if [[ $? -eq 0 ]]; then
        echo "${java_file:9}: COMPILED"
    else
        echo "${java_file:9}: FAILED_TO_COMPILE"
    fi
done

echo
echo "*************************************"
echo "* PHASE 1 TESTING SUBMISSION CODE"
echo "*************************************"
echo TESTS: t01 t02 t03 t04 t05 t06
echo

echo t01 Testing CopyArrayApp using args: 1 1 2 3 4 4 
java -cp tmpdir CopyArrayApp 1 1 2 3 4 4 > ./tests/t01CopyArrayApp.out
if [[ $? -eq 0 ]]; then
    echo "CopyArrayApp: RAN"
else
    echo "CopyArrayApp: FAILED_TO_RUN"
    t01CopyArrayApp=FAILED_TO_RUN
fi

echo t02 Testing PassByValueApp works 
java -cp tmpdir PassByValueApp | tail -n 1 > ./tests/t02PassByValueApp.out
java -cp tmpdir PassByValueApp | wc -l | tr -d '[:blank:]'  >> ./tests/t02PassByValueApp.out
if [[ $? -eq 0 ]]; then
    echo "PassByValueApp: RAN"
else
    echo "PassByValueApp: FAILED_TO_RUN"
    t02PassByValueApp=FAILED_TO_RUN
fi

echo t03 Testing StringFormatApp using args: Oscar 22 1.52
java -cp tmpdir StringFormatApp Oscar 22 1.52 > ./tests/t03StringFormatApp.out
if [[ $? -eq 0 ]]; then
    echo "StringFormatApp: RAN"
else
    echo "StringFormatApp: FAILED_TO_RUN"
    t03StringFormatApp=FAILED_TO_RUN
fi

echo t04 Testing AuthorApp output is in line with instructions
java -cp tmpdir AuthorApp > ./tests/t04AuthorApp.out
if [[ $? -eq 0 ]]; then
    echo "AuthorApp: RAN"
else
    echo "AuthorApp: FAILED_TO_RUN"
    t04AuthorApp=FAILED_TO_RUN
fi

echo t05 Testing Book class using BookShopAppPWL testing code 
java -cp tmpdir BookAppPWL > ./tests/t05BookAppPWL.out
if [[ $? -eq 0 ]]; then
    echo "BookShopAppPWL: COMPILED"
else
    echo "BookShopAppPWL: FAILED_TO_COMPILE"
fi

echo t06 Testing BookShopApp output is in line with instructions
java -cp tmpdir BookShopApp > ./tests/t06BookShopApp.out
if [[ $? -eq 0 ]]; then
    echo "BookShopApp: RAN"
else
    echo "BookShopApp: FAILED_TO_RUN"
    t06BookShopApp=FAILED_TO_RUN
fi

echo t11 Testing CopyArrayApp using args: 4 88 19 0 0 1 6 6 2 98 2
java -cp tmpdir CopyArrayApp 4 88 19 0 0 1 6 6 2 98 2  > ./tests/t11CopyArrayApp.out
if [[ $? -eq 0 ]]; then
    echo "CopyArrayApp: RAN"
else
    echo "CopyArrayApp: FAILED_TO_RUN"
    t11CopyArrayApp=FAILED_TO_RUN
fi

echo t13 Testing StringFormatApp using args: Neil 43 1.77
java -cp tmpdir StringFormatApp Neil 43 1.77 > ./tests/t13StringFormatApp.out

if [[ $? -eq 0 ]]; then
    echo "StringFormatApp: RAN"
else
    echo "StringFormatApp: FAILED_TO_RUN"
    t13StringFormatApp=FAILED_TO_RUN
fi


#####################################

echo
echo "*********************************************"
echo "* PHASE 2 RUNNING EXTRA TESTS FOR GRADING  "
echo "*********************************************"
echo TESTS t11 t13 t14 t16 
echo 

rm -f ./tmpdir/*.*
echo "$Author" > ./tmpdir/Author.java
echo "$Book" > ./tmpdir/Book.java

# tac BookApp.java | sed '1h;1!H;$!d;x;s/;/;\nBook.checkCalls();/'  | tac | sed 's/BookApp/BookAppTest/g' > ./tmpdir/BookAppTest.java
cat BookApp.java | sed 's/BookApp/BookAppTest/g' > ./tmpdir/BookAppTest.java
sed 's/making software/Data Mining Handbook/g' BookShopApp.java | sed 's/"cobol";/"software";/g' | sed 's/BookShopApp/BookShopAppTest/g' > ./tmpdir/BookShopAppTest.java
cp BookShopApp.java ./tmpdir/.
cp AuthorApp.java ./tmpdir/.

# cat ./AuthorApp.java | sed 's/AuthorApp/AuthorAppTest/g' > ./tmpdir/AuthorAppTest.java

# Iterate over all Java files in the directory
for java_file in ./tmpdir/*.java; do
    # Compile the Java file 
    javac -cp tmpdir "$java_file"
    if [[ $? -eq 0 ]]; then
        echo "${java_file:9}: COMPILED"
    else
        echo "${java_file:9}: FAILED_TO_COMPILE"
    fi
done

echo t14 Testing AuthorApp internals using dummy Author class
java -cp tmpdir AuthorApp > ./tests/t14AuthorApp.out
if [[ $? -eq 0 ]]; then
    echo "AuthorApp: COMPILED"
else
    echo "AuthorApp: FAILED_TO_COMPILE"
fi

echo t16 Testing BookShopApp works when search terms updated
java -cp tmpdir BookShopAppTest > ./tests/t16BookShopAppTest.out
if [[ $? -eq 0 ]]; then
    echo "BookShopAppTest: COMPILED"
else
    echo "BookShopAppTest: FAILED_TO_COMPILE"
fi

echo
echo "*************************************"
echo "* PHASE 3 TESTING BookApp"
echo "*************************************"
echo t15 t17
echo 

echo "$Book2" > ./tmpdir/Book.java

# Iterate over all Java files in the directory
for java_file in ./tmpdir/*.java; do
    # Compile the Java file 
    javac -cp tmpdir "$java_file"
    if [[ $? -eq 0 ]]; then
        echo "${java_file:9}: COMPILED"
    else
        echo "${java_file:9}: FAILED_TO_COMPILE"
    fi
done

echo t17 Testing BookApp tests every method in Book class 
java -cp tmpdir BookAppTest | tac | grep "METHODS CHECKED" | head -n 1 | sed 's/METHODS CHECKED: //g' > ./tests/t17BookAppTest.out
if [[ $? -eq 0 ]]; then
    echo "BookAppTest: COMPILED"
else 
    echo "BookAppTest: FAILED_TO_COMPILE"
fi

echo t15 Testing BookApp tests at least 6 methods in Book class 
X=$(< ./tests/t17BookAppTest.out)
cp ./tests/t17BookAppTest.out ./tests/t17BookAppTest.out.bak
if [[ $X -gt 5 ]]; then
    echo "BOOKAPP AT LEAST TESTED 6 BOOK METHODS" > ./tests/t15BookAppTest.out;
    echo t05 BookApp tests  $X / 9  of Book class method passed
else
    echo "BOOKAPP TESTED LESS THAN 6 ( $X / 9 ) BOOK METHODS" > ./tests/t15BookAppTest.out;
    echo t05 BookApp tests  $X / 9  of Book class method but 6 needed to pass
fi
echo t17 Testing BookApp tests at ALL methods in Book class
X=$(< ./tests/t17BookAppTest.out)
echo "BOOKAPP TESTED $X BOOK METHODS" > ./tests/t17BookAppTest.out



###############################

echo
echo "****************************************************"
echo "* PHASE 4 COMPARING SUBMISSION VS EXPECTED OUTPUTS"
echo "****************************************************"
echo TESTS t01 t02 t03 t04 t05 t06 t11 t13 t14 t15 t16 t17
echo 
score=0
for student in ./tests/*.out; do
    ref=$(basename $student)
    ref="${ref%.*}"
    echo "${!ref}" > tmpdir/expected.out
    n=$(wc -l < $student | tr -d '[:blank:]')
    var="$(diff -B -E -Z -y --suppress-common-lines $student <(echo "${!ref}") | wc -l)"
    if [[ $var -eq 0 ]]; then
        echo ${ref}: PASS
	((score++))
    elif [[ $n -eq 0 ]]; then
	echo ${ref}: FAILED TO PRODUCE OUTPUT
    else
        echo ${ref}: FAIL
        echo "${!ref}" > tmpdir/model_answer.txt
        cat $student > tmpdir/submitted.txt
	echo
        echo ">>> ${ref}: differences - submission code output (green) vs model answer (red)"
        echo
        git diff --no-prefix -U1000 --no-index --ignore-space-at-eol   \
             --ignore-cr-at-eol  --ignore-blank-lines  --color \
                tmpdir/model_answer.txt tmpdir/submitted.txt | tail -n +6 | sed 's/^/   /'
   	# diff -B -E -Z $student <(echo "${!ref}")
	echo 
   fi
done
result=${PWD##*/}
echo Grade for user ${result:12} is ${score}/12
