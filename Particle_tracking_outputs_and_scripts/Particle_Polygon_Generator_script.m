%Script to define polygons within particles are released and through which
%particles from other polygons must pass to be connected

% Define corners for each polygon
% Generate grid of particles within each polygon using corners and
% specified seperation.

% %Peros Banhos
% Coord_2=[71.6,72.05,-5.6,-5.1];         polygon_2_x=[Coord_2(1),Coord_2(2),Coord_2(2),Coord_2(1),Coord_2(1)]; polygon_2_y=[Coord_2(4),Coord_2(4),Coord_2(3),Coord_2(3),Coord_2(4)];
% %Salomon
% Coord_3=[72.15,72.6,-5.4,-5.15];   polygon_3_x=[Coord_3(1),Coord_3(2),Coord_3(2),Coord_3(1),Coord_3(1)]; polygon_3_y=[Coord_3(4),Coord_3(4),Coord_3(3),Coord_3(3),Coord_3(4)];
% %Egmont
% Coord_4=[71.25,71.5,-6.8,6.55];     polygon_4_x=[Coord_4(1),Coord_4(2),Coord_4(2),Coord_4(1),Coord_4(1)]; polygon_4_y=[Coord_4(4),Coord_4(4),Coord_4(3),Coord_4(3),Coord_4(4)];


%Define the west, east, south north extent and then the polygon with top left first and moving clockwise

%DG
Coord_1=[72.2,72.6,-7.6,-7];          polygon_1_x=[Coord_1(1),Coord_1(2),Coord_1(2),Coord_1(1),Coord_1(1)]; polygon_1_y=[Coord_1(4),Coord_1(4),Coord_1(3),Coord_1(3),Coord_1(4)];
int=0.05;   %Spacing between particles in both lat and lon
[particles1_x,particles1_y]=meshgrid(polygon_1_x(1):int:polygon_1_x(2),polygon_1_y(3):int:polygon_1_y(1));
particles_1_XYZ=[particles1_x(:),particles1_y(:),ones(size(particles1_x(:)))*(-0.2)];
clear int

%Northern Atolls, Salomon, PB
Coord_2=[71.4,72.5,-5.6,-5];         polygon_2_x=[Coord_2(1),Coord_2(2),Coord_2(2),Coord_2(1),Coord_2(1)]; polygon_2_y=[Coord_2(4),Coord_2(4),Coord_2(3),Coord_2(3),Coord_2(4)];
int=0.05;
[particles2_x,particles2_y]=meshgrid(polygon_2_x(1):int:polygon_2_x(2),polygon_2_y(3):int:polygon_2_y(1));
particles_2_XYZ=[particles2_x(:),particles2_y(:),ones(size(particles2_x(:)))*(-0.2)];
clear int

%Western Atolls
Coord_3=[71,71.6,-6.9,-6];   polygon_3_x=[Coord_3(1),Coord_3(2),Coord_3(2),Coord_3(1),Coord_3(1)]; polygon_3_y=[Coord_3(4),Coord_3(4),Coord_3(3),Coord_3(3),Coord_3(4)];
int=0.05;
[particles3_x,particles3_y]=meshgrid(polygon_3_x(1):int:polygon_3_x(2),polygon_3_y(3):int:polygon_3_y(1));
particles_3_XYZ=[particles3_x(:),particles3_y(:),ones(size(particles3_x(:)))*(-0.2)];
clear int

%Inner Seychelles
Coord_4=[55,56.25,-5,-4];     polygon_4_x=[Coord_4(1),Coord_4(2),Coord_4(2),Coord_4(1),Coord_4(1)]; polygon_4_y=[Coord_4(4),Coord_4(4),Coord_4(3),Coord_4(3),Coord_4(4)];
int=0.05;
[particles4_x,particles4_y]=meshgrid(polygon_4_x(1):int:polygon_4_x(2),polygon_4_y(3):int:polygon_4_y(1));
particles_4_XYZ=[particles4_x(:),particles4_y(:),ones(size(particles4_x(:)))*(-0.2)];
clear int

%Ile Glorieuse
Coord_5=[46.75,48,-11.8,-11];     polygon_5_x=[Coord_5(1),Coord_5(2),Coord_5(2),Coord_5(1),Coord_5(1)]; polygon_5_y=[Coord_5(4),Coord_5(4),Coord_5(3),Coord_5(3),Coord_5(4)];
int=0.05;
[particles5_x,particles5_y]=meshgrid(polygon_5_x(1):int:polygon_5_x(2),polygon_5_y(3):int:polygon_5_y(1));
particles_5_XYZ=[particles5_x(:),particles5_y(:),ones(size(particles5_x(:)))*(-0.2)];
clear int

%Outer Seychelles
Coord_6=[46,48,-10,-9];     polygon_6_x=[Coord_6(1),Coord_6(2),Coord_6(2),Coord_6(1),Coord_6(1)]; polygon_6_y=[Coord_6(4),Coord_6(4),Coord_6(3),Coord_6(3),Coord_6(4)];
int=0.05;
[particles6_x,particles6_y]=meshgrid(polygon_6_x(1):int:polygon_6_x(2),polygon_6_y(3):int:polygon_6_y(1));
particles_6_XYZ=[particles6_x(:),particles6_y(:),ones(size(particles6_x(:)))*(-0.2)];
clear int

%Concatenate particles into single variable and save to .csv

particles_combined=[particles_1_XYZ; particles_2_XYZ; particles_3_XYZ; particles_4_XYZ; particles_5_XYZ; particles_6_XYZ];
aa=floor(length(particles_combined(:,1))/8);
particles_combined_by8=particles_combined(1:aa*8,:);

%writematrix(particles_combined_by8,'Particles_Combined_Input.csv')

Distance_DG_to_Salomon=sw_dist([Coord_1(3),Coord_2(3)],[Coord_1(1),Coord_2(1)],'km')
Distance_DG_to_WesternAtolls=sw_dist([Coord_1(3),Coord_3(3)],[Coord_1(1),Coord_3(1)],'km')
Distance_DG_to_InnerSeychelles=sw_dist([Coord_1(3),Coord_4(3)],[Coord_1(1),Coord_4(1)],'km')
Distance_DG_to_IleGlorieuse=sw_dist([Coord_1(3),Coord_5(3)],[Coord_1(1),Coord_5(1)],'km')
Distance_DG_to_OuterSeychelles=sw_dist([Coord_1(3),Coord_6(3)],[Coord_1(1),Coord_6(1)],'km')

Distance_Salomon_to_WesternAtolls=sw_dist([Coord_2(3),Coord_3(3)],[Coord_2(1),Coord_3(1)],'km')
Distance_Salomon_to_InnerSeychelles=sw_dist([Coord_2(3),Coord_4(3)],[Coord_2(1),Coord_4(1)],'km')
Distance_Salomon_to_IleGlorieuse=sw_dist([Coord_2(3),Coord_5(3)],[Coord_2(1),Coord_5(1)],'km')
Distance_Salomon_to_OuterSeychelles=sw_dist([Coord_2(3),Coord_6(3)],[Coord_2(1),Coord_6(1)],'km')

Distance_WesternAtolls_to_InnerSeychelles=sw_dist([Coord_3(3),Coord_4(3)],[Coord_3(1),Coord_4(1)],'km')
Distance_WesternAtolls_to_IleGlorieuse=sw_dist([Coord_3(3),Coord_5(3)],[Coord_3(1),Coord_5(1)],'km')
Distance_WesternAtolls_to_OuterSeychelles=sw_dist([Coord_3(3),Coord_6(3)],[Coord_3(1),Coord_6(1)],'km')

Distance_InnerSeychelles_to_IleGlorieuse=sw_dist([Coord_4(3),Coord_5(3)],[Coord_4(1),Coord_5(1)],'km')
Distance_InnerSeychelles_to_OuterSeychelles=sw_dist([Coord_4(3),Coord_6(3)],[Coord_4(1),Coord_6(1)],'km')

Distance_IleGlorieuse_to_OuterSeychelles=sw_dist([Coord_5(3),Coord_6(3)],[Coord_5(1),Coord_6(1)],'km')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%To run AFTER particle tracking to compute connectivity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Compute distances traveled by each particle throughout entire simulation
for n=1:length(TRAJ.TimeStamp)-1
    for m=1:length(TRAJ.Lon(:,1))
        dd(m,n)=sw_dist([TRAJ.Lat(m,n+1), TRAJ.Lat(m,n)],[TRAJ.Lon(m,n+1), TRAJ.Lon(m,n)],'km');
    end
end

clear n m

for m=1:length(TRAJ.Lon(:,1))
    distance(m,:)=[0 dd(m,:)];
    cum_distance(m,:)=cumsum(distance(m,:));    %Cunmulative distance travelled by each particle
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%For connectivity, we need to know which articles from the combined particle release file were released from each
%region

region1_particles=[1:length(particles_1_XYZ(:,1))];
region2_particles=[region1_particles(end)+1:region1_particles(end)+length(particles_2_XYZ(:,1))];
region3_particles=[region2_particles(end)+1:region2_particles(end)+length(particles_3_XYZ(:,1))];
region4_particles=[region3_particles(end)+1:region3_particles(end)+length(particles_4_XYZ(:,1))];
region5_particles=[region4_particles(end)+1:region4_particles(end)+length(particles_5_XYZ(:,1))];
%region6_particles=[region5_particles(end)+1:region5_particles(end)+length(particles_6_XYZ(:,1))];
region6_particles=[region5_particles(end)+1:length(particles_combined_by8(:,1))];


%%%%%%%%%%%%%

regions=[1:1:6]
for n=1:6

    eval(['region' num2str(n) '_xq=TRAJ.Lon(region' num2str(n) '_particles(1):region' num2str(n) '_particles(end),:); region' num2str(n) '_yq=TRAJ.Lat(region' num2str(n) '_particles(1):region' num2str(n) '_particles(end),:);'])
    eval(['region' num2str(n) '_final_xq=TRAJ.Lon(region' num2str(n) '_particles(1):region' num2str(n) '_particles(end),end); region' num2str(n) '_final_yq=TRAJ.Lat(region' num2str(n) '_particles(1):region' num2str(n) '_particles(end),end);'])

    %Consider the final particle positions
    eval(['[region' num2str(n) '_in_region' num2str(regions(1)) '_final,region' num2str(n) '_on_region' num2str(regions(1)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(1)) '_x,polygon_' num2str(regions(1)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(2)) '_final,region' num2str(n) '_on_region' num2str(regions(2)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(2)) '_x,polygon_' num2str(regions(2)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(3)) '_final,region' num2str(n) '_on_region' num2str(regions(3)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(3)) '_x,polygon_' num2str(regions(3)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(4)) '_final,region' num2str(n) '_on_region' num2str(regions(4)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(4)) '_x,polygon_' num2str(regions(4)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(5)) '_final,region' num2str(n) '_on_region' num2str(regions(5)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(5)) '_x,polygon_' num2str(regions(5)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(6)) '_final,region' num2str(n) '_on_region' num2str(regions(6)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(6)) '_x,polygon_' num2str(regions(6)) '_y);']) 
    %Now any positions
    eval(['[region' num2str(n) '_in_region' num2str(regions(1)) ',region' num2str(n) '_on_region' num2str(regions(1)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(1)) '_x,polygon_' num2str(regions(1)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(2)) ',region' num2str(n) '_on_region' num2str(regions(2)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(2)) '_x,polygon_' num2str(regions(2)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(3)) ',region' num2str(n) '_on_region' num2str(regions(3)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(3)) '_x,polygon_' num2str(regions(3)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(4)) ',region' num2str(n) '_on_region' num2str(regions(4)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(4)) '_x,polygon_' num2str(regions(4)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(5)) ',region' num2str(n) '_on_region' num2str(regions(5)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(5)) '_x,polygon_' num2str(regions(5)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(6)) ',region' num2str(n) '_on_region' num2str(regions(6)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(6)) '_x,polygon_' num2str(regions(6)) '_y);']) 

end
    
%_________________________________________________________________________________________________________________________________________________
%Try to disregard the particles that don't leave the area because these
%aren't realistic
region1_nogo=find(region1_in_region1_final>0);
region2_nogo=find(region2_in_region2_final>0)+region2_particles(1)-1;
region3_nogo=find(region3_in_region3_final>0)+region3_particles(1)-1;
region4_nogo=find(region4_in_region4_final>0)+region4_particles(1)-1;
region5_nogo=find(region5_in_region5_final>0)+region5_particles(1)-1;
region6_nogo=find(region6_in_region6_final>0)+region6_particles(1)-1;

%NaN out the positions of the particles that don't go anywhere
TRAJ.Lon(region1_nogo,:)=NaN; TRAJ.Lat(region1_nogo,:)=NaN;
TRAJ.Lon(region2_nogo,:)=NaN; TRAJ.Lat(region2_nogo,:)=NaN;
TRAJ.Lon(region3_nogo,:)=NaN; TRAJ.Lat(region3_nogo,:)=NaN;
TRAJ.Lon(region4_nogo,:)=NaN; TRAJ.Lat(region4_nogo,:)=NaN;
TRAJ.Lon(region5_nogo,:)=NaN; TRAJ.Lat(region5_nogo,:)=NaN;
TRAJ.Lon(region6_nogo,:)=NaN; TRAJ.Lat(region6_nogo,:)=NaN;

%NOW RERUN WITHOUT THE NO-GO PARTICLES
for n=1:6
    eval(['region' num2str(n) '_xq=TRAJ.Lon(region' num2str(n) '_particles(1):region' num2str(n) '_particles(end),:); region' num2str(n) '_yq=TRAJ.Lat(region' num2str(n) '_particles(1):region' num2str(n) '_particles(end),:);'])
    eval(['region' num2str(n) '_final_xq=TRAJ.Lon(region' num2str(n) '_particles(1):region' num2str(n) '_particles(end),end); region' num2str(n) '_final_yq=TRAJ.Lat(region' num2str(n) '_particles(1):region' num2str(n) '_particles(end),end);'])

    eval(['[region' num2str(n) '_in_region' num2str(regions(1)) '_final,region' num2str(n) '_on_region' num2str(regions(1)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(1)) '_x,polygon_' num2str(regions(1)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(2)) '_final,region' num2str(n) '_on_region' num2str(regions(2)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(2)) '_x,polygon_' num2str(regions(2)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(3)) '_final,region' num2str(n) '_on_region' num2str(regions(3)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(3)) '_x,polygon_' num2str(regions(3)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(4)) '_final,region' num2str(n) '_on_region' num2str(regions(4)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(4)) '_x,polygon_' num2str(regions(4)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(5)) '_final,region' num2str(n) '_on_region' num2str(regions(5)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(5)) '_x,polygon_' num2str(regions(5)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(6)) '_final,region' num2str(n) '_on_region' num2str(regions(6)) '_final] = inpolygon(region' num2str(n) '_final_xq,region' num2str(n) '_final_yq,polygon_' num2str(regions(6)) '_x,polygon_' num2str(regions(6)) '_y);']) 

    %Now any positions
    eval(['[region' num2str(n) '_in_region' num2str(regions(1)) ',region' num2str(n) '_on_region' num2str(regions(1)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(1)) '_x,polygon_' num2str(regions(1)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(2)) ',region' num2str(n) '_on_region' num2str(regions(2)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(2)) '_x,polygon_' num2str(regions(2)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(3)) ',region' num2str(n) '_on_region' num2str(regions(3)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(3)) '_x,polygon_' num2str(regions(3)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(4)) ',region' num2str(n) '_on_region' num2str(regions(4)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(4)) '_x,polygon_' num2str(regions(4)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(5)) ',region' num2str(n) '_on_region' num2str(regions(5)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(5)) '_x,polygon_' num2str(regions(5)) '_y);']) 
    eval(['[region' num2str(n) '_in_region' num2str(regions(6)) ',region' num2str(n) '_on_region' num2str(regions(6)) '] = inpolygon(region' num2str(n) '_xq,region' num2str(n) '_yq,polygon_' num2str(regions(6)) '_x,polygon_' num2str(regions(6)) '_y);']) 

end

%_________________________________________________________________________________________________________________________________________________

%Connectivity matrix based on how many particles passed the other locations
%at ANY time

%Find the number of particles that pass within the rectangle of each site

%Region 1
for n=1:length(region1_particles)
    if isempty(find(region1_in_region1(n,:)==1))
    region1_passing_region1(n)=0;
    else
    region1_passing_region1(n)=1;
    end
    if isempty(find(region1_in_region2(n,:)==1))
    region1_passing_region2(n)=0;
    else
    region1_passing_region2(n)=1;
    end
        if isempty(find(region1_in_region3(n,:)==1))
        region1_passing_region3(n)=0;
        else
        region1_passing_region3(n)=1;
        end
            if isempty(find(region1_in_region4(n,:)==1))
            region1_passing_region4(n)=0;
            else
            region1_passing_region4(n)=1;
            end
                if isempty(find(region1_in_region5(n,:)==1))
                region1_passing_region5(n)=0;
                else
                region1_passing_region5(n)=1;
                end
                    if isempty(find(region1_in_region6(n,:)==1))
                    region1_passing_region6(n)=0;
                    else
                    region1_passing_region6(n)=1;
                    end
end

%region1_connecting_region* is the percentage of particles that passes
%through the polygon defining the area of another region
region1_connecting_region1=NaN;
region1_connecting_region2=length(find(region1_passing_region2)==1)./length(region1_particles)*100;
region1_connecting_region3=length(find(region1_passing_region3)==1)./length(region1_particles)*100;
region1_connecting_region4=length(find(region1_passing_region4)==1)./length(region1_particles)*100;
region1_connecting_region5=length(find(region1_passing_region5)==1)./length(region1_particles)*100;
region1_connecting_region6=length(find(region1_passing_region6)==1)./length(region1_particles)*100;


%____________________________________________

%Region 2

for n=1:length(region2_particles)
    if isempty(find(region2_in_region1(n,:)==1))
    region2_passing_region1(n)=0;
    else
    region2_passing_region1(n)=1;
    end
    
    if isempty(find(region2_in_region2(n,:)==1))
    region2_passing_region2(n)=0;
    else
    region2_passing_region2(n)=1;
    end
        if isempty(find(region2_in_region3(n,:)==1))
        region2_passing_region3(n)=0;
        else
        region2_passing_region3(n)=1;
        end
            if isempty(find(region2_in_region4(n,:)==1))
            region2_passing_region4(n)=0;
            else
            region2_passing_region4(n)=1;
            end
                if isempty(find(region2_in_region5(n,:)==1))
                region2_passing_region5(n)=0;
                else
                region2_passing_region5(n)=1;
                end
                    if isempty(find(region2_in_region6(n,:)==1))
                    region2_passing_region6(n)=0;
                    else
                    region2_passing_region6(n)=1;
                    end
end

region2_connecting_region1=length(find(region2_passing_region1)==1)./length(region2_particles)*100;
region2_connecting_region2=NaN;
region2_connecting_region3=length(find(region2_passing_region3)==1)./length(region2_particles)*100;
region2_connecting_region4=length(find(region2_passing_region4)==1)./length(region2_particles)*100;
region2_connecting_region5=length(find(region2_passing_region5)==1)./length(region2_particles)*100;
region2_connecting_region6=length(find(region2_passing_region6)==1)./length(region2_particles)*100;


%____________________________________________

%Region 3

for n=1:length(region3_particles)
    if isempty(find(region3_in_region1(n,:)==1))
    region3_passing_region1(n)=0;
    else
    region3_passing_region1(n)=1;
    end
    
    if isempty(find(region3_in_region2(n,:)==1))
    region3_passing_region2(n)=0;
    else
    region3_passing_region2(n)=1;
    end
        if isempty(find(region3_in_region3(n,:)==1))
        region3_passing_region3(n)=0;
        else
        region3_passing_region3(n)=1;
        end
            if isempty(find(region3_in_region4(n,:)==1))
            region3_passing_region4(n)=0;
            else
            region3_passing_region4(n)=1;
            end
                if isempty(find(region3_in_region5(n,:)==1))
                region3_passing_region5(n)=0;
                else
                region3_passing_region5(n)=1;
                end
                    if isempty(find(region3_in_region6(n,:)==1))
                    region3_passing_region6(n)=0;
                    else
                    region3_passing_region6(n)=1;
                    end
end

region3_connecting_region1=length(find(region3_passing_region1)==1)./length(region3_particles)*100;
region3_connecting_region2=length(find(region3_passing_region2)==1)./length(region3_particles)*100;
region3_connecting_region3=NaN;
region3_connecting_region4=length(find(region3_passing_region4)==1)./length(region3_particles)*100;
region3_connecting_region5=length(find(region3_passing_region5)==1)./length(region3_particles)*100;
region3_connecting_region6=length(find(region3_passing_region6)==1)./length(region3_particles)*100;


%____________________________________________

%Region 4

for n=1:length(region4_particles)
    if isempty(find(region4_in_region1(n,:)==1))
    region4_passing_region1(n)=0;
    else
    region4_passing_region1(n)=1;
    end
    
    if isempty(find(region4_in_region2(n,:)==1))
    region4_passing_region2(n)=0;
    else
    region4_passing_region2(n)=1;
    end
        if isempty(find(region4_in_region3(n,:)==1))
        region4_passing_region3(n)=0;
        else
        region4_passing_region3(n)=1;
        end
            if isempty(find(region4_in_region4(n,:)==1))
            region4_passing_region4(n)=0;
            else
            region4_passing_region4(n)=1;
            end
                if isempty(find(region4_in_region5(n,:)==1))
                region4_passing_region5(n)=0;
                else
                region4_passing_region5(n)=1;
                end
                    if isempty(find(region4_in_region6(n,:)==1))
                    region4_passing_region6(n)=0;
                    else
                    region4_passing_region6(n)=1;
                    end
end

region4_connecting_region1=length(find(region4_passing_region1)==1)./length(region4_particles)*100;
region4_connecting_region2=length(find(region4_passing_region2)==1)./length(region4_particles)*100;
region4_connecting_region3=length(find(region4_passing_region3)==1)./length(region4_particles)*100;
region4_connecting_region4=NaN;
region4_connecting_region5=length(find(region4_passing_region5)==1)./length(region4_particles)*100;
region4_connecting_region6=length(find(region4_passing_region6)==1)./length(region4_particles)*100;

%____________________________________________

%Region 5

for n=1:length(region5_particles)
    if isempty(find(region5_in_region1(n,:)==1))
    region5_passing_region1(n)=0;
    else
    region5_passing_region1(n)=1;
    end
    
    if isempty(find(region5_in_region2(n,:)==1))
    region5_passing_region2(n)=0;
    else
    region5_passing_region2(n)=1;
    end
        if isempty(find(region5_in_region3(n,:)==1))
        region5_passing_region3(n)=0;
        else
        region5_passing_region3(n)=1;
        end
            if isempty(find(region5_in_region4(n,:)==1))
            region5_passing_region4(n)=0;
            else
            region5_passing_region4(n)=1;
            end
                if isempty(find(region5_in_region5(n,:)==1))
                region5_passing_region5(n)=0;
                else
                region5_passing_region5(n)=1;
                end
                    if isempty(find(region5_in_region6(n,:)==1))
                    region5_passing_region6(n)=0;
                    else
                    region5_passing_region6(n)=1;
                    end
end

region5_connecting_region1=length(find(region5_passing_region1)==1)./length(region5_particles)*100;
region5_connecting_region2=length(find(region5_passing_region2)==1)./length(region5_particles)*100;
region5_connecting_region3=length(find(region5_passing_region3)==1)./length(region5_particles)*100;
region5_connecting_region4=length(find(region5_passing_region4)==1)./length(region5_particles)*100;
region5_connecting_region5=NaN;
region5_connecting_region6=length(find(region5_passing_region6)==1)./length(region5_particles)*100;

%____________________________________________

%Region 6

for n=1:length(region6_particles)
    if isempty(find(region6_in_region1(n,:)==1))
    region6_passing_region1(n)=0;
    else
    region6_passing_region1(n)=1;
    end
    
    if isempty(find(region6_in_region2(n,:)==1))
    region6_passing_region2(n)=0;
    else
    region6_passing_region2(n)=1;
    end
        if isempty(find(region6_in_region3(n,:)==1))
        region6_passing_region3(n)=0;
        else
        region6_passing_region3(n)=1;
        end
            if isempty(find(region6_in_region4(n,:)==1))
            region6_passing_region4(n)=0;
            else
            region6_passing_region4(n)=1;
            end
                if isempty(find(region6_in_region5_final(n,:)==1))
                region6_passing_region5(n)=0;
                else
                region6_passing_region5(n)=1;
                end
                    if isempty(find(region6_in_region6(n,:)==1))
                    region6_passing_region6(n)=0;
                    else
                    region6_passing_region6(n)=1;
                    end
end

region6_connecting_region1=length(find(region6_passing_region1)==1)./length(region6_particles)*100;
region6_connecting_region2=length(find(region6_passing_region2)==1)./length(region6_particles)*100;
region6_connecting_region3=length(find(region6_passing_region3)==1)./length(region6_particles)*100;
region6_connecting_region4=length(find(region6_passing_region4)==1)./length(region6_particles)*100;
region6_connecting_region5=length(find(region6_passing_region5)==1)./length(region6_particles)*100;
region6_connecting_region6=NaN;

%__________________________________________________________________________

%Compute cumulative distances travelled by particles when they reach another region 
clear n m

%Region 1, 117 particles
for n=1:6
    eval(['connected1_with_' num2str(n) '=find(region1_passing_region' num2str(n) '==1);'])
end
clear n

%Region 2, 299 particles
for n=1:6
    eval(['connected2_with_' num2str(n) '=find(region2_passing_region' num2str(n) '==1);'])
end
clear n

%Region 3, 247 particles
for n=1:6
    eval(['connected3_with_' num2str(n) '=find(region3_passing_region' num2str(n) '==1);'])
end
clear n

%Region 4, 546 particles
for n=1:6
    eval(['connected4_with_' num2str(n) '=find(region4_passing_region' num2str(n) '==1);'])
end
clear n

%Region 5, 442 particles
for n=1:6
    eval(['connected5_with_' num2str(n) '=find(region5_passing_region' num2str(n) '==1);'])
end
clear n

%Region 6, 861 particles
for n=1:6
    eval(['connected6_with_' num2str(n) '=find(region6_passing_region' num2str(n) '==1);'])
end
clear n
% for n=1:6
% %eval(['if isempty(connected1_with_' num2str(n) ')==0'])
%     eval(['for m=1:length(connected1_with_' num2str(n) ')'])
%         eval(['firstcontact1_with_' num2str(n) '(m)=min(find(region1_in_region2(connected1_with_' num2str(n) '(m),:)==1));'])
% end
% end
    
%%%%%%%%%%
CatHead_Region1_distances
CatHead_Region2_distances
CatHead_Region3_distances
CatHead_Region4_distances
CatHead_Region5_distances
CatHead_Region6_distances
%Generates series of variables called, e.g. dist_1_6 that are the actual
%distances travelled by particles that pass thorugh a different region; the
%distance is how far the particle travelled until it first reached that
%other region. Each variable contains the distances covered by the
%particles that reached tbhat destination so will be differnet sizes. We'll
%take the mean of all particles for a given run and region to distill into
%one value.

DistanceMatrix=ones(6,6);

DistanceMatrix(1,1)=mean(dist_1_1); DistanceMatrix(1,2)=mean(dist_1_2); DistanceMatrix(1,3)=mean(dist_1_3); DistanceMatrix(1,4)=mean(dist_1_4); DistanceMatrix(1,5)=mean(dist_1_5); DistanceMatrix(1,6)=mean(dist_1_6);
DistanceMatrix(2,1)=mean(dist_2_1); DistanceMatrix(2,2)=mean(dist_2_2); DistanceMatrix(2,3)=mean(dist_2_3); DistanceMatrix(2,4)=mean(dist_2_4); DistanceMatrix(2,5)=mean(dist_2_5); DistanceMatrix(2,6)=mean(dist_2_6);
DistanceMatrix(3,1)=mean(dist_3_1); DistanceMatrix(3,2)=mean(dist_3_2); DistanceMatrix(3,3)=mean(dist_3_3); DistanceMatrix(3,4)=mean(dist_3_4); DistanceMatrix(3,5)=mean(dist_3_5); DistanceMatrix(3,6)=mean(dist_3_6);
DistanceMatrix(4,1)=mean(dist_4_1); DistanceMatrix(4,2)=mean(dist_4_2); DistanceMatrix(4,3)=mean(dist_4_3); DistanceMatrix(4,4)=mean(dist_4_4); DistanceMatrix(4,5)=mean(dist_4_5); DistanceMatrix(4,6)=mean(dist_4_6);
DistanceMatrix(5,1)=mean(dist_5_1); DistanceMatrix(5,2)=mean(dist_5_2); DistanceMatrix(5,3)=mean(dist_5_3); DistanceMatrix(5,4)=mean(dist_5_4); DistanceMatrix(5,5)=mean(dist_5_5); DistanceMatrix(5,6)=mean(dist_5_6);
DistanceMatrix(6,1)=mean(dist_6_1); DistanceMatrix(6,2)=mean(dist_6_2); DistanceMatrix(6,3)=mean(dist_6_3); DistanceMatrix(6,4)=mean(dist_6_4); DistanceMatrix(6,5)=mean(dist_6_5); DistanceMatrix(6,6)=mean(dist_6_6);

DistanceMatrix_StraightLine=ones(6,6);

DistanceMatrix_StraightLine=[0,Distance_DG_to_Salomon,Distance_DG_to_WesternAtolls,Distance_DG_to_InnerSeychelles,Distance_DG_to_IleGlorieuse,Distance_DG_to_OuterSeychelles;...
    Distance_DG_to_Salomon,0,Distance_Salomon_to_WesternAtolls,Distance_Salomon_to_InnerSeychelles,Distance_Salomon_to_IleGlorieuse,Distance_Salomon_to_OuterSeychelles;...
    Distance_DG_to_WesternAtolls,Distance_Salomon_to_WesternAtolls,0,Distance_WesternAtolls_to_InnerSeychelles,Distance_WesternAtolls_to_IleGlorieuse,Distance_WesternAtolls_to_OuterSeychelles;...
    Distance_DG_to_InnerSeychelles,Distance_Salomon_to_InnerSeychelles,Distance_WesternAtolls_to_InnerSeychelles,0,Distance_InnerSeychelles_to_IleGlorieuse,Distance_InnerSeychelles_to_OuterSeychelles;...
    Distance_DG_to_IleGlorieuse,Distance_Salomon_to_IleGlorieuse,Distance_WesternAtolls_to_IleGlorieuse,Distance_InnerSeychelles_to_IleGlorieuse,0,Distance_IleGlorieuse_to_OuterSeychelles;...
    Distance_DG_to_OuterSeychelles,Distance_Salomon_to_OuterSeychelles,Distance_WesternAtolls_to_OuterSeychelles,Distance_InnerSeychelles_to_OuterSeychelles,Distance_IleGlorieuse_to_OuterSeychelles,0];

DistanceRatio=(DistanceMatrix./DistanceMatrix_StraightLine)';   %Outputs the ratio of distance travelled to strightline, so above 1 means longer than straight line (always the case)
%When printed, the first column shows the ratiofor particles leaving DG and
%arriving at other locations, with Outer Seychelles at the bottom of the
%column

ArrivalLocation={'DG';'Salomon';'Western Atolls';'Inner Seychelles';'Ile Glorieuse';'Outer Seychelles'}
DistanceMatrix_TABLE=table(ArrivalLocation,DistanceRatio(:,1),DistanceRatio(:,2),DistanceRatio(:,3),DistanceRatio(:,4),DistanceRatio(:,5),DistanceRatio(:,6))

releasetime=TRAJ.TimeStamp(1);
releasedate=datetime(releasetime,'ConvertFrom','datenum','Format','MMM_d_yyyy');
name_dist=strcat('DistanceMatrix_', datestr(releasedate));
writetable(DistanceMatrix_TABLE,[name_dist '.csv'])
%__________________________________________________________________________
%Connectivity matrix based on any particles passing another site
releasetime=TRAJ.TimeStamp(1);
releasedate=datetime(releasetime,'ConvertFrom','datenum','Format','MMM_d_yyyy');

ConnectivityMatrix_PASSING=ones(6,6);

ConnectivityMatrix_PASSING(1,1)=region1_connecting_region1;
ConnectivityMatrix_PASSING(1,2)=region1_connecting_region2;
ConnectivityMatrix_PASSING(1,3)=region1_connecting_region3;
ConnectivityMatrix_PASSING(1,4)=region1_connecting_region4;
ConnectivityMatrix_PASSING(1,5)=region1_connecting_region5;
ConnectivityMatrix_PASSING(1,6)=region1_connecting_region6;

ConnectivityMatrix_PASSING(2,1)=region2_connecting_region1;
ConnectivityMatrix_PASSING(2,2)=region2_connecting_region2;
ConnectivityMatrix_PASSING(2,3)=region2_connecting_region3;
ConnectivityMatrix_PASSING(2,4)=region2_connecting_region4;
ConnectivityMatrix_PASSING(2,5)=region2_connecting_region5;
ConnectivityMatrix_PASSING(2,6)=region2_connecting_region6;

ConnectivityMatrix_PASSING(3,1)=region3_connecting_region1;
ConnectivityMatrix_PASSING(3,2)=region3_connecting_region2;
ConnectivityMatrix_PASSING(3,3)=region3_connecting_region3;
ConnectivityMatrix_PASSING(3,4)=region3_connecting_region4;
ConnectivityMatrix_PASSING(3,5)=region3_connecting_region5;
ConnectivityMatrix_PASSING(3,6)=region3_connecting_region6;

ConnectivityMatrix_PASSING(4,1)=region4_connecting_region1;
ConnectivityMatrix_PASSING(4,2)=region4_connecting_region2;
ConnectivityMatrix_PASSING(4,3)=region4_connecting_region3;
ConnectivityMatrix_PASSING(4,4)=region4_connecting_region4;
ConnectivityMatrix_PASSING(4,5)=region4_connecting_region5;
ConnectivityMatrix_PASSING(4,6)=region4_connecting_region6;

ConnectivityMatrix_PASSING(5,1)=region5_connecting_region1;
ConnectivityMatrix_PASSING(5,2)=region5_connecting_region2;
ConnectivityMatrix_PASSING(5,3)=region5_connecting_region3;
ConnectivityMatrix_PASSING(5,4)=region5_connecting_region4;
ConnectivityMatrix_PASSING(5,5)=region5_connecting_region5;
ConnectivityMatrix_PASSING(5,6)=region5_connecting_region6;

ConnectivityMatrix_PASSING(6,1)=region6_connecting_region1;
ConnectivityMatrix_PASSING(6,2)=region6_connecting_region2;
ConnectivityMatrix_PASSING(6,3)=region6_connecting_region3;
ConnectivityMatrix_PASSING(6,4)=region6_connecting_region4;
ConnectivityMatrix_PASSING(6,5)=region6_connecting_region5;
ConnectivityMatrix_PASSING(6,6)=region6_connecting_region6;

ArrivalLocation={'Region1';'Region2';'Region3';'Region4';'Region5';'Region6'};

Region1_Release=[region1_connecting_region1;region1_connecting_region2;region1_connecting_region3;region1_connecting_region4;region1_connecting_region5;region1_connecting_region6];
Region2_Release=[region2_connecting_region1;region2_connecting_region2;region2_connecting_region3;region2_connecting_region4;region2_connecting_region5;region2_connecting_region6];
Region3_Release=[region3_connecting_region1;region3_connecting_region2;region3_connecting_region3;region3_connecting_region4;region3_connecting_region5;region3_connecting_region6];
Region4_Release=[region4_connecting_region1;region4_connecting_region2;region4_connecting_region3;region4_connecting_region4;region4_connecting_region5;region4_connecting_region6];
Region5_Release=[region5_connecting_region1;region5_connecting_region2;region5_connecting_region3;region5_connecting_region4;region5_connecting_region5;region5_connecting_region6];
Region6_Release=[region6_connecting_region1;region6_connecting_region2;region6_connecting_region3;region6_connecting_region4;region6_connecting_region5;region6_connecting_region6];

ConnectivityMatrix_PASSING_TABLE=table(ArrivalLocation,Region1_Release,Region2_Release,Region3_Release,Region4_Release,Region5_Release,Region6_Release)

name=strcat('ConnectivityMatrix_PASSING_', datestr(releasedate));
writetable(ConnectivityMatrix_PASSING_TABLE,[name '.csv'])
