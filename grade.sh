CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
#hi my name is Michael
rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f student-submission/ListExamples.java ]]
then 
    echo "file found"
else 
    echo "file not found"
    exit
fi

cp student-submission/ListExamples.java TestListExamples.java grading-area
cp -r lib grading-area

cd grading-area
javac -cp $CPATH *.java

if [[ $? -eq 0 ]]
then 
    echo "compilation successful"
else    
    echo "compilation not successful"
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-testresults.txt
(cat junit-testresults.txt | head -n 2 > junit-top2lines.txt)
(cat junit-top2lines.txt | tail -n 1 > junit-E.txt)
grep -o "\." junit-E.txt > dots.txt
grep -o "E" junit-E.txt > E.txt

tests=`wc -l < dots.txt`
failiures=`wc -l < E.txt`
successes=$((tests - failiures))

echo "Your score is $successes /$tests "




