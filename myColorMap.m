function cmap = myColorMap()
% Define the colormap used
%
% Output: 
%   - cmap: the colormap

    cmap = [
        214 10 66; ... % foreground --> fucsia
        73 236 254; ... % background --> celeste
        ];

    % Normalize between [0 1].
    cmap = cmap ./ 255;
end