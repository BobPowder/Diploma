%������� ������ ����� ����������� ���������
clear;

%��������� - �����������
global strategy;
strategy=2; 

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
portraitimages = zeros(MyJpgPortraitsFilesQuantity, 10000*palitra);
global pictureimages;
pictureimages = zeros(MyJpgPicturesFilesQuantity, 10000*palitra);


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
    MToDisplay=rgb2gray(imresize(imread(['��������/', MyJpgPortraitsFiles(i).name]), [100 100]));
		
    %������� �������� ������� �� ���� uint8 � ��� double
    %MToDisplay=double(MToDisplay);
	
   
    %������� ������� � ������-������
    V(:,:,1)=reshape(MToDisplay, 1, 10000);
	
    %������� �������-������ � �������� ������-������
    for m=1:1:10000
		portraitimages(i, (m-1)*palitra + fix(V(1, m, 1)/(256/palitra)) + 1)=true;
    end

    %���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������) 
    for k=1:100
		for l=1:100
			notpreparedportraitimages(i,k,l, 1)=fix(MToDisplay(k, l, 1)/(256/palitra))*fix(256/palitra);
		end
	end
end

for i = 1 : MyJpgPicturesFilesQuantity
	%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
	%������������� ��������, �������� � ������ ����� ������� ������� ��������������
	%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
    MToDisplay=rgb2gray(imresize(imread(['�������/', MyJpgPicturesFiles(i).name]), [100 100]));
   
    %������� ������� � ������-������
     V(:,:,1)=reshape(MToDisplay, 1, 10000);
	
    %������� �������-������ � �������� ������-������
    for m=1:1:10000
		pictureimages(i, (m-1)*palitra + fix(V(1, m, 1)/(256/palitra)) + 1)=true;
    end

    %���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������) 
    for k=1:100
		for l=1:100
			notpreparedpictureimages(i,k,l, 1)=fix(MToDisplay(k, l, 1)/(256/palitra))*fix(256/palitra);
		end
	end
end


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






MainMenu;