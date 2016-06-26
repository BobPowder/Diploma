function BeginProgramBlack()
%������� ������ ����� ����������� ���������
clear;

%��������� - �����������
global strategy;
strategy=3; 

%V -  ������, ��������  �����������. ��������� ��� ����������
%������� images
%������ ������ V - ����� �������� �������� ����������.
%������ ������ V - ���� �����������
%�������� V - �������� �������� �������� ����������
V = zeros(1, 10000);


%�������� ������ ��������

%images - ������ ��������� �����������, ������������ � �������� ����������.
%������ ������ - ����� �����������.
%������ ������ - ������ �������� ����������, ��������������� ������ �����������
%�������� ������� - �������� �������� ������ �������� ����������, ��������������� ������ �����������
global portraitimages;
global pictureimages;
global ECGimages;


%notpreparedimages - ������ ���������� �����������, ������� � ����������� �� ������ � �������� ������
%������ ���������� - ����� �����������
%������ � ������ ���������� - ���������� ������� ������� �����������
%�������� ������� - ���� ������� ������� ������� �����������
global notpreparedportraitimages;
global notpreparedpictureimages;
global notpreparedECGimages;


%answers - ������, �������� �������� ���������������� ����������� � ���� ������.
%������ - ����� ���������� �����������
%�������� - ������ �������� �����������
global portraitanswers;
global pictureanswers;
global ECGanswers;

%���������� �������� images, notpreparedimages � portraitanswers
[portraitimages, notpreparedportraitimages, portraitanswers] = tobk(portraitimages, notpreparedportraitimages, portraitanswers, '��������/', '�������� (��������)/');
[pictureimages, notpreparedpictureimages, pictureanswers] = tobk(pictureimages, notpreparedpictureimages, pictureanswers, '�������/', '������� (��������)/');
[ECGimages, notpreparedECGimages, ECGanswers] = tobk(ECGimages, notpreparedECGimages, ECGanswers, '���/', '��� (��������)/');

MainMenu;
end

function [images, notpreparedimages, answers]=tobk(images, notpreparedimages, answers, imagesPath, answersPath)
	% ����� jpg-������ � ���������� imagesPath
	% � ���������� ���-�� ��������� ������
	MyJpgFiles=dir([imagesPath, '*.jpg']);
	MyJpgFilesQuantity=length(MyJpgFiles);
	
	%���������� �������� images � notpreparedimages ������
	images = zeros(MyJpgFilesQuantity, 10000);
	notpreparedimages = zeros(MyJpgFilesQuantity, 100, 100);
	
	%������ � ������ ��������� ������������
	for i = 1 : MyJpgFilesQuantity
		%��������� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
		%�������/���������� ������ ����� ������� ������� ��������������.
		%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������.
		MToDisplay=im2bw(imresize(imread([imagesPath, MyJpgFiles(i).name]), [100 100]), 0.5);

		%������� ������� � ������-������
		V(:,:)=reshape(MToDisplay, 1, 10000);
		
		%������� �������-������ � �������� ������-������ 
		for m=1:1:10000
			images(i, m)=~V(1,m);
		end
		
		%���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������)
		notpreparedimages(i, :, :)=MToDisplay;
	end

	notpreparedimages=logical(notpreparedimages);
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