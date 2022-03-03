#----------------------------------------------------------------------------
# setting variables 
#----------------------------------------------------------------------------
# setting constants
set TRUE 1
set FALSE 0
set ERROR -1

mol modstyle 0 0 CPK 0.600000 0.300000 10.000000 10.000000

#----------------------------------------------------------------------------
# opens a trajectory containing psf, pdb & dcd files
# @param "pdbName" the name of the 3 files (all should have the same name, different suffixes)
# @return the molecule handle for the trajectory
#----------------------------------------------------------------------------
#proc opendcd {name_psf name_dcd} {
proc opendcd {name_psf name_dcd} {
        set molecule [mol new $name_dcd]
        mol addfile $name_psf waitfor all
        set sel0 [atomselect top "all"]
        set sel1 [atomselect top "resname QM"]
        # Add the NewCartoon representation for the protein
        mol delrep 0 0
        mol addrep 0
        set updrep [mol repname 0 0]
        mol modstyle 0 0 NewCartoon
        mol modselect 0 0 all
        #mol modstyle 0 0 CPK 0.600000 0.300000 10.000000 10.000000
        mol addrep 0
        set updrep [mol repname 0 1]
        mol modstyle 1 0 Licorice
        mol modselect 1 0 resname QM
        return $molecule 
}
axes location Off
color Display Background white
display depthcue off
display projection Orthographic

puts "Enter the name of the DCD file to be opened"
gets stdin dcdfilnam

opendcd nneutr.psf $dcdfilnam
