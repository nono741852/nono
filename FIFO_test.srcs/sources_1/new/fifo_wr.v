`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: nono
// 
// Create Date: 2024/10/18 18:59:44
// Design Name: fifo写模块
// Module Name: fifo_wr
// Project Name: fifo_test
// Target Devices: 
// Tool Versions: vivado2023.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_wr(
    input               wr_clk, //写时钟
    input               rst_n,
    //FIFO相关的端口
   (* mark_debug = "true" *) input                empty       ,//FIFO空信号，读时钟域下面的信号
   (* mark_debug = "true" *) input                almost_full ,//FIFO将满信号
   (* mark_debug = "true" *) input                wr_rst_busy ,//FIFO写复位忙信号
   (* mark_debug = "true" *) output   reg         fifo_er_en  ,//FIFO写使能信号
   (* mark_debug = "true" *) output   reg [7:0]   fifo_wr_data //FIFO写数据

    );

reg empty_d0;
reg empty_d1;
//对空信号打两拍——同步到写时钟域下
always @(posedge wr_clk or negedge rst_n) begin
    if(!rst_n) begin
        empty_d0 <= 1'b0;
        empty_d1 <= 1'b0;
    end
    else begin
        empty_d0 <= empty;
        empty_d1 <= empty_d0;    
    end
end

//对写使能fifo_er_en信号赋值：当fifo为空开始写入，写满后停止写
always @(posedge wr_clk or negedge rst_n) begin
    if(!rst_n) begin
        fifo_er_en <= 1'b0;
    end
    else if (!wr_rst_busy) begin
        if(empty_d1) begin  
            fifo_er_en <= 1'b1;
        end
        else if(almost_full) begin
            fifo_er_en <= 1'b0;
        end
        end
 end

    
//对写数据进行赋值：0~254
always @(posedge wr_clk or negedge rst_n) begin
    if(!rst_n) begin
        fifo_wr_data <= 8'b0;
    end
    else if(fifo_er_en && fifo_wr_data<254)
        fifo_wr_data <= fifo_wr_data+1'b1;
    else
        fifo_wr_data <= 8'b0;
end




endmodule
