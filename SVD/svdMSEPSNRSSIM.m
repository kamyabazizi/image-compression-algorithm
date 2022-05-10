%all the quality factors for image compressions(DWT)
clear all;clc;
imdata = imread('originalimage.jpg');
figure
imshow(imdata);
title('original image');
ref = rgb2gray(imdata);
%figure
%imshow(ref);
%title('gray image');
imcomp = imread('svd using 300 singular values.jpg');
figure
imshow(imcomp);
title('compressed image')
refcomp = rgb2gray(imcomp);
%figure
%imshow(refcomp);
%title('gray comp image');
%Mean square error (MSE)
err = mse(ref,refcomp);
fprintf('\n The MSE value is %0.4f', err);
%Peak to signal ratio (PSNR)
[peaksnr, snr] = psnr(ref, refcomp);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
%Structural Similarity Index (SSIM) for measuring image quality
[ssimval, ssimmap] = ssim(ref,refcomp);
fprintf('\n The SSIM value is %0.4f.\n',ssimval);