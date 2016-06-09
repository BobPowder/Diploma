
% ������� ��������� ����������� � ����� ����
% � ���������� �������� ����������
function [bk] = tobk(sentence, wordlength)
if nargout ~= 1 || nargin ~= 2 || ~ischar(sentence) ... 
    || wordlength < 1
    error('�������� ���������');
end
% �������� ����������
bk = zeros(1, 33*wordlength*2);
% ���� ������ �����, �� �� �� ������� �� �����
if isempty(sentence)
    return;
end
% ��������� ����������� �� �����

words = tokenizeString(sentence, ' ,�-�!?"():;.�');
%words = textscan(sentence, ['%', int2str(2*wordlength), 's'], ...
%    'Delimiter', ' ,�-�!?"():;.�');

for i = 1 : length(words)
    % ���� ������ _ �������� �� ����� ����� �� _
    if ~isempty(words{i}) && words{i}(1) == '_'
        for j = 2 : wordlength
            words{i}(j) = '_';
        end
    end
    % ���� ����� ������� �������, ������� ������
    if length(words(i)) > wordlength
		
        error(['������� ������� �����: ', words(i)]);
    end
end
% ����� ������ �� ���������������� � ������������ �������
result = '';
% ������� ������������ ����� ����� ������
linelength = wordlength;
% �������� ���������� ����� � ������ �� ����� wordlength ����
% � ��������� �� ������� �
for i = 1 : length(words)
    if length(result) + length(words{i}) > linelength
        for j = length(result) + 1 : linelength
            result(j) = '�';
        end
        linelength = linelength + wordlength;
    end
    result = strcat(result, words{i});
end
% ���� ������ ���������� ������� �������, ������� ������
if length(result) > wordlength*2
	result
	length(result)
    error(['������� ������� ������: ', sentence]);
end
% ��������� ������ �� ������ �����
for j = length(result) + 1 : wordlength*2
    result(j) = '�';
end
% ��������� ����������� � �������� ����������
for i = 1 : 2*wordlength
    if (result(i) >= '�' && result(i) <= '�')
        bk(33*(i-1)+result(i)-'�'+1) = 1;
    elseif (result(i) == '�')
        bk(33*(i-1)+8) = 1;
    elseif (result(i) >= '�' && result(i) <= '�')
        bk(33*(i-1)+result(i)-'�'+2) = 1;
    elseif (result(i) >= '�' && result(i) <= '�')
        bk(33*(i-1)+result(i)-'�'+1) = 1;
    elseif (result(i) == '�')
        bk(33*(i-1)+8) = 1;
    elseif (result(i) >= '�' && result(i) <= '�')
        bk(33*(i-1)+result(i)-'�'+2) = 1;
    elseif (result(i) == '�' || result(i) == '�')
        bk(33*(i-1)+18) = 1;
    end
end
