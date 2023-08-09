clear
clc
% 添加交通参与者
% egoCar = vehicle(s); % 把车辆添加到场景s中
% egoCar =  vehicle(s,Name,Value); % 使用名称-值设置车辆属性 并添加到场景s中 例如可以设置车辆的位置、速度、尺寸、方向
% trajectory(egoCar,waypoints,speed); % 在场景中设置车辆轨迹和速度
% 分类标识符'ClassID' : 1代表轿车；2代表卡车；3代表自行车；4代表行人；5代表障碍物
% car = vehicle(s,'ClassID',1)

% 1.在长100m、宽16m的道路上添加一车辆，车辆位于车道中心 速度为50km/h 
% s = drivingScenario; %设置驾驶场景
% roadCenter = [0,0;100,0]; % 设置道路中心
% roadWidth = 16; % 设置道路宽度
% road(s,roadCenter,roadWidth); % 驾驶场景中添加道路
% plot(s);
% egoCar = vehicle(s,'ClassID',1); % 添加车辆
% waypoints = roadCenter; % 设置车辆轨迹为道路中心
% speed = 13.89; % 设置车速
% trajectory(egoCar,waypoints,speed) % 在场景中构建车辆轨迹;
% while advance(s)
%     pause(0.01);
% end

% 2.设计车辆在十字路口左转弯的场景
% s = drivingScenario; %设置驾驶场景
% roadWidth = 8; % 设置道路宽度
% road(s,[0,-25;0,25],roadWidth); % 驾驶场景中添加十字
% road(s,[-25,0;25,0],roadWidth); 
% egoCar = vehicle(s,'ClassID',1);
% % waypoints = [-24,-1.5;-7,-1.5;-3.5,-1.5;-3,-1.5;1.5,3.0;1.5,3.5;1.5,21.0]; % 设置车辆轨迹
% waypoints = [-24.0,-7.0,-3.5,-3.0,1.5,1.5,1.5;-1.5,-1.5,-1.5,-1.5,3.0,3.5,21.0]'
% speed = [20.0,0.0,5.0,5.0,10.0,12.0,20.0]; % 设置车速
% trajectory(egoCar,waypoints,speed); % 在场景中构建车辆轨迹
% plot(s,'Centerline','on');
% while advance(s)
%     pause(0.01)
% end

% 3.构建一个驾驶场景 包含一条弯道和两条直道 其中弯道半径200m 弯道宽度10m 弯道上一辆汽车 直道上一辆自行车 一个行人
% s = drivingScenario; %设置驾驶场景
% roadWidth = 10; % 设置道路宽度
% % '转置
% angs = [0:5:90]'; % 列数
% R = 200;% 弯道半径
% % cosd(30) == cos(pi/6) cosd的参数是角度  cos的参数是弧度
% % size() 获取行列数
% % zeros() 创建一个 零值的矩阵
% roadCenters = R*[cosd(angs),sind(angs),zeros(size(angs))];
% road(s,roadCenters,roadWidth); % 驾驶场景中添加弯道
% roadCenters = [0,20,0;160,20,0];
% road(s,roadCenters); % 驾驶场景中添加第一条直道
% roadCenters = [0,50,0;160,50,0];
% road(s,roadCenters); % 驾驶场景中添加第二条直道
% Car = vehicle(s,'ClassID',1,'Position',[0,200,0]);
% Bicycle = actor(s,'ClassID',3,'Position',[0,50,0]);
% pedestrian = actor(s,'ClassID',4,'Position',[0,20,0]);
% plot(s,'Centerline','on','RoadCenters','on');

% 4.构建一个由两辆汽车组成的场景 他们分别以30m/s和40m/s的速度在环路上行驶 分别在场景图和方块图上显示 假设道路为椭圆形轨道 
% 该轨道覆盖大约200m长、100m宽的区域，其曲线的倾斜角为9°
s = drivingScenario; % 构建驾驶场景
roadCenters = [0,40,49,50,100,50,49,40,-40,-49,-50,-100,-50,-49,-40,0;...
               -50,-50,-50,-50,0,50,50,50,50,50,50,0,-50,-50,-50,-50;...
               0,0,.45,.45,.45,.45,.45,0,0,.45,.45,.45,.45,.45,0,0]'; % 设置道路中心
bankAngles = [0,0,9,9,9,9,9,0,0,9,9,9,9,9,0,0]; % 设置道路倾斜角度
road(s,roadCenters,bankAngles,'lanes',lanespec(2)); % 在场景中添加道路 两个车道
plot(s,'RoadCenters','on'); % 绘制椭圆轨道
egoCar = vehicle(s,'Position',[80 -40 .45],'Yaw',30); % 在场景中添加主车
chasePlot(egoCar); % 绘制追踪图
fastCar = vehicle(s); % 在场景中添加第二辆车
% chasePlot(fastCar); % 绘制追踪图
d = 2.7/2; % 轴距 前后轮的距离
h = 0.45/2; % 车辆的高度
roadOffset = [0,0,0,0,d,0,0,0,0,0,0,-d,0,0,0,0;...
              -d,-d,-d,-d,0,d,d,d,d,d,d,0,-d,-d,-d,-d;...
              0,0,h,h,h,h,h,0,0,h,h,h,h,h,0,0]'; % 设置道路偏移量
rWayPoints = roadCenters + roadOffset; % 右侧路径点
lWayPoints = roadCenters - roadOffset; % 左侧路径点
% rWayPoints(1:end-1,:) 取第一行到倒数第二行（包含所有列）的矩阵
% rWayPoints(1,:) 取第一行（包含所有列）的矩阵
% repmat 赋值矩阵的的函数 repmat(A,m,n) 把矩阵A整体赋值成m行n列
% 最后一个点就是第一个点 因为要组成一个环
% 复制5遍代表可以跑五圈
rWayPoints1 = [repmat(rWayPoints(1:end-1,:),5,1);rWayPoints(1,:)]; % 右侧路径矩阵  
lWayPoints1 = [repmat(lWayPoints(1:end-1,:),5,1);lWayPoints(1,:)]; % 左侧路径矩阵
trajectory(egoCar,rWayPoints1(:,:),30); % 把主车放在右侧车道
trajectory(fastCar,lWayPoints1(:,:),40); % 把第二辆车放在左侧车道
s.SampleTime = 0.02; % 设置分辨率 50FPS
s.StopTime = 20; % 设置停止时间 持续时间
while advance(s)
    pause(0.01)
end
