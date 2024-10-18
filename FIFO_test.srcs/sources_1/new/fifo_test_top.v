`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/18 19:44:16
// Design Name: 
// Module Name: fifo_test_top
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


module fifo_test_top(
  (* mark_debug = "true" *)  input sys_clk,
  (* mark_debug = "true" *)  input sys_rst_n
    );

wire wr_clk;
wire rd_clk;
wire locked;
wire full;
wire empty;
wire almost_empty;
wire almost_full;
wire wr_rst_busy;
wire rd_rst_busy;
wire [7:0] fifo_wr_data;
wire [7:0] fifo_rd_data;
wire [7:0] rd_data_count;
wire [7:0] wr_data_count;
wire fifo_er_en;
wire fifo_rd_en;

assign rst_n = sys_rst_n & locked;
//时钟模块
 clk_wiz_0 myclk
 (
   
  .clk_out1(wr_clk),     // output clk_out1 50m
  .clk_out2(rd_clk),     // output clk_out2 100m
  .locked(locked),       // output locked 标志输出时钟稳定
  .clk_in1(sys_clk)      // input clk_in1
);

//写模块
fifo_wr fifo_wr(
   .wr_clk(wr_clk), //写时钟
   .rst_n(rst_n),
   
   .empty       (empty       )      ,//FIFO空信号，读时钟域下面的信号
   .almost_full (almost_full ),//FIFO将满信号
   .wr_rst_busy (wr_rst_busy ),//FIFO写复位忙信号
   .fifo_er_en  (fifo_er_en  ),//FIFO写使能信号
   .fifo_wr_data(fifo_wr_data) //FIFO写数据

    );
//读模块
fifo_rd fifo_rd(
    .rd_clk(rd_clk)   , //读时钟 100mhz
    .rst_n (rst_n)   ,
    
    .full        (full)   ,//FIFO空信号，写时钟域下面的信号
    .almost_empty(almost_empty)   ,//FIFO将空信号
    .rd_rst_busy (rd_rst_busy )   ,//FIFO读复位忙信号
    .fifo_rd_data(fifo_rd_data)   ,//FIFO读数据
    .fifo_rd_en  (fifo_rd_en  )  //FIFO读使能信号
    
    );

//FIFO IP
fifo_generator_0 myfifo (
  .rst(~rst_n),                    // input wire rst 高有效
  .wr_clk(wr_clk),                // input wire wr_clk
  .rd_clk(rd_clk),                // input wire rd_clk
  .din(fifo_wr_data),             // input wire [7 : 0] din
  .wr_en(fifo_er_en),              // input wire wr_en
  .rd_en(fifo_rd_en),              // input wire rd_en
  .dout(fifo_rd_data),              // output wire [7 : 0] dout
  .full(full),                    // output wire full
  .almost_full(almost_full),      // output wire almost_full
  .empty(empty),                  // output wire empty
  .almost_empty(almost_empty),    // output wire almost_empty
  .rd_data_count(rd_data_count),  // output wire [7 : 0] rd_data_count
  .wr_data_count(wr_data_count),  // output wire [7 : 0] wr_data_count
  .wr_rst_busy(wr_rst_busy),      // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy)      // output wire rd_rst_busy
);



endmodule
