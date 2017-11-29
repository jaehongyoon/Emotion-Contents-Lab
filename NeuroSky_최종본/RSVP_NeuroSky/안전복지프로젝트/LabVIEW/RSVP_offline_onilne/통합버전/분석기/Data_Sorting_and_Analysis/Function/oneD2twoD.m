function arr = oneD2twoD(arr2D)
row = size(arr2D,1);
arr = [];
for i = 1:row
    arr = [arr arr2D(i,:)];
end