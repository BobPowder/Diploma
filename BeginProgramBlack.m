%������� ������ ����� ����������� ���������
clear;

%��������� - �����������
global strategy;
strategy=3; 

%���� ������������� ��������� �������� ��������, �������� � ������ �����,
%������� ����� ����������� � �������
%palitra=input('������� ���������� �������� ��������, �������� � ������ �����, ����������� � �������: ');

global palitra;
palitra=16;
MyJpgPortraitsFiles=dir('��������/*.jpg');
MyJpgPortraitsFilesQuantity=length(MyJpgPortraitsFiles);
MyJpgPicturesFiles=dir('�������/*.jpg');
MyJpgPicturesFilesQuantity=length(MyJpgPicturesFiles);

%�������� ������ ��������

%images - ������ ��������� �����������, ������������ � �������� ����������.
%������ ������ - ����� �����������.
%������ ������ - ������ �������� ����������, ��������������� ������ �����������
%�������� ������� - �������� �������� ������ �������� ����������, ��������������� ������ �����������
global portraitimages;
portraitimages = zeros(MyJpgPortraitsFilesQuantity, 10000);
global pictureimages;
pictureimages = zeros(MyJpgPicturesFilesQuantity, 10000);


%notpreparedimages - ������ ���������� �����������, ������� � ����������� �� ������ � �������� ������
%������ ���������� - ����� �����������
%������ � ������ ���������� - ���������� ������� ������� �����������
%�������� ������� - ���� ������� ������� ������� �����������
global notpreparedportraitimages;
notpreparedportraitimages = zeros(MyJpgPortraitsFilesQuantity, 100, 100, 1);
global notpreparedpictureimages;
notpreparedpictureimages = zeros(MyJpgPicturesFilesQuantity, 100, 100, 1);

%V -  ������, ��������  �����������. ��������� ��� ����������
%������� images
%������ ������ V - ����� �������� �������� ����������.
%������ ������ V - ���� �����������
%�������� V - �������� �������� �������� ����������
V = zeros(1, 10000, 1);
%V = double(V);



%������ � ������ ��������� ������������
for i = 1 : MyJpgPortraitsFilesQuantity
	%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
	%������������� ��������, �������� � ������ ����� ������� ������� ��������������
	%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
    MToDisplay=im2bw(imresize(imread(['��������/', MyJpgPortraitsFiles(i).name]), [100 100]), 0.5);

		
    %������� �������� ������� �� ���� uint8 � ��� double
    %MToDisplay=double(MToDisplay);
	
   
    %������� ������� � ������-������
    V(:,:,1)=reshape(MToDisplay, 1, 10000);
    
	
    %������� �������-������ � �������� ������-������
	for m=1:1:10000
		portraitimages(i, m)=~V(1,m,1);
    end
	
	%for j = 1:3
    %    for k=1:10000
    %        images(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
    %    end
    %end
	
    %���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������)
	notpreparedportraitimages(i, :, :, 1)=MToDisplay;
end

notpreparedportraitimages=logical(notpreparedportraitimages);

%������ � ������ ��������� ������������
for i = 1 : MyJpgPicturesFilesQuantity
	%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
	%������������� ��������, �������� � ������ ����� ������� ������� ��������������
	%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
    MToDisplay=im2bw(imresize(imread(['�������/', MyJpgPicturesFiles(i).name]), [100 100]), 0.5);

		
    %������� �������� ������� �� ���� uint8 � ��� double
    %MToDisplay=double(MToDisplay);
	
   
    %������� ������� � ������-������
    V(:,:,1)=reshape(MToDisplay, 1, 10000);
    
	
    %������� �������-������ � �������� ������-������
	for m=1:1:10000
		pictureimages(i, m)=~V(1,m,1);
    end
	
	%for j = 1:3
    %    for k=1:10000
    %        images(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
    %    end
    %end
	
    %���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������)
	notpreparedpictureimages(i, :, :, 1)=MToDisplay;
end

notpreparedpictureimages=logical(notpreparedpictureimages);


% ������� images � ���� double
portraitimages=double(portraitimages);
pictureimages=double(pictureimages);

% �������� ��������� ��������� ��������� � ������
global portraitanswers;
portraitanswers=[];
global pictureanswers;
pictureanswers=[];


MyTxtPortraitFiles=dir('�������� (��������)/*.txt');
MyTxtPortraitFilesQuantity=length(MyTxtPortraitFiles);
for i = 1 : MyTxtPortraitFilesQuantity
	fileID = fopen(['�������� (��������)/', MyTxtPortraitFiles(i).name]);
	buf = textscan(fileID, '%s','delimiter','\n');
	portraitanswers{i} = buf{1};
	fclose(fileID);
end

MyTxtPictureFiles=dir('������� (��������)/*.txt');
MyTxtPictureFilesQuantity=length(MyTxtPictureFiles);
for i = 1 : MyTxtPictureFilesQuantity
	fileID = fopen(['������� (��������)/', MyTxtPictureFiles(i).name]);
	buf = textscan(fileID, '%s','delimiter','\n');
	pictureanswers{i} = buf{1};
	fclose(fileID);
end


% �������� ��������� ��������� ��������� 

MainMenu;