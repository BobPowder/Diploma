function BeginProgram()
%������� ������ ����� ����������� ���������
clear;

%��������� - ������������
global strategy;
strategy=1; 

%palitra - ���������� �������� ��������, �������� � ������ �����,
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
%��������� - ����� ����� (1 - �������, 2 - �������, 3 - �����)
%�������� ������� - ���� ������� ������� ������� �����������
global notpreparedportraitimages;
global notpreparedpictureimages;

%V -  ������, ��������  �����������. ��������� ��� ����������
%������� portraitimages
%������ ������ V - ����� �������� �������� ����������.
%������ ������ V - ���� �����������
%�������� V - �������� �������� �������� ����������
V = zeros(1, 10000, 3);

global portraitanswers;
global pictureanswers;

[portraitimages, notpreparedportraitimages, pictureanswers]=tobk(palitra, portraitimages, notpreparedportraitimages, pictureanswers, '��������/', '�������� (��������)/');
[pictureimages, notpreparedpictureimages, pictureanswers]=tobk(palitra, pictureimages, notpreparedpictureimages, pictureanswers, '�������/', '������� (��������)/');

transposedimages=pictureimages.';
mat=pictureimages*transposedimages;

[x,y]=meshgrid(1:1:30, 1:1:30);
surf(x,y,mat);

%MainMenu;
end

function [images, notpreparedimages, answers]=tobk(palitra, images, notpreparedimages, answers, imagesPath, answersPath)
	% ����� jpg-������ � ���������� imagesPath
	% � ���������� ���-�� ��������� ������
	MyJpgFiles=dir([imagesPath, '*.jpg']);
	MyJpgFilesQuantity=length(MyJpgFiles);
	
	%���������� �������� images � notpreparedimages ������
	images = zeros(MyJpgFilesQuantity, 10000*palitra*3);
	notpreparedimages = zeros(MyJpgFilesQuantity, 100, 100, 3);
	
	
	%������ � ������ ��������� ������������
	for i = 1 : MyJpgFilesQuantity
		%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
		%������������� ��������, �������� � ������ ����� ������� ������� ��������������
		%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
		MToDisplay=imresize(imread([imagesPath, MyJpgFiles(i).name]), [100 100]);
			
		%������� �������� ������� �� ���� uint8 � ��� double
		MToDisplay=double(MToDisplay);
	   
		%������� ������� � ������-������
		for x = 1 : 3
			V(:,:,x)=reshape(MToDisplay(:, :, x), 1, 10000);
		end
		
		%������� �������-������ � �������� ������-������
		for j = 1:3
			for k=1:10000
				images(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
			end
		end

		%���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������) 
		for j = 1:3
			for k=1:100
				for l=1:100
					notpreparedimages(i,k,l,j)=fix(MToDisplay(k, l, j)/(256/palitra))*fix(256/palitra);
				end
			end
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