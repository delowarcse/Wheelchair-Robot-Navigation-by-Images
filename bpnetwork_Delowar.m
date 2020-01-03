% Train the feedforward neural network

clear all
clc


circle=1;
epoch=[5000];        % max interation number
m=1000;                % Hidden layer number
t=length(epoch);

load input6
load output6

input=input;
output=output;


input=input';
output=output';

Percentage_train=zeros(circle,t);
Percentage_test=zeros(circle,t);



for number=1:t
    for time=1:circle
        %             net = newff(input,output,m,{'logsig'},'traingd','learngd','mse');
        net = newff(input,output,m,{'logsig','logsig'},'traingd','learngd','mse'); % Create a new feed forward network
        %         net=newrbe(input,output,1)
        net.trainparam.epochs=epoch(number);
        net.trainParam.goal = 0;
        net.trainparam.lr=0.0001;                       % learning rate
        net.trainparam.trainRatio=1;
        net.trainparam.valRatio=0;
        net.trainparam.testRatio=0;
        net.trainParam.max_fail = 2000;
        net.inputs{1}.processParams{1}.ymin=0;
        net.outputs{2}.processParams{2}.ymin = 0;
        
        [net,tr] = train(net,input,output);
        
        %%
        trainInputs = input(:,tr.trainInd);
        trainTargets = output(:,tr.trainInd);
        out_train = sim(net,trainInputs);        % Get response from trained network
        
        
    end
end
FinallPer_train=mean(Percentage_train);
FinallPer_test=mean(Percentage_test);

% save the net
% save delowar_net1.mat net
