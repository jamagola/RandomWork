
% Note
% Before running this make sure RLmodelBased.m is successfully executed

    for i = 1:10:num_episodes
        contourf(xx,yy,QQ(:,:,i));
        zlabel('Q');
        xlabel('action');
        ylabel('states');
        colorbar;
        pause(0.01);
    end
