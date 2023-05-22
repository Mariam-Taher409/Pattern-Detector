module pattern_tb;

parameter clk_period =10ns;
reg clk=0;
always#(clk_period /2)  clk= ~clk;

reg reset , stream_in_tb ;
wire pattern_found_tb;

pattern_detector X(
    .clk(clk),
    .reset(reset),
    .stream_in(stream_in_tb),
    .pattern_found(pattern_found_tb)
);

initial begin
    clk =0;
    reset =1;

    #(clk_period);
    stream_in_tb =1'b0;
     #(clk_period);
    stream_in_tb =1'b1;
     #(clk_period);
    stream_in_tb =1'b1;
     #(clk_period);
    stream_in_tb =1'b0;
     #(clk_period);
    stream_in_tb =1'b1;
     #(clk_period);
    stream_in_tb =1'b0;
     #(clk_period);
    stream_in_tb =1'b1;
     #(clk_period);
    
    if(pattern_found_tb)
    $display("The Pattern found.");
    $finish();

end


endmodule
