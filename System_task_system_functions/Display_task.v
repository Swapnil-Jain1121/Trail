module tb();
    initial begin
        $strobe("SENTRY::1"); //always scheduled to happen at the end of timestamp
        $strobe("SENTRY::2");
        $strobe("SENTRY::3");
        $strobe("SENTRY::4");
        $strobe("SENTRY::5");
        $display("DENTRY::1"); //$display have the new line at the end of the line by default
        $display("DENTRY::2");
        $display("DENTRY::3");
        $display("DENTRY::4");
        $display("DENTRY::5");
        
    end
endmodule
