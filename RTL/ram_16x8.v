//RAM 16x8
`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 

module ram (clk,
            rst,
            wr_enb,
            wr_addr,
            wr_data,
            rd_enb,
            rd_addr,
            rd_data);

//port direction
  input clk, rst;

 //write signals
  input                   wr_enb;
  input [`ADDR_WIDTH-1:0] wr_addr;
  input [`DATA_WIDTH-1:0] wr_data;

 //read signals
  input                        rd_enb;
  input      [`ADDR_WIDTH-1:0] rd_addr;
  output reg [`DATA_WIDTH-1:0] rd_data;


 //internal memory
 reg [`DATA_WIDTH-1:0] ram [0:`DEPTH-1];

 reg [`ADDR_WIDTH:0] i;

 //implementation
 always@(posedge clk)
  if (rst) begin
     rd_data <= `DATA_WIDTH'd0;
	 //memory initialisation
     for (i=0;i<`DEPTH;i=i+1) 
         ram[i] <= `DATA_WIDTH'd0;
  end
  else begin
    //write logic
     if (wr_enb)
        ram[wr_addr] <= wr_data;
    //read logic
     if (rd_enb)
        rd_data <= ram[rd_addr];
  end

endmodule
