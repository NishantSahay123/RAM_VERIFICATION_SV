class ram_env;
    
   ram_gen gen_h;
   ram_wd  wd_h;
   ram_wm  wm_h;
   ram_rd  rd_h;
   ram_rm  rm_h;
   ram_rf  rf_h;
   ram_sb  sb_h;
   
   //mailbox
   mailbox #(ram_trans) gen_wd=new();
   mailbox #(ram_trans) gen_rd=new();
   mailbox #(ram_trans) wm_rf=new();
   mailbox #(ram_trans) rm_rf=new();
   mailbox #(ram_trans) rf_sb=new();
   mailbox #(ram_trans) rm_sb=new();
   
  //interface
  virtual ram_if.WDR_MP  wd_if;
  virtual ram_if.RDR_MP  rd_if;
  virtual ram_if.WMON_MP wm_if;
  virtual ram_if.RMON_MP rm_if;
   
  function new (virtual ram_if.WDR_MP  wd_if,
                virtual ram_if.RDR_MP  rd_if,
                virtual ram_if.WMON_MP wm_if,
                virtual ram_if.RMON_MP rm_if);
	this.wd_if = wd_if;
	this.rd_if = rd_if;
	this.wm_if = wm_if;
	this.rm_if = rm_if;
  endfunction
  
  function void build();
    gen_h = new(gen_wd,gen_rd);
	wd_h  = new(gen_wd,wd_if);
	rd_h  = new(gen_rd,rd_if);
	wm_h  = new(wm_rf,wm_if);
	rm_h  = new(rm_rf,rm_sb,rm_if);
	rf_h  = new(wm_rf,rm_rf,rf_sb);
	sb_h  = new(rf_sb,rm_sb);
  endfunction
  
  task start();
   fork 
	 gen_h.start(); 
	 wd_h.start();  
	 rd_h.start();
	 wm_h.start();
	 rm_h.start();
	 rf_h.start();
	 sb_h.start();
   join_none
  endtask

endclass  