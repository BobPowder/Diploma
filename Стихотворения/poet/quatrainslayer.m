% ������� ��������� �� ���� ������ �� ������������� ���������
% �������������, �� ������������� ����������� �������������
% � ������ ��� �������������
% � ���������� �� ������������ �������������
function [testpoembk] = quatrainslayer(quatrainsmatrix, ...
    testquatrainsbk, thresholds)
% �� �������������
testpoembk = zeros(20*4, 1);
% ��� ������� �������������
for i = 1 : length(thresholds)
    % ����������� ������� �� ��������� ������������� � ���������
    res = quatrainsmatrix(:, :, i) * testquatrainsbk(:, i);
    for j = 1 : length(res)
        % ���� ������� ����� ���������� ������ �������������
        if res(j) >= thresholds(i)
            % �� ���������� ��� � �� ��������� �������������
            testpoembk((i-1)*20+j) = 1;
        end
    end
end
