paths;
algorithms = {'nmpa_case1'}; % algorithm
dimension = 20; % (2, 10, 20)
maxFE = 1000; % 1000000

cec2022 = str2func('cec22_test_func');
globalMins = {300, 400, 600, 800, 900, 1800, 2000, 2200, 2300, 2400, 2600, 2700};
experimentNumber = 1; run = 21;
filename = 'result-';
functionsNumber = 12;
solution = zeros(experimentNumber, functionsNumber, run);
solutionR = zeros(functionsNumber * experimentNumber, run);

for ii = 1 : length(algorithms)
    disp(algorithms(ii));
    algorithm = str2func(char(algorithms(ii)));
    for i = 1 : functionsNumber
        disp(i);
        for j = 1 : run
            [~, bestFitness, ~] = algorithm(cec2022, dimension, maxFE, i);
            solution(1, i, j) = bestFitness - globalMins{i};
            for k = 1 : experimentNumber
                solutionR(k + experimentNumber * (i - 1), j) = solution(k, i, j);
            end
        end
    end     
    xlswrite(strcat(filename, func2str(algorithm), '-d=', num2str(dimension), '.xlsx'), solutionR, 1);
    eD = strcat(func2str(algorithm), '-Bitti :)');
    disp(eD);
end