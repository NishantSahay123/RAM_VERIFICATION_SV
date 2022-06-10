module ram_top();

import ram_pkg::*;

  ram_test test_h;
  bit clk;
  ram_if inf(clk);
  
  //dut instattiation
  ram DUT ( .clk(inf.clk),
            .rst(inf.rst),
			.wr_enb(inf.wr_enb),
			.wr_addr(inf.wr_addr),
			.wr_data(inf.wr_data),
			.rd_enb(inf.rd_enb),
			.rd_addr(inf.rd_addr),
			.rd_data(inf.rd_data));			
	
   always #5 clk = ~clk;
  
  initial begin
   clk = 0;
   test_h = new(inf,inf,inf,inf);
   test_h.build_and_start();
   #1000 $finish;
  end
  
endmodule