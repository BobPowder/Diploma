% ������� ��������� �� ���� ������� �� ��������� �������������,
% �� ����������� �������������, ����� � ������ ��������� �������������
function [result] = lastlayer(poemsmatrix, testpoembk, ...
    threshold, poemstext)
% ����������� �� ��������� � ��������� �������������
res = poemsmatrix * testpoembk;
% ������ �� �����
found = false;
for i = 1 : length(res)
    % ���� ������� ������ ���������� ������ �������������
    if res(i) >= threshold
        % �� ������� �������
        found = true;
        % ������� ��������� �������������
        disp('�����:');
        for j = 1 : 16
            disp(poemstext{i}{j});
			result=true;
        end
    end
end
result=false;
% ������� ���
%if ~found
%    disp('������������� ����������� � ����');
%end
