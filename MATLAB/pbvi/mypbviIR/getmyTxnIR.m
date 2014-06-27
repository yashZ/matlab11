function txn = getmyTxnIR(nrstates,nractions)

deftxn = 0.3/(nrstates - 1);

txn = zeros(nrstates,nrstates,nractions);
for i=1:nrstates
    for j=1:nrstates
        for k=1:nractions
            if i==j
                txn(i,j,:) = 0.7;
            else
                txn(i,j,:) = deftxn;
            end
            
        end
    end
 end

%txn(1,1,:)=0.6;
%txn(1,2,:)=0.4;
%txn(2,2,:)=0.6;
%txn(2,1,:)=0.4;
end