% ����� ���� � �������������
wordlength = 9;
% �������� ���������� ��������� �������������
% 1 ��������� - ���������� �������������
% 2 ��������� - ����� �� �������������
poemsmatrix = zeros(20, wordlength*33*32);
% ������ �������������
poemstext = cell(1, 20);
for i = 1 : 20
    % ��������� ������ � �� � �������
    [poemstext{i}, poembk] = ...
        openpoem(['poetry/', int2str(i), '.txt'], wordlength);
    % ���������� �� ������������� �� �� �����
    for j = 1 : 16
        poemsmatrix(i, ...
            (j-1)*wordlength*2*33+1 : j*wordlength*2*33) ...
                = poembk{j};
    end
end

% ������ ������������� ��� �������������, ��������� �� ��� �����
% � �����
[linesbk, threshold] = inputpoem(wordlength, 1);

% ������ ������ ��������� ������
for first = 1 : 16
	if  sum(linesbk{first})~=0
		break
	end
end
first
% ������ ��������� ��������� ������
for last = 1 : 16
	if  sum(linesbk{16-last+1})~=0
		break
	end
end
last=16-last+1

% �� �������������
testbk = zeros(wordlength*33*32, 1);
% ���������� �� ����� � �� �������������
for i = 1 : 16
    testbk((i-1)*wordlength*2*33+1 : i*wordlength*2*33) ...
        = linesbk{i};
end

% ������� ������������ �������� �������������
a=1;
while a<=16-(last-first)
	testbk = zeros(wordlength*33*32, 1);
	i=1;
	while i<=(last-first+1)
%		linesbk{first+i-a}
		testbk((i+a-2)*wordlength*2*33+1 : (i+a-1)*wordlength*2*33) ...
			= linesbk{first+i-1};
		i=i+1;
	end
	% ���������� ������������� � ������� �����
	result=lastlayer(poemsmatrix, testbk, threshold, poemstext);
	if (result==true)
		break;
	end;
	a=a+1;
end

if (result==false)
   disp('������������� ����������� � ����');
end


