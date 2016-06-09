%������� ������ ����� ����������� ���������
clear;

%��������� - ������������
global strategy;
strategy=1; 

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

%portraitimages - ������ ��������� �����������, ������������ � �������� ����������.
%������ ������ - ����� �����������.
%������ ������ - ������ �������� ����������, ��������������� ������ �����������
%�������� ������� - �������� �������� ������ �������� ����������, ��������������� ������ �����������
global portraitimages;
portraitimages = zeros(MyJpgPortraitsFilesQuantity, 10000*palitra*3);
global pictureimages;
pictureimages = zeros(MyJpgPicturesFilesQuantity, 10000*palitra*3);

%notpreparedimages - ������ ���������� �����������, ������� � ����������� �� ������ � �������� ������
%������ ���������� - ����� �����������
%������ � ������ ���������� - ���������� ������� ������� �����������
%�������� ������� - ���� ������� ������� ������� �����������
global notpreparedportraitimages;
notpreparedportraitimages = zeros(MyJpgPortraitsFilesQuantity, 100, 100, 3);
global notpreparedpictureimages;
notpreparedpictureimages = zeros(MyJpgPicturesFilesQuantity, 100, 100, 3);

%V -  ������, ��������  �����������. ��������� ��� ����������
%������� portraitimages
%������ ������ V - ����� �������� �������� ����������.
%������ ������ V - ���� �����������
%�������� V - �������� �������� �������� ����������
V = zeros(1, 10000, 3);
%V = double(V);



%������ � ������ ��������� ������������
for i = 1 : MyJpgPortraitsFilesQuantity
	%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
	%������������� ��������, �������� � ������ ����� ������� ������� ��������������
	%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
    MToDisplay=imresize(imread(['��������/', MyJpgPortraitsFiles(i).name]), [100 100]);

    %���������� ����������� � �����, ����� ���������, ��� ��� ����������� ����������� ��������� � ����������
    %imwrite(MToDisplay, ['����������\', int2str(i), '.jpg']);
		
    %������� �������� ������� �� ���� uint8 � ��� double
    %MToDisplay=double(MToDisplay);
	
   
    %������� ������� � ������-������
    for x = 1 : 3
        V(:,:,x)=reshape(MToDisplay(:, :, x), 1, 10000);
    end
	
    %������� �������-������ � �������� ������-������
    for j = 1:3
        for k=1:10000
            portraitimages(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
        end
    end

    %���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������) 
    for j = 1:3
        for k=1:100
            for l=1:100
                notpreparedportraitimages(i,k,l,j)=fix(MToDisplay(k, l, j)/(256/palitra))*fix(256/palitra);
            end
        end
    end
end

%������ � ������ ��������� ������������
for i = 1 : MyJpgPicturesFilesQuantity
	%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
	%������������� ��������, �������� � ������ ����� ������� ������� ��������������
	%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
    MToDisplay=imresize(imread(['�������/', MyJpgPicturesFiles(i).name]), [100 100]);

    %���������� ����������� � �����, ����� ���������, ��� ��� ����������� ����������� ��������� � ����������
    %imwrite(MToDisplay, ['����������\', int2str(i), '.jpg']);
		
    %������� �������� ������� �� ���� uint8 � ��� double
    %MToDisplay=double(MToDisplay);
	
   
    %������� ������� � ������-������
    for x = 1 : 3
        V(:,:,x)=reshape(MToDisplay(:, :, x), 1, 10000);
    end
	
    %������� �������-������ � �������� ������-������
    for j = 1:3
        for k=1:10000
            pictureimages(i,palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
        end
    end

    %���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������) 
    for j = 1:3
        for k=1:100
            for l=1:100
                notpreparedpictureimages(i,k,l,j)=fix(MToDisplay(k, l, j)/(256/palitra))*fix(256/palitra);
            end
        end
    end
end


% ������� images � ���� double
portraitimages=double(portraitimages);
pictureimages=double(pictureimages);

%pictureimages(1:100)

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