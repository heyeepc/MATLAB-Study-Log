function normalized_matrix = vector_normalize(data_matrix)
    % 获取矩阵的行数和列数
    [m, n] = size(data_matrix);
    normalized_matrix = zeros(m, n);
    
    for j = 1:n
        % 计算列向量的模（平方和的开方）
        col_norm = sqrt(sum(data_matrix(:, j).^2));
        
        % 检查分母是否为零
        if col_norm == 0
            normalized_matrix(:, j) = 0;
            continue;
        end
        
        normalized_matrix(:, j) = data_matrix(:, j) / col_norm;
    end
end
