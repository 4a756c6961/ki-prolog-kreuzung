
% ==========================================
% Entscheidungsunterstuetzung an Kreuzungen
% ==========================================

% 1. Wissensbasis
% fahrzeug(Szenario, ID, Position, Richtung).

% Szenario 1: Rechts vor links
fahrzeug(s1, a, nord, geradeaus).
fahrzeug(s1, b, ost, geradeaus).

% Szenario 2: Linksabbieger und Gegenverkehr
fahrzeug(s2, a, nord, links).
fahrzeug(s2, c, sued, geradeaus).

% Szenario 3: Vier Fahrzeuge
fahrzeug(s3, a, nord, geradeaus).
fahrzeug(s3, b, ost, geradeaus).
fahrzeug(s3, c, sued, geradeaus).
fahrzeug(s3, d, west, geradeaus).

% Szenario 4: Einzelnes Fahrzeug
fahrzeug(s4, a, nord, geradeaus).

% Szenario 5: Drei Fahrzeuge
fahrzeug(s5, a, nord, geradeaus).
fahrzeug(s5, b, ost, geradeaus).
fahrzeug(s5, c, sued, geradeaus).


% ==========================================
% 2. Raeumliche Beziehungen
% ==========================================

% Rechtsseitige Zufahrten
% rechts_von(RechteZufahrt, EigeneZufahrt).

rechts_von(west, nord).
rechts_von(nord, ost).
rechts_von(ost, sued).
rechts_von(sued, west).

% Gegenueberliegende Zufahrten
gegenueber(nord, sued).
gegenueber(sued, nord).
gegenueber(ost, west).
gegenueber(west, ost).


% ==========================================
% 3. Verkehrsregeln
% ==========================================

% Linksabbieger beachten Gegenverkehr
muss_gegenverkehr_beachten(S, X, Y) :-
    fahrzeug(S, X, PositionX, links),
    fahrzeug(S, Y, PositionY, RichtungY),
    X \= Y,
    gegenueber(PositionX, PositionY),
    member(RichtungY, [geradeaus, rechts]).

% Rechts vor links
muss_warten(S, X, Y) :-
    fahrzeug(S, X, PositionX, _),
    fahrzeug(S, Y, PositionY, _),
    X \= Y,
    rechts_von(PositionY, PositionX).

% Linksabbieger warten auf Gegenverkehr
muss_warten(S, X, Y) :-
    muss_gegenverkehr_beachten(S, X, Y).


% ==========================================
% 4. Entscheidungslogik
% ==========================================

% Ein Fahrzeug darf fahren, wenn keine
% modellierte Wartebedingung vorliegt.
darf_fahren(S, X) :-
    fahrzeug(S, X, _, _),
    \+ muss_warten(S, X, _).

