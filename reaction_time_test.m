function reaction_time_test()
%REACTION_TIME_TEST Measures reaction time based on color change of a square.
%
%   reaction_time_test()
%
%   INPUT ============================================================
%   
%   None
%
%   OUTPUT ============================================================
%   
%   None
%
%   The function initializes a figure window and listens for key press events. 
%   It then enters a loop where it displays a red square for a random period of time, 
%   then changes the square to green. When the square turns green, a timer starts. 
%   The user is supposed to press the 'G' key as soon as they see the green square, 
%   at which point the timer stops and the reaction time is recorded. This process 
%   repeats for a predefined number of tests. At the end of all tests, the script 
%   calculates and displays the average reaction time.
%
%   AUTHOR ============================================================
%
%   S.Bahdasariants, NEL, WVU, https://github.com/SerhiiBahdas
%
%   ===================================================================


% Initialize variables
numTests = 10; % Limit to 10 presentations of green squares
reactionTimes = zeros(1, numTests); % Preallocate array for reaction times
testCount = 0; % Count of completed tests

% Create figure with key press detection
figureHandle = figure('KeyPressFcn', @keyPressFunction, 'Name', 'Reaction Time Test', 'NumberTitle', 'off');

% Instructions
uicontrol('Style', 'text', 'Position', [100 350 200 40], 'String', 'Press G when the square turns GREEN.');

% Prepare the axes
axesHandle = axes('Position', [0.3, 0.1, 0.4, 0.6]);
axis off;

% Loop for displaying squares and measuring reaction times
while testCount < numTests && ishandle(figureHandle)
    % Display red square and wait for a random time between 1 and 2 seconds
    displaySquare(axesHandle, 'red');
    pause(2*rand(1) + 1); % Random pause between 1 and 2 seconds

    if testCount < numTests && ishandle(figureHandle)
        % Display green square and start timer
        displaySquare(axesHandle, 'green');
        tic; % Start measuring reaction time
        pause(2); % Give a window of 1 second for reaction
    end
end

% Calculate and display results after the loop
calculateAndDisplayResults(reactionTimes, testCount);

function displaySquare(axesHandle, color)
    % Display a colored square
    axes(axesHandle);
    cla(axesHandle);
    rectangle('Position', [0, 0, 1, 1], 'FaceColor', color);
    axis([0 1 0 1]);
    set(gca, 'Color', 'none', 'XColor', 'none', 'YColor', 'none');
end

function keyPressFunction(~, event)
    % Handle key press events
    if strcmp(event.Key, 'g') && strcmp(get(figureHandle, 'CurrentCharacter'), 'g')
        if testCount < numTests
            % Stop timer and get reaction time
            reactionTimes(testCount + 1) = toc;
            testCount = testCount + 1; % Increment test count after recording reaction
        end
    end
end

function calculateAndDisplayResults(reactionTimes, testCount)
    % Filter out unused preallocated space if the test was prematurely ended
    reactionTimes = reactionTimes(1:testCount);
    % Convert reaction times to milliseconds
    reactionTimesMs = reactionTimes * 1000;
    % Display all reaction times
    disp('All reaction times (ms):');
    disp(reactionTimesMs);
    % Calculate and display average reaction time
    if ~isempty(reactionTimesMs)
        averageReactionTimeMs = mean(reactionTimesMs);
        disp(['Average reaction time: ', num2str(averageReactionTimeMs), ' ms']);
    else
        disp('No reaction times recorded.');
    end
end

% Timer object to check the state of the figure every millisecond
timerObj = timer('TimerFcn', @checkFigureState, 'Period', 0.001, 'ExecutionMode', 'fixedRate');
start(timerObj);

function checkFigureState(~, ~)
    if ~ishandle(figureHandle)
        stop(timerObj);
        delete(timerObj);
    end
end

end
