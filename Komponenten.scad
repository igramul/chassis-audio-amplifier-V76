// Verstärkergehäuse für ELV V76 2x 38 Watt Audio Verstärker
// Author Lukas Burger, 28. December 2023
include <NPN_Transistor.scad>;
include <Hexagon.scad>;

$fn=60;

b_AC = 30;
t_AC = 104.5;
h_AC = 44;

b_AC_Kabel = 9;
t_AC_Kabel = 9;

b = 100+1+b_AC;
t = 113+5;
h = 50+1;
d = 2;

s_AudioIn=15;

module AudioInStecker(){
    height=d;
    cylinder(h = height, d = 10 );
    translate([s_AudioIn, 0, 0]) cylinder(h = height, d = 10 );
}
//AudioInStecker();

module AudioOutStecker(){
    height=d;
    cylinder(h = height, d = 15 );
    translate([0, -10.5, 0]) cylinder(h = height, d = 3.5 );
    translate([0,  10.5, 0]) cylinder(h = height, d = 3.5 );
}
//AudioOutStecker();

module LedBlende(){
    height=6;
    cylinder(h=height, d=8);
    translate([0, 10, 0]) cylinder(h=height, d=8);
    translate([0, 5, height/2]) cube([8, 10, height], center=true);
}
//LedBlende();

module LedLoecher(){
    height=6;
    cylinder(h=height, d=5.1);
    translate([0, 10, 0]) cylinder(h=height, d=5.1);
}
//LedLoecher();

module DCKabelEingang(){
    height=30;
    difference() {
        cube([b_AC, t-t_AC, height]);
        translate([10, t-t_AC-t_AC_Kabel, 0]) cube([b_AC_Kabel, t_AC_Kabel, height]);
    }
}
//DCKabelEingang();

module PowerSwitch(){
    nut_height=3;
    heigth=7;
    difference(){
        cylinder(h=heigth, d=20);
        union() {
            cylinder(h=heigth, d=10.5);
            translate([0,0,nut_height/2]) hexagon(side=8.5, height=nut_height, center=true);
        }
        translate([0,0, heigth-1]) difference(){
            cylinder(h=1, d=14.5);
            cylinder(h=1, d=13.5);
        }
    }
}
//PowerSwitch();

module PowerSwitchNutPart(){
    translate([0,0,d/2]) hexagon(side=8.5, height=d, center=true);
}
//PowerSwitchNutPart();

module Airgaps(bottom=true){
    heigth=d;
    x_AirGap=40;
    s_AirGap=20;
    x_b = bottom ? 15 : 0;
    translate([5,   0, 0]) cube([x_AirGap-5, 5, d]);
    translate([5,  10, 0]) cube([x_AirGap-5, 5, d]);
    translate([5,  20, 0]) cube([x_AirGap-5, 5, d]);
    translate([5,  30, 0]) cube([x_AirGap-5, 5, d]);
    translate([5+x_b,  40, 0]) cube([x_AirGap-x_b-5, 5, d]);
    translate([x_AirGap+s_AirGap,  0, 0]) cube([x_AirGap, 5, d]);
    translate([x_AirGap+s_AirGap, 10, 0]) cube([x_AirGap, 5, d]);
    translate([x_AirGap+s_AirGap, 20, 0]) cube([x_AirGap, 5, d]);
    translate([x_AirGap+s_AirGap, 30, 0]) cube([x_AirGap, 5, d]);
    translate([x_AirGap+s_AirGap, 40, 0]) cube([x_AirGap, 5, d]);
}
//Airgaps();

module PlasticScrew(){
    cylinder(h=11, d=1.5);
    cylinder(h=3, d1=5.2, d2=1.5); // Kopf
}
//PlasticScrew();

module PlasticScrewsAll(){
    translate([-d, 10-d,    h-4]) rotate([0,  90, 0]) PlasticScrew();
    translate([-d, t/2,     h-4]) rotate([0,  90, 0]) PlasticScrew();
    translate([50  , t+d,   h-4]) rotate([90,  0, 0]) PlasticScrew();
    translate([b+d, 10-d,   h-4]) rotate([0, -90, 0]) PlasticScrew();
    translate([b+d, t-10+d, h-4]) rotate([0, -90, 0]) PlasticScrew();
}

module InnenMasse(){
    x_PowerSwitch=25;
    y_PowerSwitch=34;
difference(){
        cube([b, t, h]);
        t_Auflage=20;
        h_Auflage=5;
        cube([9, t_Auflage, h_Auflage]); // Auflage 1
        translate([b-b_AC-9, 0, 0]) cube([9, t_Auflage, h_Auflage]); // Auflage 2
        translate([b-b_AC, 0, 0]) DCKabelEingang();
        translate([x_PowerSwitch, -d, y_PowerSwitch]) rotate([-90, 0, 0]) PowerSwitch();
        translate([48, 6-d, 29]) rotate([90, 0, 0]) LedBlende();
    }
    x_AudioIn=72;
    y_AudioIn=13;
    translate([x_PowerSwitch, -d, y_PowerSwitch]) rotate([-90, 0, 0]) PowerSwitchNutPart();
    translate([x_AudioIn, 0, y_AudioIn]) rotate([90, 0, 0]) AudioInStecker();
    translate([x_AudioIn-2,           0, 34]) rotate([90, 0, 0]) AudioOutStecker();
    translate([x_AudioIn+2+s_AudioIn, 0, 34]) rotate([90, 0, 0]) AudioOutStecker();
    translate([0, 67, -d]) Airgaps();
    translate([48,      6-d, 29]) rotate([90, 0, 0]) LedLoecher();
    translate([b-19-6.5, t, 7]) cube([19, d, 24]); // Netzstecker
    s_ScrewHoles=91.5;
    translate([4.5,              9, -d]) cylinder(h=10, d=3.5); // Schraubenloch 1
    translate([4.5,              9, -d]) cylinder(h=3,  d=6); // Schraubenkopf 1
    translate([4.5+s_ScrewHoles, 9, -d]) cylinder(h=10, d=3.5); // SchraubenLoch 2
    translate([4.5+s_ScrewHoles, 9, -d]) cylinder(h=3,  d=6); // Schraubenkopf 2
    PlasticScrewsAll();
}
//InnenMasse();

module AussenMasse(){
    cube([b+2*d, t+2*d, h+d]);
}    


module Logo(){
    linear_extrude(3) {
        text("AUDIO", size= 14);
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
        translate([3, 0.5, 6.25]) rotate([90, 0, 0]) Logo();
        translate([55, 0, 13]) scale([0.7, 1, 0.7]) rotate([90, 0, 0]) NPN_Circuit();
        translate([117, 0, h/2+d]) rotate([90, 0, 0]) NPN_Transistor();
        translate([5, 15, 0.2]) rotate([180, 0, 0]) Beschriftung();
    }
}
//Gehaeuse();

module DeckelInnen(){
    t1=0.25;
    height=h-h_AC;
    difference(){
        union(){
            translate([t1, t1, h-height]) cube([b-2*t1, 3, height]); // Front
            translate([t1, t1, h-height]) cube([10, 62, height]); // Left Side
            translate([t1, t-3-t1, h-height]) cube([b-2*t1, 3, height]); // Back
            translate([35+6, t-10-t1, h-height]) cube([18, 10, height]); // Back Screw
            translate([b-b_AC-t1, 1, h-height]) cube([b_AC, t-2, height]); // Right Side
        }
        PlasticScrewsAll();
    }
}
//DeckelInnen();

module Deckel(){
    difference(){
        translate([0, 0, h+d]) cube([b+2*d, t+2*d, d]);
        translate([d, d, d]) translate([0, 67, h]) Airgaps(bottom=false);
    }
    translate([d, d, d]) DeckelInnen();
}
//Deckel();
