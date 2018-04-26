% % Problem 2
% % Haar wavelet

clc
clear all;
close all;

% import house.tif
I1=imread('house.tif'); %load image 
I=im2double(I1(:,:,1));        %Convert image to double precision 
imshow(I);

% haart wavlet transform
x=I;
level=2;

% haart2 function 
[a1,h1,v1,d1] = haart2(x,1);
[a,h,v,d] = haart2(x,2);
A1img=a;
scale =2;
A1img=a1;
H1img=h1;
V1img=v1;
D1img=d1;
A2img=a;
H2img=h{1,scale};
V2img=v{1,scale};
D2img=d{1,scale};

% % wavletdec2 function
% [c,s]=wavedec2(x,level,'haar');
% [H1,V1,D1] = detcoef2('all',c,s,1);
% A1 = appcoef2(c,s,'haar',1); 
% V1img = wcodemat(V1,255,'mat',1);
% H1img = wcodemat(H1,255,'mat',1);
% D1img = wcodemat(D1,255,'mat',1);
% A1img = wcodemat(A1,255,'mat',1);
% [H2,V2,D2] = detcoef2('all',c,s,2);
% A2 = appcoef2(c,s,'haar',2); 
% V2img = wcodemat(V2,255,'mat',1);
% H2img = wcodemat(H2,255,'mat',1);
% D2img = wcodemat(D2,255,'mat',1);
% A2img = wcodemat(A2,255,'mat',1);

% plot
% level 1
subplot(2,2,1);
imagesc(A1img);
colormap pink(255);
title('Approximation Coef. of Level 1');

subplot(2,2,2);
imagesc(H1img);
title('Horizontal detail Coef. of Level 1');

subplot(2,2,3);
imagesc(V1img);
title('Vertical detail Coef. of Level 1');

subplot(2,2,4);
imagesc(D1img);
title('Diagonal detail Coef. of Level 1');

% level 2
figure,
subplot(2,2,1);
imagesc(A2img);
colormap pink(255);
title('Approximation Coef. of Level 2');

subplot(2,2,2);
imagesc(H2img);
title('Horizontal detail Coef. of Level 2');

subplot(2,2,3);
imagesc(V2img);
title('Vertical detail Coef. of Level 2');

subplot(2,2,4);
imagesc(D2img);
title('Diagonal detail Coef. of Level 2');

% reconstruct 
recons = waverec2(C,S,'wname');

 [C,S] = wavedec2(X,2,'haar');
 Xnew = waverec2(C,S,'haar');
 max(max(abs(X-Xnew)))