// See https://aka.ms/new-console-template for more information
string line = System.IO.File.ReadAllText(@"C:\\Users\\davhei15\\repos\\AdventOfCode2022\\day6\AOC2022day6-puzzleinput.txt");
bool task1 = true;
for (int i = 4; i < line.Length; i++)
{
        if((line[(i - 4)..i]).Distinct().Count() == 4 && task1 ) {
        Console.WriteLine(i);
        task1 = false;
    }
    if (i > 14 && (line[(i - 14)..i]).Distinct().Count() == 14)
    {
        Console.WriteLine(i);
        break;
    }
}
