% dynaQ2DOFSystem.m
% Using model-based RL to control a mass spring damper system
% Actions are pushing left, applying no force, or pushing right
% Model is in discrete time
% September 4th, 2023, MPS

%Note
% simulate_mass_spring_damper.m must be in common workspace

clear;clc;close all;

% Parameters for the mass-spring-damper system
m = 1;          % Mass (kg)
k = 10;         % Spring constant (N/m)
c = 1;          % Damping coefficient (Ns/m)
v = 0;
f = waitbar(0, 'Starting');
% Discretize the state space and action space
modelBased=0.8; % How much of the episodes for model learning
range_=1;
num_states = 100;    % Number of discrete states
num_actions = 3;     % Number of discrete actions (push left, no force, right)
num_episodes = 5000;  % Number of episodes
alpha = 0.1;         % Learning rate
gamma = 0.9;         % Discount factor
epsilon = 0.1;       % Exploration rate
max_steps = 3000;     % Maximum number of steps per episode
position = zeros(max_steps,1);   % Position
distance_to_target = zeros(max_steps,1); % #########################
target_position = 0.3;  % Specific target position
x=0; %Initial Position
act=zeros(max_steps,1);
V=zeros(max_steps,1);
% Initialize Q-values
Q = zeros(num_states, num_actions); % using Q-table
QQ= zeros(num_states, num_actions, num_episodes);

errorMax=1*range_;
errorMin=-1*range_;

rewardAmp=2; %reward amplification
% or randi
% Initialize model of the environment
model = struct('next_state', ones(num_states, num_actions), 'reward', zeros(num_states, num_actions));

% Function to simulate the mass-spring-damper system
simulate_system = @(state, action, v, x, target_position) simulate_mass_spring_damper(state, action, num_states, m, k, c, v, x, target_position);

% Dyna-Q learning
for episode = 1:num_episodes
    %state = randi(num_states); % Start in a random state for each episode
    %state = 200;
    v=0;
    %x = range_*(state - 1) / (num_states - 1);
    %x=rand()*range_;
    target_position=rand()*range_;

    d2t = (x - target_position);
    error = max(errorMin, min(errorMax,d2t)); % Clipped
    state = round(((num_states-1)/(errorMax-errorMin))*(error-errorMin) + 1);

    %x=rand();
    for step = 1:max_steps
        % Epsilon-greedy action selection
        if rand() < epsilon
            action = randi(num_actions); % Explore
        else
            [~, action] = max(Q(state, :)); % Exploit
        end
        
        % Simulate the environment (mass-spring-damper system)
        if episode <= round(num_episodes*modelBased)

            [next_state, x, v, d2t] = simulate_system(state, action, v, x, target_position);
            position(step,1) = x;
            V(step, 1)=v;
            act(step, 1)=action;
            % Update the reward based on the distance to the target position
            distance_to_target(step,1) = abs(d2t);
            reward = 1 / (1 + distance_to_target(step,1)); % Higher reward if closer to the target
            %reward = 10*(-distance_to_target(step,1));
        else
            next_state = model.next_state(state, action);
            reward = model.reward(state, action);
        end

        % Q-value update
        Q(state, action) = Q(state, action) + alpha * (rewardAmp*reward + gamma * max(Q(next_state, :)) - Q(state, action)); % why this works?
        
        % Model update
        if episode <= round(num_episodes*modelBased)
            model.next_state(state, action) = next_state;
            model.reward(state, action) = reward;
        end
        
        % Transition to the next state
        state = next_state;
        % Check if the target position is reached and break if so
        if distance_to_target < 0.01  % Adjust the threshold 
            disp('Target achieved')
            break;
        end
    end

    QQ(:,:,episode)=Q;
    waitbar(episode/num_episodes, f, sprintf('Progress: %d %%', floor((episode/num_episodes)*100)));
end

% final episodes
figure(1); plot(position,'DisplayName','Position');hold;plot(distance_to_target,'r','DisplayName','Distance to Target');
hold on;
legend
figure(2);
plot(act,'g','DisplayName','Action');
legend
grid on;
figure(3);
plot(V);
title('velocity');

[xx,yy]=meshgrid([1:num_actions],[1:num_states]);

