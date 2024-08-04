`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2024 22:00:01
// Design Name: 
// Module Name: Clock
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



module Clock(
    input clock,
    input [5:0] sec1,
    input [5:0] min1,
    input [4:0] hour1,
    input ld,
    output reg [5:0]sec,
    output reg [5:0]min, 
    output reg [4:0]hour
    );
    wire clk;
    initial
    begin
    sec=0;
    min=0;
    hour=0;
    end
    Clock_divider clk1(.clk(clock),.clkOut(clk));
    always@(posedge clk)
    begin
    if(ld)
    begin
    sec=sec1;
    min=min1;
    hour=hour1;
    end
    else
    begin
         if(sec<=59)
            begin
                sec=sec+1;
            end
          if(sec==60)
            begin
                sec=0;
                min=min+1;
            end
         if(min==60)
            begin
                min=0;
                hour=hour+1;
            end
         if(hour==24)
            hour=0;
    end
    end 
endmodule
