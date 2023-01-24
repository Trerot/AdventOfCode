// See https://aka.ms/new-console-template for more information
using System.Collections;

// reading from file
string[] lines = System.IO.File.ReadAllLines(@"C:\Users\david\REPOS\AdventOfCode2022\aoc2022day1.txt");
// creating an arraylist and the variables to use
var arlist = new ArrayList();
int calories = 0;
int calorie = 0;

foreach (string line in lines)
{
    if(line != "") {
        Int32.TryParse(line, out calorie);
        calories = calorie+calories;
    }
    else {
        arlist.Add(calories);
        calories = 0; }
} 

// sort descending here
arlist.Sort();
arlist.Reverse();
// print out the answer for task 1 here
Console.WriteLine(arlist[0]);
// print out the answer for task 2 here
int answerTask2 = 0;
for (int i = 0; i < 3; i++)
{
    int num = Convert.ToInt32(arlist[i]);

    answerTask2 = answerTask2 + num;
}
Console.WriteLine(answerTask2);

