function normalized_matrix = minmax_normalize(data_matrix, criteria_type)
    % 极差标准化模板
    % 输入:
    %   data_matrix: 原始决策矩阵，每一行是一个方案，每一列是一个指标。
    %   criteria_type: 指标类型向量，1表示效益型（越大越好），-1表示成本型（越小越好）。
    %
    % 输出:
    %   normalized_matrix: 标准化后的矩阵，所有数据都在 [0, 1] 之间，且越大越好。
    
    % 获取矩阵的行数和列数
    [m, n] = size(data_matrix);
    normalized_matrix = zeros(m, n);
    
    for j = 1:n
        % 找到当前列的最大值和最小值
        min_val = min(data_matrix(:, j));
        max_val = max(data_matrix(:, j));
        
        % 检查分母是否为零，避免除零错误
        if (max_val - min_val) == 0
            % 如果所有数据都一样，直接设为0.5
            normalized_matrix(:, j) = 0.5; 
            continue;
        end
        
        if criteria_type(j) == 1 % 效益型指标 (越大越好)
            normalized_matrix(:, j) = (data_matrix(:, j) - min_val) / (max_val - min_val);
        else % 成本型指标 (越小越好)
            normalized_matrix(:, j) = (max_val - data_matrix(:, j)) / (max_val - min_val);
        end
    end
end

% --- 使用示例 ---
% 1. 在这里填写你的原始矩阵
%    例如，评估三辆汽车，指标分别是：价格、续航、耗油量
%    第一行是方案A，第二行是方案B，第三行是方案C
%    第一列是价格，第二列是续航，第三列是耗油量
original_data = [
    200000, 500, 7;
    150000, 450, 6;
    250000, 600, 8
];

% 2. 在这里填写指标类型
%    价格（-1）是成本型，续航（1）是效益型，耗油量（-1）是成本型
indicator_types = [-1, 1, -1];

% 3. 调用模板，获取标准化后的矩阵
processed_data = minmax_normalize(original_data, indicator_types);

% 4. 显示结果
disp('原始矩阵:');
disp(original_data);

disp('标准化后的矩阵:');
disp(processed_data);

% 5. 接下来，你可以将 processed_data 用于TOPSIS或其他模型
% 例如：
% weights = [0.4, 0.5, 0.1]; % 假设这是你用AHP得到的权重
% % topsis_method(processed_data, weights); % 调用你的TOPSIS函数
