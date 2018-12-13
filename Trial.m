function [dstRect, subdstRect] = Trial(players)
%clear workspace and screen
sca;
close all;

%skip the sync error given on VF laptop
Screen('Preference','SkipSyncTests', 1);

%default settings
PsychDefaultSetup(2);

%get the screens
screens = Screen('Screens');
screenNumber = max(screens); %go to external if needed


try
    
    %define white and black
    white = WhiteIndex(screenNumber);
    
    %Eventually initialize this when we know how many trials/the trial
    %structure, will collect data from subject responses
    ResponseVector = [];
    
    %Open a window
    [window, ~] = Screen('OpenWindow', screenNumber);
    
    % Get the size of the on screen window
    %[screenXpixels, screenYpixels] = Screen('WindowSize', windo);
    
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', ...
        'GL_ONE_MINUS_SRC_ALPHA');
    
    %Call the makecards function to set up the correct number/config of
    %cards
    
    %Below assignments are temporary for debugging
    perObjectOnCards = 2;
 
    
    dstRects = getCardPositions(players, perObjectOnCards, window);
    
    %draw the cards to the dstRects
    penWidthPixels = 6;
    Screen('FrameRect', window, [0 0 0], dstRects, penWidthPixels)
    
    %make labels
    makelabels(players)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %This calls the generate images, which will eventually draw the 
    %random shapes to the cards. For now, it partitions each card 
    %into halves that can be used as dstRect for drawing an image to.
    %generateimages(players)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Flip to the screen
    Screen('Flip', window);
    
    %Get the click
    %cardChoice = recordclick();
    
% %This way at the end there'll be a vector with all the choices, can
% %compare to the different playing strategies
% ResponseVector = cat(2, ResponseVector, cardChoice);
% disp(ResponseVector)
    
    % Wait for a keyboard button press to exit
    KbStrokeWait;
    sca
    
catch
    sca
end

end
