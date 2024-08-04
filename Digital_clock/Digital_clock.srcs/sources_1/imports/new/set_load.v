`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2024 11:52:37
// Design Name: 
// Module Name: Set_Time
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

module set_load(input load,input left,right,up,down, input [4:0] hour,input[5:0] mint,input [5:0]sec, output reg [4:0]hrs, output reg [5:0]mins, output reg [5:0] secs);
reg [1:0]count,count1,count2;
reg l,r,u,d;  
reg [5:0] mins1,mins2; 
reg [4:0] hrs1,hrs2;
initial 
begin
count=0; 
count1=0;
count2=0;
hrs1=0;
hrs2=0;
mins1=0;
mins2=0;
secs=0;
//mins=mint;
//hrs=hour;
end
always @(posedge left)
    begin
    if (count>0)
    count1<=count1-1;
    else if (count==0)
    count1<=3;   
    end

always @(posedge right)
    count2<=(count+1)%4;




always @(posedge up)
    begin
    if(load==1)
    begin
    case (count)
    0:
    if((hrs%10)>=4&&(hrs/10)==1)
    hrs1<=hrs-10;
    else
    hrs1<=(hrs+10)%30;
    
    1:
    if (hrs==23)
    hrs1<=20;
    else if ((hrs%10)<9)
    hrs1<=hrs1+1;
    else
    hrs1<=hrs-9;
    
    2:mins1<=(mins+10)%60;

    3:
    if ((mins%10)<9)
    mins1<=mins+1;
    else 
    mins1<=mins-9;
    endcase
    end
//    if(load==0)
//    begin
//    hrs1=0;
//    mins1=0;
//    end
    end
    
    
    
always @(posedge down)
    begin
    if(load==1)
    begin
    case (count)
    0:
    begin
    if (hrs>=10)
    hrs2<=hrs-10;
    else if ((hrs%10)>3)
    hrs2<=hrs;
    else
    hrs2<=hrs+20;
    end
    
    1:
    begin
    if (hrs==20)
    hrs2<=20;
    else if ((hrs%10)>0)
    hrs2<=hrs-1;
    else
    hrs2<=hrs+9;
    end
    
    2:
    begin
    if (mins>=10)
    mins2<=mins-10;
    else
    mins2<=mins+50;
    end
    
    3:
    begin
    if ((mins%10)>0)
    mins2<=mins-1;
    else
    mins2<=mins+9;
    end
    endcase
    end
//    if(load==0)
//    begin
//    hrs2=0;
//    mins2=0;
//    end
    end


always @(*)
begin 
if (up)
begin
u<=1;
d<=0;
end
if (down)
begin
u<=0;
d<=1;
end
if (left)
begin
l<=1;
r<=0;
end
if (right)
begin
l<=0;
r<=1;
end
end

always @(*)
begin
count=count1*l+count2*r;
hrs=(hrs1*u+hrs2*d)*load;
mins=(mins1*u+mins2*d)*load;
end
//reg u1,d1;
//always@(*)
//begin
//if(load==0)
//    begin
//    u1=0;
//    d1=0;
//    end
//if(load==1&&up==1)
//    begin
//    u1=1;
//    d1=0;
//    end
//if(load==1&&down==1)
//    begin
//    u1=0;
//    d1=1;
//    end
//end
endmodule