# Transport Management

Business Central extension for transport planning and trip execution.

## Scope

- Transporter and truck master data
- Route trip headers and route trip lines
- Sales order route candidate API for planning
- Weighbridge and proof-of-delivery entries
- KPI and hub summary management codeunits
- API pages for TMS data integration

## Object Ranges

All project objects are assigned inside the range declared in `app.json`: `50600..50649`.

| Range | Objects |
| --- | --- |
| 50600..50602 | TMS enums |
| 50610..50615 | TMS tables |
| 50620..50627 | TMS API pages |
| 50630 | TMS route order query |
| 50640..50642 | TMS codeunits |
| 50649 | TMS permission set |

## Build

Download symbols in AL for the configured Business Central environment, then package the extension from VS Code.
