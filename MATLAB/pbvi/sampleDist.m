function samples = sampleDist( pdf, sampleCount )
% samples = sampleDist( pdf, sampleCount )
% pdf must be in columns! 
% if sampleCount = 1, pdf can have many pdfs in columns
% largeCount = 10 for rejection vs. metropolis hastings
largeCount = 10;
optCount = length(pdf);
samples = zeros(sampleCount,1);

% determine if we're using precomputed random numbers
global dUniform; global cUniform; global randInd;
preCompCount = length(cUniform);
if preCompCount ~= 0

    % use find for single counts
    if sampleCount == 1 
        cdf = cumsum(pdf);
        
        % check how many samples we have
        if size(pdf,2) == 1
            samples = find( cUniform(randInd) < cdf ,1 );
        else
            % pick first non-zero column element
            [samples j] = find( cUniform(randInd) < cdf );
            t = logical( diff( [0;j] ) );
            samples = samples(t);
        end
        
        % update the random index
        randInd = randInd + 1;
        if randInd > preCompCount
            resetProbSet( optCount );
        end
    
    
    % use rejection sampling for fairly small counts
    elseif sampleCount < largeCount
        maxP = max(pdf);
        ind = 1;
        while ind <= sampleCount
            x = dUniform(randInd); 
            y = maxP * cUniform(randInd);
            randInd = randInd + 1;
            if randInd > preCompCount
                resetProbSet( optCount );
            end
            if( y < pdf(x) )
                samples(ind) = x;
                ind = ind + 1;
            end
        end
        
    % use metropolis hastings montecarlo for large counts
    % underlying distribution is uniform
    else
        skipCount = 10;
        
        % get a valid start point
        x = dUniform(randInd);
        randInd = randInd + 1;
        if randInd > preCompCount
            resetProbSet( optCount) ;
        end
        while( pdf(x) == 0 )
            x = dUniform(randInd);
            randInd = randInd + 1;
            if randInd > preCompCount
                resetProbSet(optCount);
            end
        end

        for i = 1:sampleCount

            % sample a bit to mix
            for j = 1:skipCount
                xp = dUniform(randInd); randInd = randInd + 1;
                if randInd > preCompCount
                    resetProbSet(optCount);
                end

                alpha = pdf(xp)/pdf(x);
                if rand < alpha
                    x = xp;
                end
            end

            % assign value
            samples(i) = x;
        end
    end

else % no precomputations
    
    % use find for single counts -- works even if multiple pdfs given
    if sampleCount == 1 
        cdf = cumsum(squeeze(pdf));
        
        % check how many samples we have
        if size(pdf,2) == 1
            samples = find( rand < cdf ,1 );
        else
            % pick first non-zero column element
            [samples j] = find( rand < cdf );
            t = logical( diff( [0;j] ) );
            samples = samples(t);
        end
        
    
    
    % use rejection sampling for small counts
    elseif sampleCount < largeCount
        maxP = max(pdf);
        ind = 1;
        while ind <= sampleCount
            x = ceil(rand*optCount); % 5x faster than random('unid',optCount)
            y = maxP * rand;
            if( y < pdf(x) )
                samples(ind) = x;
                ind = ind + 1;
            end
        end

    % use metropolis hastings montecarlo for large counts
    % underlying distribution is uniform
    else
        skipCount = 10;

        % get a valid start point
        x = ceil(rand*optCount);
        while( pdf(x) == 0 )
            x = ceil(rand*optCount);
        end

        for i = 1:sampleCount

            % sample a bit to mix
            for j = 1:skipCount
                xp = ceil(rand*optCount);
                alpha = pdf(xp)/pdf(x);
                if rand < alpha
                    x = xp;
                end
            end

            % assign value
            samples(i) = x;
        end
    end
end


% -------------------------------------------------------------------------
function resetProbSet( optCount );
    % for now, we continue to reuse the old random vectors, so our sampling
    % isn't going to be quite random...
    % global dUniform; dUniform = ceil( optCount * rand(1,1000) );
    % global cUniform; cUniform = rand(1,1000);
    global cUniform; cUniform = circshift( cUniform, [1 ceil(rand*length(cUniform))] );
    global randInd; randInd = 1;
