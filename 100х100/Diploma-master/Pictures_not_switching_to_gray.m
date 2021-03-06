%������� ������ ����� ����������� ���������
clear;
%���� ������������� ��������� �������� ��������, �������� � ������ �����,
%������� ����� ����������� � �������
palitra=input('������� ���������� �������� ��������, �������� � ������ �����, ����������� � �������: ');

%�������� ������� ��������, �� ������ ������� ������������ ����������� ����� ���������� � ����������
map=zeros(palitra^3, 3);
for k=1:palitra
    for j=1:palitra
        for i=1:palitra
            map((k-1)*palitra^2+(j-1)*palitra+i, 1)=double((i-1)/(palitra-1));
            map((k-1)*palitra^2+(j-1)*palitra+i, 2)=double((j-1)/(palitra-1));
            map((k-1)*palitra^2+(j-1)*palitra+i, 3)=double((k-1)/(palitra-1));
        end
    end
end


%�������� ������ ��������

%images - ������ ���������� ��������� �����������, ������������ � �������� ����������.
%������ ���������� - ����� �����������.
%������ ���������� - ����� �������� �������� ����������, ��������������� ������ �����������
%�������� ������� - �������� �������� ������ �������� ����������, ��������������� ������ �����������
images = zeros(10, 10000*(palitra^3));

%notpreparedimages - ������ ���������� �����������, ������� � ����������� �� ������ � �������� ������
%������ ���������� - ����� �����������
%������ � ������ ���������� - ���������� ������� ������� �����������
%�������� ������� - ���� ������� ������� ������� �����������
notpreparedimages = zeros(10, 100, 100);

%Buf -  ������, ��������  �����������, ����������� �� ���������� ������� � ������-������. ��������� ��� ����������
%������� images
%����� ������ ��������� ���� �������� ����������� ��������� �����������, ������������� � �������� ����������
%������ Buf - ����� �������� �������� ����������.
%�������� Buf - �������� �������� �������� ����������
Buf = zeros(1, 10000*(palitra^3));

%������ � ������ ��������� ������������
for i = 1 : 10
	%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
	%������������� ��������, �������� � ������ ����� ������� ������� ��������������
	%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
	%����� ������������ ����������� ���������� � ����������� � ��������, ��������� ����
    MToDisplay=rgb2ind(imresize(imread(['������ �������\', ...
        int2str(i), '.jpg']), [100 100]), map, 'nodither' );

    %���������� ����������� � �����, ����� ���������, ��� ��� ����������� ����������� ��������� � ����������
    imwrite(MToDisplay, map, ['����������\', ...
        int2str(i), '.jpg']);
		
    %������� �������� ������� �� ���� int � ��� double
    MToDisplay=double(MToDisplay);
	
    %���������� ����������� ������� ��� ������ (���� �������� ����������� ����� ����������) 
    notpreparedimages(i,:,:)=MToDisplay(:, :);
	
    %������� ������� � ������-������
    Buf=reshape(MToDisplay, 1, 10000);
	
    %������� �������-������ � �������� ������-������
    for m=1:1:10000
        images(i, (m-1)*(palitra^3) + Buf(1, m) + 1)=true;
    end
end

% ������� images � ���� double
images=double(images);

% �������� ��������� ������ 
answers{1}  = '1.  ��� ��� "�������� ����"';
answers{2}  = '2.  �������� "��������"';
answers{3}  = '3.  ���� "����������� ������"';
answers{4}  = '4.  ������-������ "������� �������� ����"';
answers{5}  = '5.  �������� "�����������"';
answers{6}  = '6.  ����� "���� ������� � ��� ���"';
answers{7}  = '7.  ����� "��������� ����� ������ ��������� �������"';
answers{8}  = '8.  ������������ "���������� �����"';
answers{9}  = '9.  ������� "�������� ����"';
answers{10}  = '10.  �� ����� "���� ����"';

   

%��� ����� ���� �������� �� ���������� � ����� �� ����� �������
%������� ��������(���������� ����������� ��������) ������� ����������� � ������.
%transposedimages=images.'
%mat=images*transposedimages;

%[x,y]=meshgrid(1:1:10, 1:1:10);
%surf(x,y,mat);


%������ � �������� ������������
%��������� ������ �� ���� ��������� ��������, ������ �� jpg-�����. ������ ������ �������� ��
%������������� ��������, �������� � ������ ����� ������� ������� ��������������
%����� ���� ������� ����������� N*N � ������� 100*100 �� ������ ���������� ������
%����� ������������ ����������� ���������� � ����������� � ��������, ��������� ���� 
Buf=reshape(rgb2ind(imresize(imread(['������ �������\test', ...
    '.jpg']), [100 100]), map, 'nodither' ), 10000, 1);
	
%������� �������� ������� �� ���� int � ��� double
Buf=double(Buf);

%�������� �������-������� testimage, ������� ����� ������� �������� ���������� ��������� �����������
testimage = zeros(10000*(palitra^3), 1);

%���������� �������-������� testimage
for m=1:1:10000
    testimage((m-1)*(palitra^3) + Buf(m, 1) + 1, 1)=true;
end
testimage=double(testimage);


% ����������� ��������� � �������� ��
% ����������� ����� ������-�������, ��� ������ �������� ����� �������
% ���������� �������� �������� �����������, ����������� � ���������������� 
% ��������� ��������� �����������
res = images * testimage;

% ���� ����������� ������� � ���������� �������,
% �. �. �������� ������ ��������� ����������� �
% ��������
max = 0;
imax = 0;
for i = 1 : length(res)
    if res(i) > max
        max = res(i);
        imax = i;
    end;
end

%��������� ����� ��������
threshold=9800;

if max > threshold
    %������� ����������� �� �����, ���� ����� ��������
     result = zeros(100, 100);
     for i=1:1:100
         result(i, :)=notpreparedimages(imax,i,:);
     end
    imshow(result, map);
    result = answers{imax};
else
    %����� ������� � ������� ����������� �� ����������
    result = '�� ������� ����������';
end

%����� ����������
disp (['�����: ', result]);