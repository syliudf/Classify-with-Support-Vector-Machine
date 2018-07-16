

gmin=-4;
gmax=4;
cmin=-4;
cmax=4;
cost1=logspace(cmin,cmax,10);
gamma1=logspace(gmin,gmax,10);
xx = linspace(cmin,cmax,10)
yy = linspace(gmin,gmax,10)
bestans=0;
norm_train_data=mapminmax(train_data')';
norm_test_data=mapminmax(test_data')';
for i=1:10
    for j=1:10
        fprintf("%d%%/100%%",10*i+j-10) 
        tmp=['-g ', num2str(gamma1(j)) ,' -c ' ,num2str(cost1(i)), ' -v ','10'];
        modelacc(i,j)=svmtrain(train_label, norm_train_data , tmp);
        if (modelacc(i,j)>bestans)
            bestans=modelacc(i,j);
            besti=i;
            bestj=j;
        end
    end
end

[C,h]=contourf(xx,yy,modelacc',50:2:100)
clabel(C,h,'FontSize',10,'Color','r');
xlabel('lg c','FontSize',10);
ylabel('lg g','FontSize',10);

tmp2=['-g ', num2str(gamma1(bestj)) ,' -c ' ,num2str(cost1(besti))];
modeltmp=svmtrain(train_label, norm_train_data , tmp2);
[p1,acc,~]=svmpredict(test_label,test_data,modeltmp);
truthacc(i,j)=acc(1);

  

