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



module stop_watch(
    input start,
    input reset,
    input clock,
    output reg [5:0] sec,min,
    output reg [4:0]hours
    );
    reg [4:0]hours1;
    reg [5:0] sec1,min1;
 
wire clk;
    Clock_divider clk1(.clk(clock),.clkOut(clk));
    always@(posedge clk)
    begin
    if(start)
    begin
        if(sec<=59)
            begin
                sec=sec+1;
                sec1=sec;
            end
         if(sec==60)
            begin
                sec=0;
                min=min+1;
                min1=min;
            end
         if(min==60)
            begin
                min=0;
                hours=hours+1;
                hours1=hours;
            end
         if(hours==24)
            hours=0;
    end 
    if(reset==1&&start==1)
        begin
        sec=0;
        sec1=0;
        min1=0;
        hours1=0;
        min=0;
        hours=0;
    end
    if (start==0&&reset==0)
        begin
        sec=sec1;
        min=min1;
        hours=hours1;
        end
    end
//    Led_seg led(.clk(clock),.secs(sec),.hrs(hours),.mins(min),.Anode(anode),.Cathode(cathode));
endmodule
