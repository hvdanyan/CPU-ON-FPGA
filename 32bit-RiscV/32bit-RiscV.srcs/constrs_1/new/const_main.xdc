##CLK
set_property PACKAGE_PIN H4 [get_ports CLK100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHz]
create_clock -period 10 [get_ports CLK100MHz]
#set_property PACKAGE_PIN W19 [get_ports CLK50MHz]
#set_property IOSTANDARD LVCMOS33 [get_ports CLK50MHz]
#set_property PACKAGE_PIN Y18 [get_ports CLK3Hz]
#set_property IOSTANDARD LVCMOS33 [get_ports CLK3Hz]

#BUTTONS
set_property PACKAGE_PIN F4 [get_ports key[0]]
set_property IOSTANDARD LVCMOS33 [get_ports key[0]]
set_property PACKAGE_PIN C2 [get_ports key[1]]
set_property IOSTANDARD LVCMOS33 [get_ports key[1]] 
set_property PACKAGE_PIN B2 [get_ports key[2]]
set_property IOSTANDARD LVCMOS33 [get_ports key[2]] 
set_property PACKAGE_PIN E2 [get_ports key[3]]
set_property IOSTANDARD LVCMOS33 [get_ports key[3]]
set_property PACKAGE_PIN D2 [get_ports key[4]]
set_property IOSTANDARD LVCMOS33 [get_ports key[4]]
set_property PACKAGE_PIN U22 [get_ports key[5]]
set_property IOSTANDARD LVCMOS33 [get_ports key[5]]
set_property PACKAGE_PIN V22 [get_ports key[6]]
set_property IOSTANDARD LVCMOS33 [get_ports key[6]]
set_property PACKAGE_PIN T21 [get_ports key[7]]
set_property IOSTANDARD LVCMOS33 [get_ports key[7]]
set_property PACKAGE_PIN W20 [get_ports key[8]]
set_property IOSTANDARD LVCMOS33 [get_ports key[8]]

##SWITCHES
set_property PACKAGE_PIN AA19 [get_ports ina[0]]
set_property IOSTANDARD LVCMOS33 [get_ports ina[0]]
set_property PACKAGE_PIN V19 [get_ports ina[1]]
set_property IOSTANDARD LVCMOS33 [get_ports ina[1]]
set_property PACKAGE_PIN V18  [get_ports ina[2]]
set_property IOSTANDARD LVCMOS33 [get_ports ina[2]]
set_property PACKAGE_PIN Y19 [get_ports ina[3]]
set_property IOSTANDARD LVCMOS33 [get_ports ina[3]]
set_property PACKAGE_PIN V20 [get_ports inb[0]]
set_property IOSTANDARD LVCMOS33 [get_ports inb[0]]
set_property PACKAGE_PIN U20 [get_ports inb[1]]
set_property IOSTANDARD LVCMOS33 [get_ports inb[1]]
set_property PACKAGE_PIN AB22 [get_ports inb[2]]
set_property IOSTANDARD LVCMOS33 [get_ports inb[2]]
set_property PACKAGE_PIN AB21 [get_ports inb[3]]
set_property IOSTANDARD LVCMOS33 [get_ports inb[3]]

##LED
#LED
set_property PACKAGE_PIN AA21 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led[0]]
set_property PACKAGE_PIN AA20 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led[1]]
set_property PACKAGE_PIN W22 [get_ports led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led[2]]
set_property PACKAGE_PIN W21 [get_ports led[3]]
set_property IOSTANDARD LVCMOS33 [get_ports led[3]]
set_property PACKAGE_PIN T20 [get_ports led[4]]
set_property IOSTANDARD LVCMOS33 [get_ports led[4]]
set_property PACKAGE_PIN R19 [get_ports led[5]]
set_property IOSTANDARD LVCMOS33 [get_ports led[5]]
set_property PACKAGE_PIN P19 [get_ports led[6]]
set_property IOSTANDARD LVCMOS33 [get_ports led[6]]
set_property PACKAGE_PIN U21 [get_ports led[7]]
set_property IOSTANDARD LVCMOS33 [get_ports led[7]]

##DIGITRON 4 tubes without decoding
set_property PACKAGE_PIN N15 [get_ports {digitron_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_out[0]}]
set_property PACKAGE_PIN R17 [get_ports {digitron_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_out[1]}]
set_property PACKAGE_PIN P16 [get_ports {digitron_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_out[2]}]
set_property PACKAGE_PIN N14 [get_ports {digitron_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_out[3]}]
set_property PACKAGE_PIN N13 [get_ports {digitron_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_out[4]}]
set_property PACKAGE_PIN R16 [get_ports {digitron_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_out[5]}]
set_property PACKAGE_PIN P15 [get_ports {digitron_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_out[6]}]
set_property PACKAGE_PIN P17 [get_ports {digitron_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_out[7]}]
set_property PACKAGE_PIN R14 [get_ports {digitron_sel[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_sel[0]}]
set_property PACKAGE_PIN R18 [get_ports {digitron_sel[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_sel[1]}]
set_property PACKAGE_PIN T18 [get_ports {digitron_sel[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_sel[2]}]
set_property PACKAGE_PIN N17 [get_ports {digitron_sel[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitron_sel[3]}]

##DIGITRON 2 tubes with decoding
set_property PACKAGE_PIN P14 [get_ports {digitronA_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitronA_out[0]}]
set_property PACKAGE_PIN U18 [get_ports {digitronA_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitronA_out[1]}]
set_property PACKAGE_PIN U17 [get_ports {digitronA_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitronA_out[2]}]
set_property PACKAGE_PIN AB18 [get_ports {digitronA_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitronA_out[3]}]
set_property PACKAGE_PIN AA18 [get_ports {digitronB_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitronB_out[0]}]
set_property PACKAGE_PIN W17 [get_ports {digitronB_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitronB_out[1]}]
set_property PACKAGE_PIN V17 [get_ports {digitronB_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitronB_out[2]}]
set_property PACKAGE_PIN AB20 [get_ports {digitronB_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitronB_out[3]}]

#IO PIN JD2
#set_property PACKAGE_PIN Y11 [get_ports {instraddr[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {instraddr[0]}]
#set_property PACKAGE_PIN V13 [get_ports {instraddr[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {instraddr[1]}]
#set_property PACKAGE_PIN U15 [get_ports {instraddr[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {instraddr[2]}]
#set_property PACKAGE_PIN W15 [get_ports {instraddr[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {instraddr[3]}]
#set_property PACKAGE_PIN T16 [get_ports {instraddr[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {instraddr[4]}]
#set_property PACKAGE_PIN AB12 [get_ports {instraddr[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {instraddr[5]}]
#set_property PACKAGE_PIN Y11 [get_ports {instraddr[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {instraddr[6]}]