clear all;
clc;
I = double(imread('originalimage.jpg'));
%RGB image
R = I(:, :, 1);
G = I(:, :, 2);
B = I(:, :, 3);

mag = input('Enter magnitude that set to the zero in DCT matric:');

dct = @(block_struct) dct2(block_struct.data);
BR = blockproc(R,[8 8],dct);
setz=blockproc(BR,[8 8],@(block_struct) block_struct.data(abs(block_struct.data) < mag) == 0);
B2R = blockproc(BR,[8 8],setz);
invdct = @(block_struct)  idct2(block_struct.data);
I2R = blockproc(B2R,[8 8],invdct);



dct = @(block_struct) dct2(block_struct.data);
BG = blockproc(G,[8 8],dct);
setz=blockproc(BG,[8 8],@(block_struct) block_struct.data(abs(block_struct.data) < mag) == 0);
B2G = blockproc(BG,[8 8],setz);
invdct = @(block_struct)  idct2(block_struct.data);
I2G = blockproc(B2G,[8 8],invdct);



dct = @(block_struct) dct2(block_struct.data);
BB = blockproc(B,[8 8],dct);
setz=blockproc(BB,[8 8],@(block_struct) block_struct.data(abs(block_struct.data) < mag) == 0);
B2B = blockproc(BB,[8 8],setz);
invdct = @(block_struct)  idct2(block_struct.data);
I2B = blockproc(B2B,[8 8],invdct);

L=cat(3,I2R,I2G,I2B);
L=uint8(L);
imshow(L);
imwrite(L,'DCTcompressedimage.jpg');
