clear;
clc;

 

% Start of PCA code,

Data = imread('originalimage.jpg');   
Data_R = Data( :, :, 1);      
Data_RD = double(Data_R);  
Data_G = Data( :, :, 2);      
Data_GD = double(Data_G); 
Data_B = Data( :, :, 3);      
Data_BD = double(Data_B);  
%figure, 
%set(gcf,'numbertitle','off','name','Grayscale Image'), 
%imshow(Data_RD)         
Data_meanR = mean(Data_RD);     
[aR bR] = size(Data_R);
Data_meanNewR = repmat(Data_meanR,aR,1);
DataAdjustR = Data_RD - Data_meanNewR;
cov_dataR = cov(DataAdjustR);  
[VR, DR] = eig(cov_dataR);
V_transR = transpose(VR);
DataAdjust_transR = transpose(DataAdjustR); 
FinalDataR = V_transR * DataAdjust_transR;  

%figure, 
%set(gcf,'numbertitle','off','name','Grayscale Image'), 
%imshow(Data_GD)         
Data_meanG = mean(Data_GD);     
[aG bG] = size(Data_G);
Data_meanNewG = repmat(Data_meanG,aG,1);
DataAdjustG= Data_GD - Data_meanNewG;
cov_dataG = cov(DataAdjustG);  
[VG, DG] = eig(cov_dataG);
V_transG = transpose(VG);
DataAdjust_transG = transpose(DataAdjustG); 
FinalDataG = V_transG * DataAdjust_transG;  

%figure, 
%set(gcf,'numbertitle','off','name','Grayscale Image'), 
%imshow(Data_GD)         
Data_meanB = mean(Data_BD);     
[aB bB] = size(Data_B);
Data_meanNewB = repmat(Data_meanB,aB,1);
DataAdjustB= Data_BD - Data_meanNewB;
cov_dataB = cov(DataAdjustB);  
[VB, DB] = eig(cov_dataB);
V_transB = transpose(VB);
DataAdjust_transB = transpose(DataAdjustB); 
FinalDataB = V_transB * DataAdjust_transB; 

% End of PCA code

% Start of Inverse PCA code,
OriginalData_transR = inv(V_transR) * FinalDataR;                        
OriginalDataR = transpose(OriginalData_transR) + Data_meanNewR;          
%figure,
%set(gcf,'numbertitle','off','name','RecoveredImage'),
%imshow(OriginalDataR)      
% End of Inverse PCA code

% Start of Inverse PCA code,
OriginalData_transG = inv(V_transG) * FinalDataG;                        
OriginalDataG = transpose(OriginalData_transG) + Data_meanNewG;          
%figure,
%set(gcf,'numbertitle','off','name','RecoveredImage'),
%imshow(OriginalDataG)      
% End of Inverse PCA code

% Start of Inverse PCA code,
OriginalData_transB = inv(V_transB) * FinalDataB;                        
OriginalDataB = transpose(OriginalData_transB) + Data_meanNewB;          
%figure,
%set(gcf,'numbertitle','off','name','RecoveredImage'),
%imshow(OriginalDataB)      
% End of Inverse PCA code


% Image compression

PCs=input('Enter number of PC colomuns needed?  ');                   
PCsR = bR - PCs;                                                        
Reduced_VR = VR;                                                        

PCsG = bG - PCs;                                                        
Reduced_VG = VG;                                                        

PCsB = bB - PCs;                                                        
Reduced_VB = VB;                                                        

for i = 1:PCsR,                                                        
  Reduced_VR(:,1) =[];
end

for i = 1:PCsG,                                                        
  Reduced_VG(:,1) =[];
end

for i = 1:PCsB,                                                        
  Reduced_VB(:,1) =[];
end

YR=Reduced_VR'* DataAdjust_transR;                                       
Compressed_DataR=Reduced_VR*YR;                                          
Compressed_DataR = Compressed_DataR' + Data_meanNewR;                    

YG=Reduced_VG'* DataAdjust_transG;                                       
Compressed_DataG=Reduced_VG*YG;                                          
Compressed_DataG = Compressed_DataG' + Data_meanNewG;                    

YB=Reduced_VB'* DataAdjust_transB;                                       
Compressed_DataB=Reduced_VB*YB;                                          
Compressed_DataB = Compressed_DataB' + Data_meanNewB;                    

H=cat(3,Compressed_DataR,Compressed_DataG,Compressed_DataB);
figure;
imshow(uint8(H));
imwrite(uint8(H),sprintf('pcacompressedimage%02d.jpg',PCs),'jpg');
%figure,                                                               
%set(gcf,'numbertitle','off','name','Compressed Image'), 
%imshow(Compressed_DataR)