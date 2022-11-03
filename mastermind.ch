using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ConsoleTableExt;
//use https://github.com/smithy6/Console-Mastermind/blob/main/Mastermind.ch
namespace Mastermind_2._1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //Declares variables
            int blackPegs = 0;
            int whitePegs = 0;
            int attempts = 0;
            int[] userNumBoard = new int[20];
            //Make game board
            var gameBoard = new List<List<object>>
            {
                new List<object>{ "Guess 1", "Guess 2", "Guess 3", "Guess 4", "Black Pegs", "White Pegs" },
                new List<object>{ userNumBoard[0], userNumBoard[1], userNumBoard[2], userNumBoard[3], blackPegs, whitePegs },
                new List<object>{ userNumBoard[4], userNumBoard[5], userNumBoard[6], userNumBoard[7], blackPegs, whitePegs },
                new List<object>{ userNumBoard[8], userNumBoard[9], userNumBoard[10], userNumBoard[11], blackPegs, whitePegs },
                new List<object>{ userNumBoard[12], userNumBoard[13], userNumBoard[14], userNumBoard[15], blackPegs, whitePegs },
                new List<object>{ userNumBoard[16], userNumBoard[17], userNumBoard[18], userNumBoard[19], blackPegs, whitePegs },
            };
            //Write game introduction
            mastermindTextLogo();
            Console.ForegroundColor = ConsoleColor.DarkYellow;
            Console.WriteLine("\nWelcome to Mastermind! You have 5 attempts to guess the 4 digit code. Good luck!");
            Console.WriteLine("The code consists of 4 numbers between 1 and 6. You will be given feedback on your guess.");
            Console.WriteLine("A black peg means you have a correct number in the correct position.");
            Console.WriteLine("A white peg means you have a correct number in the wrong position.");
            Console.WriteLine("You can enter your guess in the following format: 1234");
            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
            Console.Clear();
            mastermindTextLogo();
            Console.ForegroundColor = ConsoleColor.DarkBlue;
            Console.WriteLine("Enter a four digit number, e.g. 1234: ");
            Console.ForegroundColor = ConsoleColor.White;
            //Make secret code random and store it in an array
            Random rnd = new Random();
            int[] secretCode = new int[4];
            for (int i = 0; i < secretCode.Length; i++)
            {
                secretCode[i] = rnd.Next(1, 7);
            }
            //User input processing
            int[] userNumber = Console.ReadLine()
                .Select(v => v - '0').ToArray();
            userNumberVailidation();
            updateGbVariables();
            //Game
            updateGb();
            outputGameBoard();
            while (attempts <= 4)
            {
                userNumberGameCheck();
                attempts++;
                checkGuessesAndAttempts();
                Console.ForegroundColor = ConsoleColor.DarkBlue;
                Console.Write(whitePegs + " white pegs, ");
                Console.Write(blackPegs + " black pegs. ");
                Console.Write("Try Again: ");
                Console.ForegroundColor = ConsoleColor.White;
                whitePegs = 0;
                blackPegs = 0;
                userNumber = Console.ReadLine()
                    .Select(v => v - '0').ToArray();
                userNumberVailidation();
                updateGbVariables();
                updateGb();
                outputGameBoard();
            }
            Console.ReadKey();
            //Make mastermind text logo
            void mastermindTextLogo()
            {
                string mastermind = ("   __  __           _____ _______ ______ _____  __  __ _____ _   _ _____  \n  |  \\/  |   /\\    / ____|__   __|  ____|  __ \\|  \\/  |_   _| \\ | |  __ \\ \n  | \\  / |  /  \\  | (___    | |  | |__  | |__) | \\  / | | | |  \\| | |  | |\n  | |\\/| | / /\\ \\  \\___ \\   | |  |  __| |  _  /| |\\/| | | | | . ` | |  | |\n  | |  | |/ ____ \\ ____) |  | |  | |____| | \\ \\| |  | |_| |_| |\\  | |__| |\n  |_|  |_/_/    \\_\\_____/   |_|  |______|_|  \\_\\_|  |_|_____|_| \\_|_____/ ");
                Console.ForegroundColor = ConsoleColor.DarkRed;
                Console.WriteLine(mastermind);
                Console.ForegroundColor = ConsoleColor.White;
            }
            //user number validation
            void userNumberVailidation()
            {
                while (userNumber.Length != 4)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Error: You must enter 4 digits.");
                    Console.ForegroundColor = ConsoleColor.DarkBlue;
                    Console.WriteLine("Enter a four digit numbers, e.g. 1234");
                    Console.ForegroundColor = ConsoleColor.White;
                    userNumber = Console.ReadLine()
                        .Select(v => v - '0').ToArray();
                }
                while (userNumber[0] < 1 || userNumber[0] > 6 || userNumber[1] < 1 || userNumber[1] > 6 || userNumber[2] < 1 || userNumber[2] > 6 || userNumber[3] < 1 || userNumber[3] > 6)
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                    Console.WriteLine("Error: You must enter numbers between 1 and 6.");
                    Console.ForegroundColor = ConsoleColor.DarkBlue;
                    Console.WriteLine("Enter a four digit numbers, e.g. 1234");
                    Console.ForegroundColor = ConsoleColor.White;
                    userNumber = Console.ReadLine()
                        .Select(v => v - '0').ToArray();
                }
            }
            //update gameboard variables
            void updateGbVariables()
            {
                if (attempts == 0)
                {
                    userNumBoard[0] = userNumber[0];
                    userNumBoard[1] = userNumber[1];
                    userNumBoard[2] = userNumber[2];
                    userNumBoard[3] = userNumber[3];
                }
                if (attempts == 1)
                {
                    userNumBoard[4] = userNumber[0];
                    userNumBoard[5] = userNumber[1];
                    userNumBoard[6] = userNumber[2];
                    userNumBoard[7] = userNumber[3];
                }
                if (attempts == 2)
                {
                    userNumBoard[8] = userNumber[0];
                    userNumBoard[9] = userNumber[1];
                    userNumBoard[10] = userNumber[2];
                    userNumBoard[11] = userNumber[3];
                }
                if (attempts == 3)
                {
                    userNumBoard[12] = userNumber[0];
                    userNumBoard[13] = userNumber[1];
                    userNumBoard[14] = userNumber[2];
                    userNumBoard[15] = userNumber[3];
                }
                if (attempts == 4)
                {
                    userNumBoard[16] = userNumber[0];
                    userNumBoard[17] = userNumber[1];
                    userNumBoard[18] = userNumber[2];
                    userNumBoard[19] = userNumber[3];
                }
            }
            //update gmae board
            void updateGb()
            {
                if (attempts == 0)
                {
                    gameBoard[1][0] = userNumBoard[0];
                    gameBoard[1][1] = userNumBoard[1];
                    gameBoard[1][2] = userNumBoard[2];
                    gameBoard[1][3] = userNumBoard[3];
                    gameBoard[1][4] = blackPegs;
                    gameBoard[1][5] = whitePegs;
                }
                if (attempts == 1)
                {
                    gameBoard[2][0] = userNumBoard[4];
                    gameBoard[2][1] = userNumBoard[5];
                    gameBoard[2][2] = userNumBoard[6];
                    gameBoard[2][3] = userNumBoard[7];
                    gameBoard[2][4] = blackPegs;
                    gameBoard[2][5] = whitePegs;
                }
                if (attempts == 2)
                {
                    gameBoard[3][0] = userNumBoard[8];
                    gameBoard[3][1] = userNumBoard[9];
                    gameBoard[3][2] = userNumBoard[10];
                    gameBoard[3][3] = userNumBoard[11];
                    gameBoard[3][4] = blackPegs;
                    gameBoard[3][5] = whitePegs;
                }
                if (attempts == 3)
                {
                    gameBoard[4][0] = userNumBoard[12];
                    gameBoard[4][1] = userNumBoard[13];
                    gameBoard[4][2] = userNumBoard[14];
                    gameBoard[4][3] = userNumBoard[15];
                    gameBoard[4][4] = blackPegs;
                    gameBoard[4][5] = whitePegs;
                }
                if (attempts == 4)
                {
                    gameBoard[5][0] = userNumBoard[16];
                    gameBoard[5][1] = userNumBoard[17];
                    gameBoard[5][2] = userNumBoard[18];
                    gameBoard[5][3] = userNumBoard[19];
                    gameBoard[5][4] = blackPegs;
                    gameBoard[5][5] = whitePegs;
                }
            }
            //Output Gameboard
            void outputGameBoard()
            {
                Console.Clear();
                mastermindTextLogo();
                ConsoleTableBuilder.From(gameBoard).WithCharMapDefinition(CharMapDefinition.FramePipDefinition)
                .WithCharMapDefinition(
                    CharMapDefinition.FramePipDefinition,
                    new Dictionary<HeaderCharMapPositions, char> {
                        {HeaderCharMapPositions.TopLeft, '╒' },
                        {HeaderCharMapPositions.TopCenter, '═' },
                        {HeaderCharMapPositions.TopRight, '╕' },
                        {HeaderCharMapPositions.BottomLeft, '╞' },
                        {HeaderCharMapPositions.BottomCenter, '╤' },
                        {HeaderCharMapPositions.BottomRight, '╡' },
                        {HeaderCharMapPositions.BorderTop, '═' },
                        {HeaderCharMapPositions.BorderRight, '│' },
                        {HeaderCharMapPositions.BorderBottom, '═' },
                        {HeaderCharMapPositions.BorderLeft, '│' },
                        {HeaderCharMapPositions.Divider, ' ' },
                    })
                .ExportAndWriteLine();
            }
            void userNumberGameCheck()
            {
                for (int c = 0; c < 4; c++)
                {
                    if (secretCode[c] == userNumber[c])
                    {
                        blackPegs++;
                        updateGbVariables();
                        updateGb();
                        outputGameBoard();
                    }
                    else if (secretCode.Contains(userNumber[c])
                        && userNumber[c] != secretCode[c])
                    {
                        whitePegs++;
                        updateGbVariables();
                        updateGb();
                        outputGameBoard();
                    }
                }
            }
            //User Guess correct or run out of attempts
            void checkGuessesAndAttempts()
            {
                if (blackPegs == 4)
                {
                    updateGbVariables();
                    updateGb();
                    outputGameBoard();
                    Console.ForegroundColor = ConsoleColor.Green;
                    Console.WriteLine("All correct! Attempts: " + attempts);
                    exitGame();
                }
                if (attempts == 5)
                {
                    updateGbVariables();
                    updateGb();
                    outputGameBoard();
                    Console.ForegroundColor = ConsoleColor.Red; //colours the text red
                    Console.WriteLine("You ran out of attempts! The correct answer was: " + secretCode[0] + secretCode[1] + secretCode[2] + secretCode[3]);
                    exitGame();
                }
            }
            //exit game
            void exitGame()
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.WriteLine("Press any key to exit");
                Console.ReadKey();
                Environment.Exit(0);
            }
        }

    }
}
