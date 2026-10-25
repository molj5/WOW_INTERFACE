# Debug contra F813 opcode

Status: [OPEN]

## Symptoms
- Runtime8Lua and game37Lua loaded successfully in the real client.
- ROM0b79e04375c0 registered.
- First run reached 142 frames without a runtime error but rendered a black screen.
- Repeated start failed with `Unsupported unofficial opcode FF at F813`, `running=false`.

## Falsifiable hypotheses
1. The PRG byte at CPU address F813 is actually FF, or bank mapping resolves the wrong PRG page.
2. Repeated load/start mutates or reuses PRG/bank/registration state and corrupts execution.
3. Runtime and game package versions or load order are inconsistent.
4. Missing TGA assets explain the black screen but are independent of the illegal opcode.
5. The real client startup path differs from the local mock path in initialization or reset behavior.

## Evidence log
- Pending schema inspection and runtime evidence.
