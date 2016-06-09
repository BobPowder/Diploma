% ����� �����
wordlength = 8;
% �������� ���������� ��� ���� ��������� �������������
% 1 ��������� - ���������� �������������
% 2 ��������� - ����� �� �����
% 3 ��������� - ���������� ���� � �������������
wordsmatrix = zeros(20, wordlength*33, 32);
% ������ �������������
poemstext = cell(1, 20);
for i = 1 : 20
    % ��������� �� � ������ � �������
    [poemstext{i}, poembk] = ...
        openpoem(['poetry/', int2str(i), '.txt'], wordlength);
    % �������� �� ����� �� �� ����
    for k = 1 : 16
        wordsmatrix(i, :, k*2-1) = poembk{k}(1:wordlength*33);
        wordsmatrix(i, :, k*2) ...
            = poembk{k}(wordlength*33+1 : wordlength*2*33);
    end
end
% �������� ���������� ��� ������������� ��������� �������������
% 1 ��������� - ���������� �������������
% 2 ��������� - ����� �� �������������
% 3 ��������� - ���������� ������������� � �������������
quatrainsmatrix = zeros(20, 20*8, 4);
% ���������� ��
for i = 1 : 20
    for j = 1 : 8
        for k = 1 : 4
            quatrainsmatrix(i, (j-1)*20+i, k) = 1;
        end
    end
end
% �������� ���������� �������������
% 1 - ���������� �������������
% 2 - ����� ����� �������������
poemsmatrix = zeros(20, 20*4);
% ���������� ��
for i = 1 : 20
    for j = 1 : 4
        poemsmatrix(i, (j-1)*20+i) = 1;
    end
end

% ������ ������������� ��� �������������, ��������� �� ��� �����
% � �����
[linesbk, thresholds] = inputpoem(wordlength, 32);
% �� ����
testwordsmatrix = zeros(wordlength*33, 32);
% ��������� �� ����� �� �� ����
for i = 1 : 16
    testwordsmatrix(:, i*2-1) = linesbk{i}(1:wordlength*33);
    testwordsmatrix(:, i*2) ...
        = linesbk{i}(wordlength*33+1 : wordlength*2*33);
end
% �� �������������
testquatrainsmatrix = zeros(20*8, 4);
% ��� ������� �����
for i = 1 : 32
    % ����������� ������� �� ��������� ���� � ���������
    res = wordsmatrix(:, :, i) * testwordsmatrix(:, i);
    for j = 1 : length(res)
        % ���� ������� ����� ���������� ����
        if res(j) >= thresholds(i)
            % �� ���������� ��� � �� ��������� �������������
            testquatrainsmatrix(mod(i+1,8)*20+j, ceil(i/8)) = 1;
        end
    end
end
% ������� �� ����������� �������������
testpoembk = quatrainslayer(quatrainsmatrix, ...
    testquatrainsmatrix, [8 8 8 8]);
% ���������� ������������� � ������� �����
lastlayer(poemsmatrix, testpoembk, 4, poemstext);
