class ram_rd;

 ram_trans trans_h;
 
 //mailbox
  mailbox #(ram_trans) gen_rd;

 //interface
 virtual ram_if.RDR_MP vif;


 function new (mailbox #(ram_trans) gen_rd, 
               virtual ram_if.RDR_MP vif);
	this.gen_rd = gen_rd;
	this.vif = vif;
 endfunction
 
 task start();
   trans_h = new();
   reset();
   forever begin
     gen_rd.get(trans_h);
	 send_to_dut();
	 @(vif.rdr_cb);
   end
 endtask
 
 task send_to_dut();
   vif.rdr_cb.rst     <= trans_h.rst;
   vif.rdr_cb.rd_enb  <= trans_h.rd_enb;
   vif.rdr_cb.rd_addr <= trans_h.rd_addr;
 endtask
 
 task reset();
	@(vif.rdr_cb);
	trans_h.rst = 1;
	vif.rdr_cb.rst <= trans_h.rst;
	@(vif.rdr_cb);
	trans_h.rst = 0;
	vif.rdr_cb.rst <= trans_h.rst;
  endtask
  
endclass