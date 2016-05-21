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
MyJpgFiles=dir('������/*.jpg');
MyJpgFilesQuantity=length(MyJpgFiles);

%�������� ������ ��������

%images - ������ ��������� �����������, ������������ � �������� ����������.
%������ ������ - ����� �����������.
%������ ������ - ������ �������� ����������, ��������������� ������ �����������
%�������� ������� - �������� �������� ������ �������� ����������, ��������������� ������ �����������
global images;
images = zeros(MyJpgFilesQuantity, 10000*palitra);

%notpreparedimages - ������ ���������� �����������, ������� � ����������� �� ������ � �������� ������
%������ ���������� - ����� �����������
%������ � ������ ���������� - ���������� ������� ������� �����������
%�������� ������� - ���� ������� ������� ������� �����������
global notpreparedimages;
notpreparedimages = zeros(MyJpgFilesQuantity, 100, 100, 1);

%V -  ������, ��������  �����������. ��������� ��� ����������
%������� images
%������ ������ V - ����� �������� �������� ����������.
%������ ������ V - ���� �����������
%�������� V - �������� �������� �������� ����������
V = zeros(1, 10000, 1);
%V = double(V);



%������ � ������ ��������� ������������
for i = 1 : MyJpgFilesQuantity
	%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
	%������������� ��������, �������� � ������ ����� ������� ������� ��������������
	%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
    MToDisplay=rgb2gray(imresize(imread(['������/', MyJpgFiles(i).name]), [100 100]));

		
    %������� �������� ������� �� ���� uint8 � ��� double
    %MToDisplay=double(MToDisplay);
	
   
    %������� ������� � ������-������
    V(:,:,1)=reshape(MToDisplay, 1, 10000);
    
	
    %������� �������-������ � �������� ������-������
	for m=1:1:10000
		images(i, (m-1)*palitra + fix(V(1, m, 1)/(256/palitra)) + 1)=true;
    end
	
	%for j = 1:3
    %    for k=1:10000
    %        images(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
    %    end
    %end
	
    %���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������) 
	for k=1:100
		for l=1:100
			notpreparedimages(i,k,l, 1)=fix(MToDisplay(k, l, 1)/(256/palitra))*fix(256/palitra);
		end
	end
end

%palitra*3*(1-1) + fix(V(1, 1, 1)/fix(256/4)) + palitra*(1-1) + 1
%images(1,palitra*3*(1-1) + fix(V(1, 1, 1)/fix(256/4)) + palitra*(1-1) + 1)


% ������� images � ���� double
images=double(images);

global answers;
answers=[];
MyTxtFiles=dir('������ (��������)/*.txt');
%MyTxtFiles
MyTxtFilesQuantity=length(MyTxtFiles);
for i = 1 : MyTxtFilesQuantity
	fileID = fopen(['������ (��������)/', MyTxtFiles(i).name]);
	buf = textscan(fileID, '%s','delimiter','\n');
	answers{i} = buf{1};
	fclose(fileID);
end



% �������� ��������� ��������� ��������� 

MainMenu;