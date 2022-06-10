class ram_test;
 
  ram_env env_h;
  
  //interface
  virtual ram_if.WDR_MP  wd_if;
  virtual ram_if.RDR_MP  rd_if;
  virtual ram_if.WMON_MP wm_if;
  virtual ram_if.RMON_MP rm_if;
  
  //testcases
  ram_w_r         wr_h;
  ram_write       write_h;   
  ram_write_reset w_reset_h;
  ram_read_reset  r_reset_h;
  ram_wr_reset    wr_reset_h;
  
  function new (virtual ram_if.WDR_MP  wd_if,
                virtual ram_if.RDR_MP  rd_if,
                virtual ram_if.WMON_MP wm_if,
                virtual ram_if.RMON_MP rm_if);
	this.wd_if = wd_if;
	this.rd_if = rd_if;
	this.wm_if = wm_if;
	this.rm_if = rm_if;
  endfunction
  
  
  task build_and_start();
    env_h = new(wd_if,rd_if,wm_if,rm_if);
	env_h.build();
	
	if ($test$plusargs("RAM_write_read")) begin
	  wr_h 	 	  = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = wr_h;
	end
	
	if ($test$plusargs("RAM_write")) begin
	  write_h     = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = write_h;
	end
	
	if ($test$plusargs("RAM_read_reset")) begin
	  r_reset_h   = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = r_reset_h;
	end
	
	if ($test$plusargs("RAM_write_reset")) begin
	  w_reset_h   = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = w_reset_h;
	end
	
	if ($test$plusargs("RAM_write_read_reset")) begin
	  wr_reset_h  = new(env_h.gen_wd,env_h.gen_rd);
	  env_h.gen_h = wr_reset_h;
	end
	
	env_h.start();
  endtask
  
endclass