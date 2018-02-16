clear;
data = load('seeds.txt');
numberOfClusters = 'What is the number of clusters?';
k = input(numberOfClusters);
clusterCenters(1:k,1:7) = 0;
for i = 1:k
    r = randi(210,1);
    for j = 1:7
        clusterCenters(i,j) = data(r,j);
    end
end
sse(1:100,1) = 0;
d(1:k,1) = 0;
dist = 0;
rowDist = 0;
minDist = 0;
rowLabel(1:k,1) = 0;
for n = 1:100
    for a = 1:210
        for cnum = 1:k
            for b = 1:7
                dist = (data(a,b)-clusterCenters(cnum,b))^2;
                rowDist = rowDist + dist;
            end
            d(cnum,1) = sqrt(rowDist);
            rowDist = 0;
        end
        for l = 1:k
            if(d(l,1) == min(d))
                rowLabel(a,1) = l;
                sse(n,1) = sse(n,1) + (d(l,1)^2);
            end
        end
    end
    for c = 1:k
        count = 0;
        a1Values = 0;
        a2Values = 0;
        a3Values = 0;
        a4Values = 0;
        a5Values = 0;
        a6Values = 0;
        a7Values = 0;
        for m = 1:210
            if(rowLabel(m,1) == c)
                a1Values = a1Values + data(m,1);
                a2Values = a2Values + data(m,2);
                a3Values = a3Values + data(m,3);
                a4Values = a4Values + data(m,4);
                a5Values = a5Values + data(m,5);
                a6Values = a6Values + data(m,6);
                a7Values = a7Values + data(m,7);
                count = count + 1;
            end
        end
        clusterCenters(c,1) = a1Values/count;
        clusterCenters(c,2) = a2Values/count;
        clusterCenters(c,3) = a3Values/count;
        clusterCenters(c,4) = a4Values/count;
        clusterCenters(c,5) = a5Values/count;
        clusterCenters(c,6) = a6Values/count;
        clusterCenters(c,7) = a7Values/count;
    end
    if(n>1 && (sse(n-1,1)-sse(n,1) < 0.001))
        if(sse(n-1,1)>sse(n,1))
            output=sprintf('SSE is %f',sse(n,1));
            disp(output);
            break;
        else
            output=sprintf('SSE is %f',sse(n-1,1));
            disp(output);
            break;
        end
    else if(n == 100)
            disp(sse(n,1));
        end
    end
end