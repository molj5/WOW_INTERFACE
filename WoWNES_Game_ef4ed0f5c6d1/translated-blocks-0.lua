local _,G=...;local R=WoWNES_Runtime
G.blocks[0]=function(c) local a,x,y,s,p=c.a,c.x,c.y,c.s,c.p; a=1;p=R.nz(p,a); c.a,c.x,c.y,c.s,c.p=a,x,y,s,p;c.pc=(c.pc+2)%65536;return 2 end
G.blocks[2]=function(c) local a,x,y,s,p=c.a,c.x,c.y,c.s,c.p; x=a;p=R.nz(p,x); c.a,c.x,c.y,c.s,c.p=a,x,y,s,p;c.pc=(c.pc+1)%65536;return 2 end
G.blocks[3]=function(c) local a,x,y,s,p=c.a,c.x,c.y,c.s,c.p; x=(x+1)%256;p=R.nz(p,x); c.a,c.x,c.y,c.s,c.p=a,x,y,s,p;c.pc=(c.pc+1)%65536;return 2 end
