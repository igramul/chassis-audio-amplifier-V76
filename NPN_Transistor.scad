$fn=100;
height=1;

module Line(){
    cube([ 1, 10, height], center=true);
}

module C_E_Line(){
    cube([ 1, 7.5, height], center=true);
}

module EmitterLine(){
    union(){
        linear_extrude(height, center=true){
            polygon([[-1.5, 0],[1.5, 0],[0, -3]]);
        }
        C_E_Line();
    }
}

module RING(){
        difference(){
        cylinder(h=height, d=20, center=true);
        cylinder(h=height, d=18, center=true);
    }
}

module NPN_Circuit(){
    translate([-3,   0, 0]) Line(); // Substrat
    translate([-8,   0, 0]) rotate([0, 0, 90]) Line(); // B Anschluss
    translate([ 3,  10, 0]) Line(); // C Anschluss
    translate([ 3, -10, 0]) Line(); // E Anschluss
    translate([0, 3.55, 0]) rotate([0, 0, -60]) C_E_Line(); // C Line
    translate([0, -3.55, 0]) rotate([0, 0, 60]) EmitterLine(); // E Line
    
}

module NPN_Transistor(){
    RING();
    NPN_Circuit();
}

//NPN_Transistor();