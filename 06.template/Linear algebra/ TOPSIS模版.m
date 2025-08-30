% --- 1. 定义数据 ---

% 原始决策矩阵
% 每一行代表一个方案（比如汽车A, B, C）
% 每一列代表一个指标（比如价格, 续航, 耗油量）
% 假设有3个方案和3个指标
data_matrix = [
    20,  500, 7;
    15,  450, 6;
    25,  600, 8
];

% 权重向量
% 这是你用AHP计算出来的权重，需要把它们填进去
% 假设你计算出的权重是 [0.2385, 0.1365, 0.6250]
weights = [0.2385, 0.1365, 0.6250];

% 指标类型向量
% 1表示效益型（越大越好），-1表示成本型（越小越好）
% 价格和耗油量是成本型，续航是效益型
criteria_type = [-1, 1, -1];

% --- 2. TOPSIS 函数 ---

function [closeness, ranking] = topsis_method(data_matrix, weights, criteria_type)
    % 获取矩阵的行数（方案数）和列数（指标数）
    [m, n] = size(data_matrix);
    
    % (1) 矩阵规范化（向量规范化）
    norm_matrix = zeros(m, n);
    for j = 1:n
        col_sum_sq = sum(data_matrix(:, j).^2);
        norm_matrix(:, j) = data_matrix(:, j) / sqrt(col_sum_sq);
    end
    
    % (2) 构造加权规范化矩阵
    weighted_norm_matrix = norm_matrix .* weights;
    
    % (3) 确定理想解和负理想解
    best_solution = zeros(1, n);
    worst_solution = zeros(1, n);
    for j = 1:n
        if criteria_type(j) == 1 % 效益型指标
            best_solution(j) = max(weighted_norm_matrix(:, j));
            worst_solution(j) = min(weighted_norm_matrix(:, j));
        else % 成本型指标
            best_solution(j) = min(weighted_norm_matrix(:, j));
            worst_solution(j) = max(weighted_norm_matrix(:, j));
        end
    end
    
    % (4) 计算距离
    distance_to_best = zeros(m, 1);
    distance_to_worst = zeros(m, 1);
    for i = 1:m
        distance_to_best(i) = sqrt(sum((weighted_norm_matrix(i, :) - best_solution).^2));
        distance_to_worst(i) = sqrt(sum((weighted_norm_matrix(i, :) - worst_solution).^2));
    end
    
    % (5) 计算相对贴近度
    closeness = distance_to_worst ./ (distance_to_best + distance_to_worst);
    
    % (6) 排序
    [~, ranking] = sort(closeness, 'descend');
    
end

% --- 3. 调用函数 ---

[final_closeness, final_ranking] = topsis_method(data_matrix, weights, criteria_type);

% 显示结果
disp('方案的相对贴近度:');
disp(final_closeness);

disp('排名（从最优到最差的方案索引）:');
disp(final_ranking);
