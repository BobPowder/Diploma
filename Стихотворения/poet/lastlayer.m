% функция принимает на вход матрицу БК эталонных стихотворений,
% БК проверямого стихотворения, порог и тексты эталонных стихотворений
function [result] = lastlayer(poemsmatrix, testpoembk, ...
    threshold, poemstext)
% перемножаем БК эталонных и тестового стихотворений
res = poemsmatrix * testpoembk;
% найден ли ответ
found = false;
for i = 1 : length(res)
    % если совпало нужное количество частей стихотворения
    if res(i) >= threshold
        % то решение найдено
        found = true;
        % выводим найденное стихотворение
        disp('Ответ:');
        for j = 1 : 16
            disp(poemstext{i}{j});
			result=true;
        end
    end
end
result=false;
% рещения нет
%if ~found
%    disp('Стихотворение отсутствует в базе');
%end
