close all
clear all
clc

%reading and converting the image
inImage=imread('originalimage.jpg');
R = inImage(:, :, 1);
G = inImage(:, :, 2);
B = inImage(:, :, 3);
R=double(R);
G=double(G);
B=double(B);
inImageD=double(inImage);
% decomposing the image using singular value decomposition
[U,S,V]=svd(R);
[U1,S1,V1]=svd(G);
[U2,S2,V2]=svd(B);

% Using different number of singular values (diagonal of S) to compress and
% reconstruct the image
dispEr = [];
numSVals = [];
N=input('Enter the number of singular values');
% store the singular values in a temporary var
C = S;
C1 = S1;
C2 = S2;

% discard the diagonal values not required for compression
C(N+1:end,:)=0;
C(:,N+1:end)=0;

C1(N+1:end,:)=0;
C1(:,N+1:end)=0;

C2(N+1:end,:)=0;
C2(:,N+1:end)=0;


% Construct an Image using the selected singular values
D=U*C*V';
D1=U1*C1*V1';
D2=U2*C2*V2';
H=cat(3,D,D1,D2);

% display result
figure;
buffer = sprintf('Image output using %d singular values', N)
imshow(uint8(H));
title(buffer);
error=sum(sum((inImageD-H).^2));
imwrite(uint8(H), sprintf('svd using %d singular values.jpg', N), 'jpg');

