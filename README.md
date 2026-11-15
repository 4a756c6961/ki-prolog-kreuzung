[README.md](https://github.com/user-attachments/files/34875416/README.md)
# Rule-Based Traffic Priority Decision System (Prolog)

An educational decision-support system for evaluating simplified right-of-way situations at a four-way intersection using **SWI-Prolog**.

This project was developed for an Artificial Intelligence coursework assignment. It demonstrates symbolic AI, knowledge representation, rules, logical inference, unification, backtracking, and negation as failure.

> **Disclaimer:** This is a simplified academic model, **not** a traffic-control or driving-safety application. A successful query is not legal permission to enter an intersection.

## Features

- Five predefined scenarios with twelve example queries
- A four-way intersection with at most one vehicle per approach
- Vehicle facts containing scenario, ID, direction, and maneuver
- Simplified priority-to-the-right and left-turn/oncoming-traffic rules
- Waiting obligations via `muss_warten/3` and decisions via `darf_fahren/2`

## Requirements

- [SWI-Prolog](https://www.swi-prolog.org/)

## Getting started

Clone the repository and launch SWI-Prolog:

```bash
git clone https://github.com/4a756c6961/ki-prolog-kreuzung.git
cd ki-prolog-kreuzung
swipl -s kreuzung.pl
```

Alternatively, load the file inside SWI-Prolog:

```prolog
?- [kreuzung].
```

Try these queries:

```prolog
?- darf_fahren(s1, a).
true.

?- darf_fahren(s1, b).
false.

?- muss_warten(s1, b, a).
true.
```

## How it works

The knowledge base describes vehicles as facts:

```prolog
% fahrzeug(Scenario, VehicleID, Approach, Maneuver).
fahrzeug(s1, a, nord, geradeaus).
```

Approaches are `nord`, `ost`, `sued`, and `west`; maneuvers are `geradeaus`, `links`, and `rechts`. The relation `rechts_von(RightApproach, OwnApproach)` describes which approach lies to the right of another; `gegenueber/2` represents opposite approaches.

The central decision rule is:

```prolog
darf_fahren(S, X) :-
    fahrzeug(S, X, _, _),
    \+ muss_warten(S, X, _).
```

The query succeeds if the vehicle is present in the scenario and no waiting obligation can be proven using the implemented rules. The operator `\+` denotes **negation as failure**; it does not establish that a maneuver is safe under real-world conditions.

## Scenarios and expected outputs

| Scenario | Description | Expected query results |
| --- | --- | --- |
| `s1` | Two vehicles; priority to the right | `a: true`, `b: false` |
| `s2` | Left turn and oncoming traffic | `a: false`, `c: true` |
| `s3` | Four vehicles approaching | `a: false`, `b: false`, `c: false`, `d: false` |
| `s4` | Single vehicle | `a: true` |
| `s5` | Three vehicles approaching | `a: true`, `b: false`, `c: false` |

The twelve example queries demonstrate behavior in the predefined scenarios. They do **not** prove correctness for arbitrary traffic situations.

## Scope and limitations

The prototype deliberately omits traffic signs, traffic lights, pedestrians, cyclists, vehicle speeds, acceleration, and dynamic movements. It does not perform geometric vehicle-path conflict detection and does not resolve the mutual waiting situation in scenario `s3`.

Its rules reflect selected principles of German road traffic law (especially §§ 8 and 9 StVO) only in a simplified form; the model is **not** a complete representation of the law.

## Possible extensions

- Explicit detection of crossing or overlapping vehicle paths
- Additional road users and traffic-control rules
- Dynamic traffic scenarios and explanations of decisions

## Project file

- `kreuzung.pl` — knowledge base, spatial relations, priority rules, and decision logic

## Author

Julia Jessing
