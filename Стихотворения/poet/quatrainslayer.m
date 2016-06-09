% функция принимает на вход массив БК четверостиший эталонных
% стихотворений, БК четверостиший проверямого стихотворения
% и пороги для четверостиший
% и возвращает БК проверяемого стихотворения
function [testpoembk] = quatrainslayer(quatrainsmatrix, ...
    testquatrainsbk, thresholds)
% БК стихотворения
testpoembk = zeros(20*4, 1);
% для каждого четверостишия
for i = 1 : length(thresholds)
    % перемножаем матрицу БК эталонных четверостиший и тестового
    res = quatrainsmatrix(:, :, i) * testquatrainsbk(:, i);
    for j = 1 : length(res)
        % если совпало нужно количество частей четверостишия
        if res(j) >= thresholds(i)
            % то записываем его в БК тестового стихотворения
            testpoembk((i-1)*20+j) = 1;
        end
    end
end
