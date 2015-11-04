% Transform from RGB to Lab color space
%SImgLAB = rgb2lab(I);
%TImgLAB = rgb2lab(J);
%sourceImg = imread('ocean_day.jpg');
%targetImg = imread('ocean_sunset.jpg');
sourceImg = imread('ocean_sunset.jpg');
targetImg = imread('ocean_day.jpg');
%sourceImg = imread('11.jpg');
%targetImg = imread('12.jpg');

SImgLAB = kidding(sourceImg);
TImgLAB = kidding(targetImg);
imshow(SImgLAB);
%Extract L, A and B from LAB color space

SImgL = SImgLAB(:,:,1);
SImgA = SImgLAB(:,:,2);
SImgB = SImgLAB(:,:,3);


TImgL = TImgLAB(:,:,1);
TImgA = TImgLAB(:,:,2);
TImgB = TImgLAB(:,:,3);

%Get mean value for each channel

meanSL = mean2(SImgL);
meanSA = mean2(SImgA);
meanSB = mean2(SImgB);

meanTL = mean2(TImgL);
meanTA = mean2(TImgA);
meanTB = mean2(TImgB);


%Subtract mean from data points

noMeanSL = SImgL - meanSL;
noMeanSA = SImgA - meanSA;
noMeanSB = SImgB - meanSB;

%Calculate std deviation

stdLS = std2(SImgL);
stdAS = std2(SImgA);
stdBS = std2(SImgB);

stdLT = std2(TImgL);
stdAT = std2(TImgA);
stdBT = std2(TImgB);

%Scale values
LScaled = noMeanSL * stdLT/stdLS;
AScaled = noMeanSA * stdAT/stdAS;
BScaled = noMeanSB * stdBT/stdBS;

%Re-Add the averages computed by the photograph.
LScaled = LScaled + meanTL;
AScaled = AScaled + meanTA;
BScaled = BScaled + meanTB;

%Combine everything and covert back to RGB!
K = cat(3,LScaled,AScaled,BScaled);
%imshow(K);
K = right(K);
imshow(K);
