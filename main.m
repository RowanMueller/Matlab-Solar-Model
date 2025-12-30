clear; clc; close all;
addpath("helper");

G = 6.674e-11;
dt = 100000;
numSteps = 1000;
system = sys();

filename = 'Final_Submission_Movie.mp4';
v = VideoWriter(filename,'MPEG-4');
v.FrameRate = 60;
v.Quality = 100;
open(v);

%lock position for movie recording
fig = figure('Position',[200 200 800 800]);

for step = 1:numSteps
    system = computations(system, dt, G);
    rendersystem(system);
    title(sprintf('Simulation (step = %d)', step));

    drawnow;
    frame = getframe(fig);
    writeVideo(v, frame);
end

close(v);
disp("Movie recorded successfully: " + filename);
