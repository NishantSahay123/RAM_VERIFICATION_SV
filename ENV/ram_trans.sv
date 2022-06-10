`define ADDR_WIDTH 4
`define DEPTH 16
`define DATA_WIDTH 8 

class ram_trans;
   
   bit rst;
   
//write_signals
   rand  bit wr_enb;
   randc bit [`ADDR_WIDTH-1:0] wr_addr;
   rand  bit [`DATA_WIDTH-1:0] wr_data;

//read_signals
   rand   bit rd_enb;
   randc  bit [`ADDR_WIDTH-1:0] rd_addr;
          bit [`DATA_WIDTH-1:0] rd_data;

//reference model 
   static logic [`DATA_WIDTH-1:0] rm_rf [0:`DEPTH-1];
   static logic [`DATA_WIDTH-1:0] exp_data;
	
   constraint ADR {wr_addr!=rd_addr;}

endclass
