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
% �� �������������
testbk = zeros(wordlength*33*32, 1);
% ���������� �� ����� � �� �������������
for i = 1 : 16
    testbk((i-1)*wordlength*2*33+1 : i*wordlength*2*33) ...
        = linesbk{i};
end
% ���������� ������������� � ������� �����
lastlayer(poemsmatrix, testbk, threshold, poemstext);
