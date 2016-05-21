%���� ������������� ���������� �������� ������ �����
palitra=input('������� ���������� �������� ������');

%�������� ������ ��������
images = zeros(18, 10000*palitra);
notpreparedimages = zeros(18, 100, 100);
Buf = zeros(1, 10000);

%������ � ������ ��������� ������������
for i = 1 : 18
    %��������� ����������� ����������� 100*100 � �������� map
    [MToDisplay, map]=gray2ind(rgb2gray(imresize(imread(['E:\MatlabWriters\������\', ...
        int2str(i), '.jpg']), [100 100])), palitra);
    %���������� ����������� � �����
    imwrite(MToDisplay, map, ['E:\MatlabWriters\����������\', ...
        int2str(i), '.jpg']);
    %������� �������� ������� � ��� double
    MToDisplay=double(MToDisplay);
    %���������� ����������� �������, ��� ������(���� �������� ����������� ����� ����������) 
    notpreparedimages(i,:,:)=MToDisplay;
    %������� ������� � ������-������
    Buf=reshape(MToDisplay, 1, 10000);
    %������� �������-������ � �������� ������-������
    for m=1:1:10000
    images(i, (m-1)*palitra + Buf(1, m) + 1)=true;
    end
end
% ������� � ���� double
images=double(images);

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
   

%������ � �������� ������������ (����������� ������ � ���������)
Buf=reshape(gray2ind(rgb2gray(imresize(imread(['E:\MatlabWriters\������\test', ...
    '.jpg']), [100 100])), palitra), 10000, 1);
Buf=double(Buf);
testimage = zeros(10000*palitra, 1);
for m=1:1:10000
testimage((m-1)*palitra + Buf(m, 1) + 1, 1)=true;
end
testimage=double(testimage);


% ����������� ��������� � �������� ��
res = images * testimage;
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