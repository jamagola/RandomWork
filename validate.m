position_ = zeros(max_steps,1);   % Position
distance_to_target_ = zeros(max_steps,1); % #########################
target_position_ = 0.8;  % Specific target position
x=0; %Initial Position
act_=zeros(max_steps,1);
V_=zeros(max_steps,1);

%state = randi(num_states); % Start in a random state for each episode
%state = 200;
v=0;
%x = range_*(state - 1) / (num_states - 1);
%x=rand()*range_;

d2t = (x - target_position);
error = max(errorMin, min(errorMax,d2t)); % Clipped
state = round(((num_states-1)/(errorMax-errorMin))*(error-errorMin) + 1);

for step = 1:max_steps
    [~, action] = max(Q(state, :)); % Exploit
 
    % Simulate the environment (mass-spring-damper system)
    

    [next_state, x, v, d2t] = simulate_system(state, action, v, x,target_position_);
    position_(step,1) = x;
    V_(step, 1)=v;
    act_(step, 1)=action;
    % Update the reward based on the distance to the target position
    distance_to_target_(step,1) = abs(d2t); % discretizing length

    % Transition to the next state
    state = next_state;
    % Check if the target position is reached and break if so
    if distance_to_target_ < 0.01  % Adjust the threshold 
        disp('Target achieved')
        break;
    end
end

% final episodes
figure(1); plot(position_,'DisplayName','Position');hold;plot(distance_to_target_,'r','DisplayName','Distance to Target');
legend