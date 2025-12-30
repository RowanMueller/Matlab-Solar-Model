function rendersystem(system)

% Need persistent variables so that rendered objects (planets, suns, and their motion trails)
% stay in memory across multiple calls of this function (each frame update).
persistent hPlanets hTrails trailHist initialized axisLimit colors maxTrail

N = length(system);

% Determine if we need to initialize figure elements
needInit = isempty(initialized);

if ~needInit
    % Check if figure objects were deleted (ex: user closes figure manually)
    % If so, reinitialize the rendering system.
    for i = 1:N
        if ~isvalid(hPlanets(i)) || ~isvalid(hTrails(i)); needInit = true; break;
        end
    end
end

%init rendering block
if needInit
    clf;
    hold on;

    axisLimit = 5.5e11;   % viewing boundaries
    maxTrail = 1200;        % max number of trail positions to store
    colors = vertcat(system.color);   % planet colors
    hPlanets = gobjects(N,1);    % Array of handles for planet markers
    hTrails  = gobjects(N,1);    % Array of handles for trail line plots
    trailHist = cell(N,1);       % position history for each planet

    %init planets/trail sizes
    for i = 1:N
        
        body_mass = system(i).mass;
        
        if i == 1 || body_mass > 5e29
            markerSize = 18;      % stars
        elseif body_mass < 5e22
            markerSize = 1;       % moons
        else
            markerSize = 5;       % planets
        end
        
        hPlanets(i) = plot3(system(i).pos(1), system(i).pos(2), system(i).pos(3), 'o', 'MarkerSize', markerSize, 'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'k');
    
        hTrails(i) = scatter3(nan, nan, nan, 10, colors(i,:), 'filled', 'MarkerFaceAlpha', 1);
        
        trailHist{i} = system(i).pos;
    end

    % Define axis/limits
    xlim([-axisLimit axisLimit]);
    ylim([-axisLimit axisLimit]);
    zlim([-axisLimit axisLimit]);

    axis vis3d;
    grid on;         
    view(3);         % viewing angle

    xlabel('X'); ylabel('Y'); zlabel('Z');

    % fix aspect ratio
    ax = gca; 
    ax.DataAspectRatio = [1 1 1];

    hold off;
    initialized = true;
    return;
end

% update/movie loop
hold on;
for i = 1:N
    set(hPlanets(i), 'XData', system(i).pos(1), 'YData', system(i).pos(2), 'ZData', system(i).pos(3));
    trailHist{i}(end+1,:) = system(i).pos;

    % Limit trail length
    if size(trailHist{i},1) > maxTrail; trailHist{i} = trailHist{i}(end-maxTrail+1:end,:); end

    % Brightness fade on trail lines; init to 1, fade to 0
    C = trailHist{i};
    fade = linspace(0, 1, size(C,1))';
    set(hTrails(i), 'XData', C(:,1), 'YData', C(:,2), 'ZData', C(:,3), 'CData', repmat(colors(i,:), size(C,1),1), 'SizeData', 6, 'MarkerFaceAlpha', 'flat', 'AlphaData', fade);
end

hold off;

% camera movement
camorbit(0.4, 0);
drawnow;