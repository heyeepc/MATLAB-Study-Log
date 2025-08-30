function normalized_matrix = minmax_normalize(data_matrix, criteria_type)
    % 获取矩阵的行数和列数
    [m, n] = size(data_matrix);
    normalized_matrix = zeros(m, n);
    
    for j = 1:n
        % 找到当前列的最大值和最小值
        min_val = min(data_matrix(:, j));
        max_val = max(data_matrix(:, j));
        
        % 检查分母是否为零，避免除零错误
        if (max_val - min_val) == 0
            % 如果所有数据都一样，直接设为0.5或1
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
