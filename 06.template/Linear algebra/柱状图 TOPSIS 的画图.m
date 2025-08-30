% 定义数据
closeness = [0.4945, 0.8437, 0.1563];
schemes = {'方案A', '方案B', '方案C'};

% 创建柱状图
figure;
bar(closeness);

% 添加标签和标题
set(gca, 'xticklabel', schemes);
title('TOPSIS 相对贴近度结果');
xlabel('方案');
ylabel('相对贴近度');

% 在柱子上显示数值
text(1:length(closeness), closeness, num2str(closeness', '%.4f'), ...
     'vert', 'bottom', 'horiz', 'center');

% 添加图例（可选）
% legend('相对贴近度', 'Location', 'northwest');

% 调整Y轴范围，让图更美观
ylim([0, 1]);
grid on;
