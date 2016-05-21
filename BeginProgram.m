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
MyJpgFiles=dir('������/*.jpg');
MyJpgFilesQuantity=length(MyJpgFiles);

%�������� ������ ��������

%images - ������ ��������� �����������, ������������ � �������� ����������.
%������ ������ - ����� �����������.
%������ ������ - ������ �������� ����������, ��������������� ������ �����������
%�������� ������� - �������� �������� ������ �������� ����������, ��������������� ������ �����������
global images;
images = zeros(MyJpgFilesQuantity, 10000*palitra*3);

%notpreparedimages - ������ ���������� �����������, ������� � ����������� �� ������ � �������� ������
%������ ���������� - ����� �����������
%������ � ������ ���������� - ���������� ������� ������� �����������
%�������� ������� - ���� ������� ������� ������� �����������
global notpreparedimages;
notpreparedimages = zeros(MyJpgFilesQuantity, 100, 100, 3);

%V -  ������, ��������  �����������. ��������� ��� ����������
%������� images
%������ ������ V - ����� �������� �������� ����������.
%������ ������ V - ���� �����������
%�������� V - �������� �������� �������� ����������
V = zeros(1, 10000, 3);
%V = double(V);



%������ � ������ ��������� ������������
for i = 1 : MyJpgFilesQuantity
	%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
	%������������� ��������, �������� � ������ ����� ������� ������� ��������������
	%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
    MToDisplay=imresize(imread(['������/', MyJpgFiles(i).name]), [100 100]);

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

%palitra*3*(1-1) + fix(V(1, 1, 1)/fix(256/4)) + palitra*(1-1) + 1
%images(1,palitra*3*(1-1) + fix(V(1, 1, 1)/fix(256/4)) + palitra*(1-1) + 1)


% ������� images � ���� double
images=double(images);

global answers;
answers=[];
MyTxtFiles=dir('������ (��������)/*.txt');
<<<<<<< HEAD

MyTxtFilesQuantity=length(MyTxtFiles);
for i = 1 : MyTxtFilesQuantity
	fileID = fopen(['������ (��������)/', MyTxtFiles(i).name]);
	buf = textscan(fileID, '%s','delimiter','\n');
	answers{i} = buf{1};
	fclose(fileID);
=======
MyTxtFiles
MyTxtFilesQuantity=length(MyTxtFiles);
for i = 1 : MyTxtFilesQuantity
	answers{i} = textread(['������ (��������)/', MyTxtFiles(i).name]', '%s', 1);
>>>>>>> origin/master
end
% �������� ��������� ��������� ��������� 

MainMenu;