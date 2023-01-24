// See https://aka.ms/new-console-template for more information

string[] lines = System.IO.File.ReadAllLines(@"C:\Users\Public\Documents\2022\AOC2022day2-PuzzleInput.txt");
int score = 0;
int loss = 0;
int draw = 3;
int win = 6;
int rock = 1;
int paper = 2;
int scissor = 3;

// TASK 1
foreach (string line in lines)
{
    string[] game = line.Split(" ");
    switch (game[0])
    {
        case "A":
            switch (game[1])
            {
                case "X":
                    score += rock + draw;
                    break;
                case "Y":
                    score += paper + win;
                    break;
                case "Z":
                    score += scissor + loss;
                    break;
            }
            break;
        case "B":
            switch (game[1])
            {
                case "X":
                    score += rock + loss;
                    break;
                case "Y":
                    score += paper + draw;
                    break;
                case "Z":
                    score += scissor + win;
                    break;
            }
            break;
        case "C":
            switch (game[1])
            {
                case "X":
                    score += rock + win;
                    break;
                case "Y":
                    score += paper + loss;
                    break;
                case "Z":
                    score += scissor + draw;
                    break;
            }
            break;
    }
}
Console.WriteLine(score);

// TASK 2
score = 0;
foreach (string line in lines)
{
    string[] game = line.Split(" ");
    switch (game[0])
    {
        case "A":
            switch (game[1])
            {
                case "X":
                    score += loss + scissor;
                    break;
                case "Y":
                    score += draw + rock;
                    break;
                case "Z":
                    score += win + paper;
                    break;
            }
            break;
        case "B":
            switch (game[1])
            {
                case "X":
                    score += loss + rock;
                    break;
                case "Y":
                    score += draw + paper;
                    break;
                case "Z":
                    score += win + scissor;
                    break;
            }
            break;
        case "C":
            switch (game[1])
            {
                case "X":
                    score += loss + paper;
                    break;
                case "Y":
                    score += draw + scissor;
                    break;
                case "Z":
                    score += win + rock;
                    break;
            }
            break;
    }
}
Console.WriteLine(score);
