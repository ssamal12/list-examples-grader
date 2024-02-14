CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests


cp student-submission/*.java grading-area
cp *.java grading-area
cp -r lib grading-area

cd grading-area

if ! [ -f ListExamples.java ]
then
    echo "Missing ListExamples.java"
    echo "Score: 0"
    exit
fi

javac -cp $CPATH *.java

if [ $? -ne 0 ]
then 
    echo "Compilation Error"
    echo "Score: 0"
    exit
fi


java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

tests=$(java -cp $CPATH org.junit.runner.JUnitCore TestListExamples | grep 'Failures' | cut -d' ' -f3 | cut -c 1)
failures=$(java -cp $CPATH org.junit.runner.JUnitCore TestListExamples | grep 'Failures' | cut -d' ' -f6)

if [[ -n "$tests" ]]
then 
    echo "Score: $(( $tests - $failures / $tests ))"


else 
    echo "Score: 100.0"

fi
