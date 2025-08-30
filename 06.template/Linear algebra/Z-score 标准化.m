function normalized_matrix = zscore_normalize(data_matrix, criteria_type)
    % 获取矩阵的行数和列数
    [m, n] = size(data_matrix);
    normalized_matrix = zeros(m, n);
    
    for j = 1:n
        % 计算当前列的均值和标准差
        col_mean = mean(data_matrix(:, j));
        col_std = std(data_matrix(:, j));
        
        % 检查标准差是否为零
        if col_std == 0
            % 如果标准差为零，直接设为0
            normalized_matrix(:, j) = 0;
            continue;
        end
        
        normalized_matrix(:, j) = (data_matrix(:, j) - col_mean) / col_std;
        
        if criteria_type(j) == -1 % 成本型指标
            % 将整个列取反，使其变为越大越好
            normalized_matrix(:, j) = -normalized_matrix(:, j);
        end
    end
end
