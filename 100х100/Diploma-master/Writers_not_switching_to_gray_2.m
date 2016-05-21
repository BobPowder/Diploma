%������� ������ ����� ����������� ���������
clear;
%���� ������������� ���������� �������� ������ �����
palitra=input('������� ���������� �������� ��������, �������� � ������ �����, ����������� � �������: ');

%�������� �������
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
images = zeros(38, 10000);
notpreparedimages = zeros(38, 100, 100);


%������ � ������ ��������� ������������
for i = 1 : 38
    %��������� ����������� ����������� 100*100 � �������� map
    MToDisplay=rgb2ind(imresize(imread(['E:\MatlabWriters\������\', ...
        int2str(i), '.jpg']), [100 100]), map, 'nodither' );

    %���������� ����������� � ����� 
    imwrite(MToDisplay, map, ['E:\MatlabWriters\����������\', ...
        int2str(i), '.jpg']);
    %���������� ����������� �������, ��� ������(���� �������� ����������� ����� ����������) 
    notpreparedimages(i,:,:)=MToDisplay(:, :);
    %������� ������� � ������-������
    images(i,:)=reshape(MToDisplay, 1, 10000);
end

% �������� ��������� ��������� ��������� 
answers{1}  = ['1.  �����'];
answers{2}  = ['2.  ����'];
answers{3}  = '3.   ������';
answers{4}  = '4.   �����';
answers{5}  = '5.   �����';
answers{6}  = '6.   ������������';
answers{7}  = ['7.  ��������'];
answers{8}  = ['8.  ������'];
answers{9}  = '9.   ��������';
answers{10}  = ['10.  ������'];
answers{11}  = ['11.  ���������'];
answers{12}  = '12.   ������';
answers{13}  = '13.   ����������';
answers{14}  = '14.   ��������';
answers{15}  = '15.   ���������';
answers{16}  = ['16.  ������'];
answers{17}  = ['17.  ��������'];
answers{18}  = '18.   ������';
answers{19}  = '19.   ��������';
answers{20}  = '20.   ��������';
answers{21}  = '21.   ������';
answers{22}  = '22.   ������';
answers{23}  = '23.   ��������';
answers{24}  = '24.   ����������';
answers{25}  = '25.   ��������';
answers{26}  = '26.   ����������';
answers{27}  = '27.   ����';
answers{28}  = '28.   ��������';
answers{29}  = '29.   ���������';
answers{30}  = '30.   ������';
answers{31}  = '31.   ��������';
answers{32}  = '32.   �������';
answers{33}  = '33.   ���������';
answers{34}  = '34.   ������';
answers{35}  = '35.   �����';
answers{36}  = '36.   ������';
answers{37}  = '37.   �����';
answers{38}  = '38.   �������';
   
%transposedimages=images.'
%mat=images*transposedimages;
%[x,y]=meshgrid(1:1:38, 1:1:38);
%surf(x,y,mat);

%������ � �������� ������������ (����������� ������ � ���������)
testimage=reshape(rgb2ind(imresize(imread(['E:\MatlabWriters\������\test', ...
    '.jpg']), [100 100]), map, 'nodither' ), 10000, 1);

% ��������� ������� ������������ ��������� ����������� ���������
res = zeros(10000, 1);
for i = 1 : 38
    for j = 1 : length(testimage)
        if (images(i, j) == testimage(j,1)) 
            res(i, 1) =  res(i, 1) + 1;
        end
    end 
end

% ���� ����������� ������� � ���������� �������
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
    %������� �����������, ���� ����� ��������
     result = zeros(100, 100);
     for i=1:1:100
         result(i, :)=notpreparedimages(imax,i,:)
     end
    imshow(result, map);
    result = answers{imax};
else
    %����� ����������� �� ����������
    result = '�� ������� ����������';
end

disp (['�����: ', result]);