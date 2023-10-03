% Function to simulate the mass-spring-damper system dynamics
function [next_state, x, v, d2t] = simulate_mass_spring_damper(state, action, num_states, m, k, c, v, x, target_position)
    % Convert state to continuous variables (position and velocity)
    range_=1;
    errorMax=1*range_;
    errorMin=-1*range_;
    %x = range_*(state - 1) / (num_states - 1);
    
    if x == 0
        %v = 0; % V always zero? No
    end

    F=10;
    % Define action effects on the system
    if action == 1  % Push left
        force = -F;
    elseif action == 2  % No force
        force = 0;
    elseif action == 3  % Push right
        force = F;
    end
    
    % Update the system dynamics using a simple Euler integration
    dt = 0.01;  % Time step
    acceleration = force / m - (k / m) * x - (c / m) * v;
    v = v + acceleration * dt;
    x = x + v * dt;
    
    % Clip position to valid range [0, range_]
    x_ = max(0, min(range_, x));
    %x=x_;
    d2t = (x - target_position);
    error = max(errorMin, min(errorMax,d2t)); % Clipped
    % Convert position and velocity back to the discrete state space
    % next_state = round(((x_ *(num_states-1))/range_+1));
    next_state = round(((num_states-1)/(errorMax-errorMin))*(error-errorMin) + 1);
    % Define the reward function (e.g., maximize position)
end