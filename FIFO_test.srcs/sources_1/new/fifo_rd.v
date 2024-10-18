`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/18 19:28:36
// Design Name: 
// Module Name: fifo_rd
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


module fifo_rd(
   (* mark_debug = "true" *) input               rd_clk          , //读时钟 100mhz
   (* mark_debug = "true" *) input               rst_n           ,
    //FIFO_debug的端true
   (* mark_debug = "true" *) input                full           ,//FIFO空信号，写时钟域下面的信号
   (* mark_debug = "true" *) input                almost_empty   ,//FIFO将空信号
   (* mark_debug = "true" *) input                rd_rst_busy    ,//FIFO读复位忙信号
   (* mark_debug = "true" *) input   [7:0]        fifo_rd_data   ,//FIFO读数据
   (* mark_debug = "true" *) output   reg         fifo_rd_en     //FIFO读使能信号
    
    );



reg full_d0;
reg full_d1;
//对满信号打两拍——同步到读时钟域下
always @(posedge rd_clk or negedge rst_n) begin
    if(!rst_n) begin
        full_d0 <= 1'b0;
        full_d1 <= 1'b0;
    end
    else begin
        full_d0 <= full;
        full_d1 <= full_d0;    
    end
end



//对读使能fifo_rd_en信号赋值：当fifo写满开始读，读空后停止读
always @(posedge rd_clk or negedge rst_n) begin
    if(!rst_n) begin
        fifo_rd_en <= 1'b0;
    end
    else if (!rd_rst_busy) begin
        if(full_d1) begin  
            fifo_rd_en <= 1'b1;
        end
        else if(almost_empty) begin
            fifo_rd_en <= 1'b0;
        end
    end
 end




endmodule


