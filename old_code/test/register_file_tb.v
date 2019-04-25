module reg_file_tb();
  reg Clk, Reset, Write;
  reg [4:0] PR1, PR2, WR;
  reg [31:0] WD;
  wire [31:0] RD1, RD2;
  reg_file DUT(Clk, Reset, Write, PR1, PR2, WR, WD, RD1, RD2);
  
  always begin
    #5 Clk = ~Clk;  
  end
  
  initial begin
    Clk <= 0;
    Reset <= 1;
    #10
    Reset <= 0;
    Write <= 1;
    WR <= 4;  //Write data to the rf[4]
    WD <= 31; //The new data is 31 at rf[4]
    #10
    Write <= 0; 
    PR1 <= 6; //Reading the rf[6] data, which is 6
    PR2 <= 8; //Reading the rf[8] data, which is 8
    #20
    Reset <= 1; //reset the RD1, RD2 to 0 
    #7.5
    Reset <= 0;
    PR1 <= 10;  
    PR2 <= 12;
    //On the same clock cycle, it reads rf[10] data, which is 10 and rf[12], which is 12 on falling edge
    Write <= 0;     
    #5
    //On the same clock cycle as above comment (Write <= 0), it writes rf[20] to 1 on the raising edge
    Write <= 1; 
    WD <= 20;
    WR <= 1;
    #10
    $stop;
  end
  
endmodule