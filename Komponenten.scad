// Verstärkergehäuse für ELV V76 2x 38 Watt Audio Verstärker
// Author Lukas Burger, 28. December 2023
include <NPN_Transistor.scad>;
include <Hexagon.scad>;

$fn=60;

b_AC = 30;
t_AC_Kabel = 9;

b = 100+30+1;
t = 113+5;
h = 50+1;
d = 2;

module AudioInStecker(){
    height=10;
    cylinder(h = height, d = 10 );
    translate([15,0 , 0]) cylinder(h = height, d = 10 );
}

module AudioOutStecker(){
    height=10;
    cylinder(h = height, d = 15 );
    translate([0, -10.5, 0]) cylinder(h = height, d = 3.5 );
    translate([0,  10.5, 0]) cylinder(h = height, d = 3.5 );   
}

module DCKabelEingang(){
    height=30;
    difference() {
        cube([b_AC, t_AC_Kabel, height]);
        translate([10, 0, 0]) cube([9+5, t_AC_Kabel, height]);
    }
}

module InnenMasse(){
difference(){
        cube([b, t, h]);
        cube([8, 15, 5]); // Auflage 1
        translate([b-30-8, 0, 0]) cube([8, 15, 5]); // Auflage 2
        translate([19, 0, 24]) cube([20, 7, 20]); // PowerSwitch
        translate([b-b_AC, 0, 0]) DCKabelEingang();
    }
    translate([4, 9, -2]) cylinder(h=10, d=3.5); // Schraubenloch 1
    translate([4, 9, -2]) cylinder(h=3, d=6); // Schraubenkopf 1
    translate([b-30-4, 9, -2]) cylinder(h=10, d=3.5); // SchraubenLoch 2
    translate([b-30-4, 9, -2]) cylinder(h=3, d=6); // Schraubenkopf 2
}

module PowerSwitch(){
    nut_height=3;
    union() {
        cylinder(h=10, d=11);
        translate([0,0,nut_height/2]) hexagon(side=8.5, height=nut_height, center=true);
    }
}

module AussenMasse(){
    cube([b+2*d, t+2*d, h+d]);
}    

module Airgap(){
    cube([35, 5, 10]);
}

module Airgaps(){
    translate([0, 0,0]) Airgap();
    translate([0,10,0]) Airgap();
    translate([0,20,0]) Airgap();
    translate([0,30,0]) Airgap();
    translate([0,40,0]) Airgap();
    translate([60, 0,0]) Airgap();
    translate([60,10,0]) Airgap();
    translate([60,20,0]) Airgap();
    translate([60,30,0]) Airgap();
    translate([60,40,0]) Airgap();
}

module Logo(){
    linear_extrude(3) {
        text( "AUDIO", size= 14);
    }
}

module Beschriftung(){
    size=8;
    linear_extrude(0.5) {
        text( "       ELV V76", size=size);
        translate([0, -2*size,0]) text( "2x 38-W-Audio-Verstärker", size=size);
        translate([0, -4*size,0]) text( "Gehäuse von Igramul", size=size);
        translate([0, -6*size,0]) text( "Version I - 28.12.2023", size=size);
    }
}

module Gehaeuse(){
    difference(){
        AussenMasse();
        translate([d,d,d]) InnenMasse();
        translate([71, 5, 13]) rotate([90, 0, 0]) AudioInStecker();
        translate([71-2, 5, 35]) rotate([90, 0, 0]) AudioOutStecker();
        translate([71+2+15, 5, 35]) rotate([90, 0, 0]) AudioOutStecker();
        translate([50,5,40]) rotate([90,0,0]) cylinder(h=10, d=5.1); // LED1
        translate([50,5,30]) rotate([90,0,0]) cylinder(h=10, d=5.1); // LED2
        translate([30,0,35]) rotate([-90,0,0]) PowerSwitch();    
        translate([b-20-5.5,t,8]) cube([20, 10, 25]); // Netzstecker
        translate([d+5, t-50, 0]) Airgaps();
        translate([3, 0.5, 6.25]) rotate([90, 0, 0]) Logo();
        translate([55, 0, 13]) scale([0.7, 1, 0.7]) rotate([90, 0, 0]) NPN_Circuit();
        translate([115, 0, 25]) rotate([90, 0, 0]) NPN_Transistor();
        translate([5, 15, 0.2]) rotate([180, 0, 0]) Beschriftung();
    }
}

module Deckel(){
    difference(){
        cube([b+2*d, t+2*d, d]);
        translate([d+5, t-50, -5]) Airgaps();
    }
}   
