`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/18 20:14:34
// Design Name: 
// Module Name: fifo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_tb(

    );

//parameter define
parameter CLK_PERIOD = 20; //50MHz系统时钟(一个周期是20ns：1/50MHz=0.02us=20ns)
                            //200MHz系统时钟(一个周期是5ns：1/200MHz=0.005us=5ns)
//reg define
reg   sys_clk;
reg   sys_rst_n;
 
//信号初始化
initial begin
    sys_clk = 1'b0;
    sys_rst_n = 1'b0;
    #200
    sys_rst_n = 1'b1;
end
//产生时钟
always #(CLK_PERIOD/2) sys_clk = ~sys_clk;
fifo_test_top fifo_test_top(
    .sys_clk      (sys_clk       ),
    .sys_rst_n    (sys_rst_n     )
    );

endmodule
