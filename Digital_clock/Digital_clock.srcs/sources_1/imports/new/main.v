`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2024 15:47:14
// Design Name: 
// Module Name: main
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


module main(
input up,left,down,right,
input load,
input clock,
input alaram,
input start,
input reset,
output [3:0]anode,
output [6:0]cathode,
output reg [5:0]sec,
output reg out
    );
//     reg up,down,right,left;
    wire [5:0]sec1,min1,sec2,min2,sec4,min4,sec5,min5;
    wire [4:0] hour1,hour2,hour4,hour5;
    reg [5:0] min,sec3,min3;
    reg [4:0] hour,hour3;
    reg ld;
    reg up1,up2,down1,down2,left1,left2,right1,right2;
    initial 
    begin
    sec3=0;
    min3=0;
    hour3=0;
    up1=0;
    up2=0;
    down1=0;
    down2=0;
    left1=0;
    left2=0;
    right1=0;
    right2=0;
    sec=0;
    out=0;
    end
    Clock dup(.clock(clock),.sec(sec1),.min(min1),.hour(hour1),.sec1(sec3),.min1(min3),.hour1(hour3),.ld(load));
    set_load set(.up(up1),.down(down1),.right(right1),.left(left1),.hour(hour1),.mint(min1),.sec(sec1),.secs(sec2),.mins(min2),.hrs(hour2),.load(load));
    alaram set1(.up(up2),.down(down2),.right(right2),.left(left2),.hour(hour2),.mint(min1),.sec(sec1),.secs(sec4),.mins(min4),.hrs(hour4),.load(alaram));
    stop_watch watch1(.start(start),.reset(reset),.sec(sec5),.min(min5),.hours(hour5),.clock(clock));
    always@(*) 
    begin 
    if(load==0 &&alaram==0)
        begin
        sec=sec1;
        min=min1;
        hour=hour1;
        end
     if(load==1)
        begin
        sec=sec2;
        min=min2;
        if (hour2>23)hour=20;
            else hour=hour2;
        end
    if (alaram==1)
        begin
        sec=sec4;
        min=min4;
        hour=hour4;
        end
     if(start==1&&load==0&&alaram==0)
        begin
        sec=sec5;
        min=min5;
        hour=hour5;
        end
    end
    always@(*)
    begin
    if(load)
    begin
    sec3=sec;
    min3=min;
    hour3=hour;
    end
    end
    always@(*)
    begin
    if(alaram==1)
    begin
    up1=0;
    up2=up;
    down1=0;
    down2=down;
    left1=0;
    left2=left;
    right1=0;
    right2=right;
    end
    if(load==1)
    begin
    up1=up;
    up2=0;
    down1=down;
    down2=0;
    left1=left;
    left2=0;
    right1=right;
    right2=0;
    end
    end
    always@(*)
    begin
    if(min4==min1&&hour4==hour1)
    begin
    out=1'b1;
    end
    end
    Led_seg seg(.start(start),
    .clk(clock),.hrs(hour),.secs(sec),.mins(min),.Anode(anode),.Cathode(cathode));
endmodule
