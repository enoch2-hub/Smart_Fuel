% ==========================================
% GLOBAL SYSTEM SETTINGS (The "Today" Facts)
% ==========================================
% Change these facts to test different scenarios (e.g., date 13 or holiday false)








% ==========================================
% SECTOR DATA (Fisheries Records)
% ==========================================
% vessel(VesselID, LastFuelingDate)








% ==========================================
% CORE LOGIC: VEHICLE ELIGIBILITY (Everyday Users)
% ==========================================
% Rule for Petrol






% Rule for Diesel (Always requires QR)
check_diesel(_) :-
    write('Safety Protocol: Diesel requires a valid QR Code verification. Please scan now.').







% ==========================================
% CORE LOGIC: FISHERIES ALLOCATION
% ==========================================












check_vessel(_) :- 
    write('Error: Vessel ID not found in the National Registry.').

% ==========================================
% INTERACTIVE USER INTERFACE
% ==========================================
% This starts the application










run_choice(1) :-
 write('Enter Plate Number (e.g. 4082.): '), read(Plate),
 write('Enter Fuel Type (petrol. or diesel.): '), read(Type),
 (Type == petrol -> check_petrol(Plate) ; check_diesel(Plate)), nl.
 
run_choice(2) :-
 write('Enter Vessel ID (e.g. v001.): '), read(ID),
 check_vessel(ID), nl.



% End---------
