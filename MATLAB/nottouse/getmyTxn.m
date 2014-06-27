function txn = getmyTxn()
txn = zeros(5,5,16);
for i=1:5
    for j=1:5
        for k=1:16
            if i==j
                txn(i,j,:) = 0.6;
            else
                txn(i,j,:) = 0.1;
            end
            
        end
    end
end
end