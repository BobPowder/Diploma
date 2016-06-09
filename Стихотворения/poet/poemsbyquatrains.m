% ����� ���� � �������������
wordlength = 8;
% �������� ���������� ��� ������������� ��������� �������������
% 1 ��������� - ���������� �������������
% 2 ��������� - ����� �� �������������
% 3 ��������� - ���������� ������������� � �������������
quatrainmatrix = zeros(20, 2*4*33*wordlength, 4);
% ������ �������������
poemstext = cell(1, 20);
for i = 1 : 20
    % ��������� �� � ������ � �������
    [poemstext{i}, poembk] = ...
        openpoem(['poetry/', int2str(i), '.txt'], wordlength);
    % ���������� �� ����� � �� �������������
    for k = 1 : 4
        quatrainmatrix(i, :, k) ...
            = [poembk{(k-1)*4+1}, poembk{(k-1)*4+2}, ...
            poembk{(k-1)*4+3}, poembk{(k-1)*4+4}];
    end
end
% �������� ���������� �������������
% 1 - ���������� �������������
% 2 - ����� ����� ������������� (����� �� �������������)
poemsmatrix = zeros(20, 20*4);
% ���������� ��
for i = 1 : 20
    for j = 1 : 4
        poemsmatrix(i, (j-1)*20+i) = 1;
    end
end

% ������ ������������� ��� �������������, ��������� �� ��� ����� �
% ������ ��� �������������
[linesbk, thresholds] = inputpoem(wordlength, 4);
% �� �������������
testquatrainsbk = zeros(2*4*33*wordlength, 4);
% ���������� �� ����� � �� �������������
for i = 1 : 4
    testquatrainsbk(:, i) = [linesbk{(i-1)*4+1}, ...
        linesbk{(i-1)*4+2}, linesbk{(i-1)*4+3}, ...
            linesbk{(i-1)*4+4}];
end
% ������� �� ������������ �������������
testpoembk = quatrainslayer(quatrainmatrix, testquatrainsbk, ...
    thresholds);
% ���������� ������������� � ������� �����
lastlayer(poemsmatrix, testpoembk, 4, poemstext);
