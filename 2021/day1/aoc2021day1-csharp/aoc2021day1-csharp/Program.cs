// See https://aka.ms/new-console-template for more information
string[] lines = System.IO.File.ReadAllLines(@"C:\Users\david\REPOS\AdventOfCode2022\2021\day1\aoc2021day1-puzzleinput.txt");

# Task 1
int counter = 0;
int previous = 9999999;
foreach (string line in lines)
{
    if (Int32.Parse(line) > previous)
    {
        counter++;
    }
    previous = Int32.Parse(line);
}
Console.WriteLine(counter);