clc;
clear;

sim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    sim.simxFinish(-1); % just in case, close all opened connections
    clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);
    
    if (clientID>-1)
        disp('Connected to remote API server');
        %joint position
        joint_pos1= [0 0];
        joint_pos2= [0 90];
        joint_pos3= [90 0];
        joint_pos4= [0 0];
        %joint handle
        h=[0 0];
        [r,h(1)]=sim.simxGetObjectHandle(clientID,'x_motor_joint',...
        sim.simx_opmode_blocking);
        [r,h(2)]=sim.simxGetObjectHandle(clientID,'y_motor_joint',...
        sim.simx_opmode_blocking);
        %move joint
        while true
            for i=1:2
            [r]=sim.simxSetJointTargetVelocity(clientID,h(i),joint_pos1(i),...
            sim.simx_opmode_blocking);
            end
            pause(10); 
            
            for i=1:2
            [r]=sim.simxSetJointTargetVelocity(clientID,h(i),joint_pos2(i),...
            sim.simx_opmode_blocking);
            end
            pause(10);
            
            for i=1:2
            [r]=sim.simxSetJointPosition(clientID,h(i),joint_pos3(i),...
            sim.simx_opmode_blocking);
            end
            pause(10);
        end
        
    else
        disp('Failed connecting to remote API server');
    end
    sim.delete(); % call the destructor!
    
    disp('Program ended');