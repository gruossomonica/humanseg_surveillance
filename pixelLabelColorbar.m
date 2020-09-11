function pixelLabelColorbar(cmap, classNames)
% Add a colorbar to the current axis. The colorbar is formatted
% to display the class names with the color
%
% Input:
%   - cmap: the colormap used
%   - classNames: the names of the classes (example: background, foreground)

    colormap(gca,cmap)

    % Add colorbar to current figure.
    c = colorbar('peer', gca);
    % c = colorbar('peer', gca, 'Location','southoutside'); 

    % Use class names for tick marks.
    c.TickLabels = classNames;
    numClasses = size(cmap,1);

    % Center tick labels.
    c.Ticks = 1/(numClasses*2):1/numClasses:1;

    % Remove tick mark.
    c.TickLength = 0;
end