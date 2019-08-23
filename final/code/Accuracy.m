function [Count, Correct]= Accuracy(True,Predict)
    Truesize = size(True)
    Correct = [zeros(1,8)]
    Count = [zeros(1,8)]
    
    for index=1:Truesize
        if (True(index) == 1)
            Count(1) = Count(1)+1
            if(True(index) == Predict(index,4))
                Correct(1)= Correct(1)+1
            end
        elseif(True(index) == 2)
            Count(2) = Count(2)+1
            if(True(index) == Predict(index,4))
                Correct(2)= Correct(2)+1
            end
        elseif(True(index) == 3)   
            Count(3) = Count(3)+1
            if(True(index) == Predict(index,4))
                Correct(3)= Correct(3)+1
            end
        elseif(True(index) == 4)
            Count(4) = Count(4)+1
            if(True(index) == Predict(index,4))
                Correct(4)= Correct(4)+1
            end    
        elseif(True(index) == 5)
            Count(5) = Count(5)+1
            if(True(index) == Predict(index,4))
                Correct(5)= Correct(5)+1
            end
        elseif(True(index) == 6)
            Count(6) = Count(6)+1
            if(True(index) == Predict(index,4))
                Correct(6)= Correct(6)+1
            end 
        elseif(True(index) == 7)
            Count(7) = Count(7)+1
            if(True(index) == Predict(index,4))
                Correct(7)= Correct(7)+1
            end
        elseif(True(index) == 8)
            Count(8) = Count(8)+1
            if(True(index) == Predict(index,4))
                Correct(8)= Correct(8)+1
            end
        end
    end
end
% if (True(index,4) == 1)
%         sum(True(index,4) == Predict(index,4))/Truesize(1,1)
%     elseif(True(index,4) == 2)
%     elseif(True(index,4) == 3)    
%     elseif(True(index,4) == 4)
%     elseif(True(index,4) == 5)
%     elseif(True(index,4) == 6)
%     elseif(True(index,4) == 7)
%     elseif(True(index,4) == 8)    
%     end
