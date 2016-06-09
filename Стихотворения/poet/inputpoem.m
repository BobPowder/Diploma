% ������� ��������� �� ���� ����� �����
% � ���������� ������, �� ������� ������������� ����� �������
% � ���������� �� ��� ����� � �������� ������� ��� ������
function [linesbk, thresholds] = inputpoem(wordlength, nbits)
% ������ ��� ���� ���� �������������
wordthresholds = zeros(1, 16*2);
% �� �����
linesbk{16} = [];
% ������ ������ ���������� ��� ������ �������������
for i = 1 : 16
    line = input(['������� ', int2str(i), ...
        ' ������ �������������: '], 's');
    if ~isempty(line)
        % ���� ������ ����� �� ���������, ����������� ����� ��� ����
        if line(1) ~= '_'
            wordthresholds(i*2-1) = wordlength;
        end
        % ����� ��� ������� �����
        if line(length(line)) ~= '_'
            wordthresholds(i*2) = wordlength;
        end
    end
    % ��������� �� ������
    linesbk{i} = tobk(line, wordlength);
end
% ������ ��� ������ �������������
thresholds = zeros(1, nbits);
% ������� ������ ��� ������ �������������
for i = 1 : nbits
    % ��������� ������ �������� � ������� ����� ����
    for j = 1 : 16*2 / nbits
        thresholds(i) = thresholds(i) ...
            + wordthresholds((i-1)*16*2/nbits + j);
    end
end
