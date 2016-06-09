
% ������� ��������� �� ���� ��� ����� ������������� � ����� ����
% � ���������� ��� ����� � �������� ���������� ��� �����
function [poem, poembk] = openpoem(filename, wordlength)
if nargout > 2 || nargin ~= 2 || ~ischar(filename) ...
        || isempty(filename) || wordlength < 1
    error('�������� ���������');
end
% ��������� ���� �� ��������������
[poemfile, err] = fopen(filename, 'rt');
if ~isempty(err)
    error([filename, ': ', err]);
end
% ������ �������������
poem{16} = [];
% �������� ���������� ��� �����
poembk{16} = [];
poem = textscan(poemfile, '%s','delimiter','\n');
for i = 1 : 16
	% ���������� ������ ������ � ������
    %poem{i} = fgetl(poemfile);
    % � ������ ������ ����� ��
    poembk{i} = tobk(poem{1}{i}, wordlength);
end
% ��������� ����
fclose(poemfile);
poem=poem{1};
