# Agent Condenser Exercise

At its core, a coding agent is a chatbot that uses tools. At each turn, the chat-loop sends the LLM a condensed view of the conversation history.


## Exercise

We will implement a condenser in `./Impl.lean` matching this signature.

```lean
def condense (b: Budget) → (c: Conversation) → Conversation :=
  sorry
```

1. Choose a reference implementation.
2. Use your agent to checkout the code and investigate the condenser implementation.
  * You can use `./checkouts`
  * Shallow checkout is faster
3. Create `./Spec.md` 
4. `./Spec.lean`


## Reference 1: OpenHands

Source: `https://github.com/OpenHands/software-agent-sdk`

* `openhands-sdk/openhands/sdk/context/condenser/llm_summarizing_condenser.py`
* `openhands-sdk/openhands/sdk/context/condenser/base.py`
* `openhands-sdk/openhands/sdk/event/condenser.py`
* `openhands-sdk/openhands/sdk/context/view/view.py`
* `openhands-sdk/openhands/sdk/context/view/properties/`
* `openhands-sdk/openhands/sdk/context/view/manipulation_indices.py`
* `openhands-sdk/openhands/sdk/agent/utils.py` (prepare_llm_messages)
* `openhands-sdk/openhands/sdk/agent/agent.py` (step)
* `openhands-sdk/openhands/sdk/context/condenser/prompts/summarizing_system.j2`
* `openhands-sdk/openhands/sdk/tests/sdk/context/condenser/`
* `openhands-sdk/openhands/sdk/tests/integration/tests/` (c01–c05)

## Reference 2: OpenCode

Source: `https://github.com/anomalyco/opencode`

* `packages/core/src/session/compaction.ts`
* `packages/core/src/session/runner/llm.ts`
* `packages/core/src/session/runner/to-llm-message.ts`
* `packages/core/src/session/history.ts`
* `packages/ai/src/protocols/utils/responses-compaction.ts`
* `packages/anthropic-messages.ts`
* `packages/schema/src/config/compaction.ts`
* `packages/core/test/session-compaction*.test.ts`
* `packages/ai/test/provider/*compaction*.test.ts`

## Reference 2: StakPak

Source: `https://github.com/stakpak/agent`

* `libs/agent-core/src/budget_context.rs`
* `libs/agent-core/src/context.rs`
* `libs/agent-core/src/agent.rs`
* `libs/agent-core/src/compaction.rs`
* `libs/server/src/session_actor.rs`
* `libs/agent-core/budget_context_reducer.rs`
* `libs/agent-core/context_reducer_contract.rs`
