


I = imread('one.png'); //enter the image name here 
[S,BW,BWstripes] = processImage(I);

imshow(I)

s = size(I)

minIndices = islocalmin(S,'MinProminence',90,'ProminenceWindow',25);

% Display results
clf
plot(S,'Color',[109 185 226]/255,'DisplayName','Input data')
hold on

% Plot local minima
plot(find(minIndices),S(minIndices),'v','Color',[237 177 32]/255,...
    'MarkerFaceColor',[237 177 32]/255,'DisplayName','Local minima')
title(['Number of extrema: ' num2str(nnz(minIndices))])
hold off
legend

nMin = nnz(minIndices);

isReceipt = nMin >= 9

function [signal,Ibw,stripes] = processImage(img)
    % This function processes an image using the algorithm
    % developed in previous chapters.

    gs = im2gray(img);
    gs = imadjust(gs);

    H = fspecial("average",3);
    gssmooth = imfilter(gs,H,"replicate");

    SE = strel("disk",8);
    Ibg = imclose(gssmooth, SE);
    Ibgsub =  Ibg - gssmooth;
    Ibw = ~imbinarize(Ibgsub);

    SE = strel("rectangle",[3 25]);
    stripes = imopen(Ibw, SE);

    signal = sum(stripes,2);

end
