//primtives are not synthesizable
primitive mux2x1(y,in1,in0,sel);
input in1,in0,sel;
output y;

table
//input : output;
// in1 in0 sel : y
0   0   0   :   0;
0   1   0   :   1;
1   0   1   :   1;
0   0   1   :   0;
endtable
endprimitive

