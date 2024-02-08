# Reaction Time Test

This repository contains a MATLAB script for a simple reaction time test. The script presents a series of squares to the user and measures the time it takes for the user to respond when the square changes color.

## How It Works

The script initializes a figure window and listens for key press events. It then enters a loop where it displays a red square for a random period of time, then changes the square to green. When the square turns green, a timer starts. The user is supposed to press the 'G' key as soon as they see the green square, at which point the timer stops and the reaction time is recorded.

This process repeats for a predefined number of tests. At the end of all tests, the script calculates and displays the average reaction time.

## Normal Reaction Times

Most studies suggest that the average human reaction time is between 200 and 300 milliseconds. A good human reaction time, therefore, is as close to 200 ms as possible.

## Usage

To run the test, simply call the `reaction_time_test` function in MATLAB. No arguments are required.

## Code Structure

The script is structured into several local functions:

- `reaction_time_test`: The main function that initializes variables and controls the test loop.
- `displaySquare`: A helper function that displays a square of a specified color.
- `keyPressFunction`: A callback function that handles key press events.
- `calculateAndDisplayResults`: A function that calculates and displays the reaction times after all tests are completed.
- `checkFigureState`: A function that checks the state of the figure every millisecond.
