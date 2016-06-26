function BegimProgramGrey()
%������� ������ ����� ����������� ���������
clear;

%��������� - �����������
global strategy;
strategy=2; 

%���� ������������� ��������� �������� ������ �����,
%������� ����� ����������� � �������
global palitra;
palitra=16;

%�������� ������ ��������

%images - ������ ��������� ����������� �����������, ������������ � �������� ����������.
%������ ������ - ����� �����������.
%������ ������ - ������ �������� ����������, ��������������� ������ �����������
%�������� ������� - �������� �������� ������ �������� ����������, ��������������� ������ �����������
global portraitimages;
global pictureimages;

%notpreparedimages - ������ ��������� ����������� �����������, ������� � ����������� �� ������ � �������� ������
%������ ���������� - ����� �����������
%������ � ������ ���������� - ���������� ������� ������� �����������
%�������� ������� - ���� ������� ������� ������� �����������
global notpreparedportraitimages;
global notpreparedpictureimages;

%V -  ������, ��������  �����������. ��������� ��� ����������
%������� images
%������ ������ V - ����� �������� �������� ����������.
%�������� V - �������� �������� �������� ����������
V = zeros(1, 10000);

% �������� ��������� ��������� ��������� � ������
global portraitanswers;
global pictureanswers;

[portraitimages, notpreparedportraitimages, pictureanswers]=tobk(palitra, portraitimages, notpreparedportraitimages, pictureanswers, '��������/', '�������� (��������)/');
[pictureimages, notpreparedpictureimages, pictureanswers]=tobk(palitra, pictureimages, notpreparedpictureimages, pictureanswers, '�������/', '������� (��������)/');

MainMenu;
end

function [images, notpreparedimages, answers]=tobk(palitra, images, notpreparedimages, answers, imagesPath, answersPath)
	% ����� jpg-������ � ���������� imagesPath
	% � ���������� ���-�� ��������� ������
	MyJpgFiles=dir([imagesPath, '*.jpg']);
	MyJpgFilesQuantity=length(MyJpgFiles);
	
	%���������� �������� images � notpreparedimages ������
	images = zeros(MyJpgFilesQuantity, 10000*palitra);
	notpreparedimages = zeros(MyJpgFilesQuantity, 100, 100);
	
	%������ � ������ ��������� ������������
	for i = 1 : MyJpgFilesQuantity
		%��������� ��������� ��������, ������ �� jpg-�����. ������ �������� ��
		%������������� ������ ����� ������� ������� ��������������
		%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
		MToDisplay=rgb2gray(imresize(imread([imagesPath, MyJpgFiles(i).name]), [100 100]));
	   
		%������� �������� ������� �� ���� uint8 � ��� double
		MToDisplay=double(MToDisplay);
		
		%������� ������� � ������-������
		 V(:,:)=reshape(MToDisplay, 1, 10000);
		
		%������� �������-������ � �������� ������-������
		for m=1:1:10000
			images(i, (m-1)*palitra + fix(V(1, m, 1)/(256/palitra)) + 1)=true;
		end

		%���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������) 
		for k=1:100
			for l=1:100
				notpreparedimages(i,k,l)=fix(MToDisplay(k, l, 1)/(256/palitra))*fix(256/palitra);
			end
		end

		images=double(images);
		answers=[];
		
		% ����� txt-������ � ���������� answersPath
		% � ���������� ���-�� ��������� ������
		MyTxtFiles=dir([answersPath, '*.txt']);
		MyTxtFilesQuantity=length(MyTxtFiles);
		%������ � ������ ��������� ��������� �����������
		for i = 1 : MyTxtFilesQuantity
			%������ ������ ������ �� ����� � ����������� � ��������������� ������ �������
			fileID = fopen([answersPath, MyTxtFiles(i).name]);
			buf = textscan(fileID, '%s','delimiter','\n');
			answers{i} = buf{1};
			fclose(fileID);
		end
	end
end