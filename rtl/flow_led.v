module flow_led(
    input               sys_clk  ,
    input               sys_rst_n,
    
    output reg [3:0]    led
);

//reg define
reg[23:0] counter;

//*****************************************************
//** main code
//*****************************************************

//计数器对系统时钟计数，计时0.2秒
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        counter <= 24'd0;
    else if (counter < 24'd0100_0000)
        counter <= counter + 1'b1;
    else
        counter <= 24'd0;
end

//通过移位寄存器控制IO口的高低电平，从而改变LED的显示状态
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)
        led <= 4'b0001;
    else if(counter == 24'd0100_0000)
        led[3:0] <= {led[2:0],led[3]};
    else
        led <= led;
end

endmodule