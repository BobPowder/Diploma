% ������� ��������� �� ���� ������� �� ��������� �������������,
% �� ����������� �������������, ����� � ������ ��������� �������������
function [] = lastlayer(poemsmatrix, testpoembk, ...
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
        end
    end
end
% ������� ���
if ~found
    disp('������������� ����������� � ����');
end
