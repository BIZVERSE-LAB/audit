# BIVE Contract


## Auditing Log

#### 12 Dec, 2021: Certik Report
| ID    |Title                          |Category|Severity               | Status|
|-------|-------------------------------|-|-----------------------------| ------|
|BBC-01 |Function Visibility Optimization |Gas Optimization|Informational   | Pending
|BBK-01 |Redundant Code Components |Volatile Code|Informational           | Pending
|**BWE-01** |Centralization Risk in BizverseWorldERC20.sol|Centralization / Privilege|**Major**| Pending
|BWE-02 |Missing Emit Events|Coding Style|Informational| Pending
|BWE-03 |Function Visibility Optimization|Gas Optimization|Informational| Pending

#### 12 Dec, 2021: Bizverse Fix Contract follow Certik Report
- Completed: BBC-01, BBK-01, BWE-02, BWE-03
- Pending: BWE-01
 - This issues is not a problem with our project because our roadmap already has a plane to improve this. In the first phrase, my contract has role _owner has the authority many special functions.  In this, owner is an address of wallet, as you reported Centralization Risk. But in the next phrase we will change owner to address of a DAO/governance/voting contract to increase transparency and user involvement.