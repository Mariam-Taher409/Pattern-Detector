module pattern_detector(
    input reset,
    input clk,
    input stream_in,     
    output reg pattern_found   
);  


//---------------------------------- State Register Width-----------------------------------------/
parameter state_register_width =3; //using 6 states 

//----------------------------------Indentify the States and Their Values---------------------------------/
parameter [state_register_width -1:0] state0=3'd0,
                                      state1=3'd1,
                                      state2=3'd2,
                                      state3=3'd3,
                                      state4=3'd4,
                                      state5=3'd5; /*note that :-each state is 3 bits long
                                                        -# of states=2^reg width 
                                                        -here,we choose only 6 states of the available 8 states*/

reg [state_register_width -1:0]curr_state, next_state;    
    
//-----------------------------------State Register & Output in the Same always Block-----------------------------------/
always@(posedge clk)begin
    if(reset) begin
        curr_state <=state0;
    end
    else begin
        curr_state <=next_state;

        case(curr_state)

        state0: begin
            pattern_found = 0;
            if(stream_in) begin
                next_state <=state1;
            end
            else begin
                next_state <=state0;
            end
        end
        
        state1: begin
            pattern_found = 0;
            if(stream_in) begin
                next_state <=state2;
            end
            else begin
                next_state <=state1;
            end
        end

        state2: begin
            pattern_found = 0;
            if(stream_in ==0) begin
                next_state <=state3;
            end
            else begin
                next_state <=state2;
            end    
        end

        state3: begin
            pattern_found = 0;
            if(stream_in) begin
                next_state <=state4;
            end
           
        end

        state4: begin
            pattern_found = 0;
            if(stream_in ==0) begin
                next_state <=state5;
            end
            else begin
                next_state <=state2;
            end
        end

        state5: begin
            pattern_found = 1;
            if(stream_in) begin
                next_state <=state1;
            end
            else begin
                next_state <=state5;
            end
        end


    endcase


    end
end


endmodule