%% 起跳检测（简化版）
clear; clc;

% 读取数据
df = readtable('运动者1的跳远位置信息_平滑_区域分配.xlsx');

% 脚部纵坐标列
footCols = {'x27_Y','x28_Y','x29_Y','x30_Y','x31_Y','x32_Y'};
F = df{:, footCols};

% 计算地面高度
y0 = min(F(:));

% 离地距离
d = min(abs(F - y0), [], 2);

% 判定是否接触地面（1=接触）
eps = 2;
c = d <= eps;

% 最少连续离地帧
K = 3;

% 计算离地帧标记（0=接触，1=离地）
air = ~c;

% 寻找起跳位置：某帧接触地面、接下来连续K帧都离地
t_to = -1;
for t = 1:length(air)-K
    if c(t)==1 && all(air(t+1:t+K))
        t_to = t;
        break;
    end
end

% 输出
fprintf('地面参考 y0 = %.2f\n', y0);
if t_to ~= -1
    fprintf('起跳帧 t_to = %d (%.2f 秒)\n', t_to, (t_to-1)/30);
else
    fprintf('未检测到起跳时刻。\n');
end
