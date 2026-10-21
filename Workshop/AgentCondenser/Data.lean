/-!
# Condenser: data skeleton

The conversation is a list of items. Condensing replaces a contiguous run of items
with one `condensed` node that still holds them.
-/

namespace Condenser

inductive Role where
  | system
  | user
  | assistant
  | tool
  deriving DecidableEq, Repr

inductive Part where
  | text (body : String)
  | toolCall (callId : String) (name : String) (input : String)
  | toolResult (callId : String) (output : String)
  | media (mime : String) (ref : String)
  /-- An opaque window from a provider's own compaction endpoint. -/
  | native (provider : String) (blob : String)
  deriving DecidableEq, Repr

structure Message where
  role : Role
  parts : Array Part
  tokens : Nat
  deriving Repr

/-- A model call a condensation is waiting on. `messages` is sent as-is, so it
can be the unchanged conversation plus a prompt, which reuses the prompt cache. -/
structure SummaryRequest where
  messages : Array Message
  deriving Repr

inductive Shown where
  | ready (messages : Array Message)
  /-- Until it is answered, the node renders as its hidden items. -/
  | requested (request : SummaryRequest)
  deriving Repr

/-- `turn` is the smallest atomic unit: one user message, or one model response
together with the results of its tool calls. -/
inductive Item where
  | turn (messages : Array Message)
  | condensed (shown : Shown) (hidden : List Item)
  deriving Repr

structure Conversation where
  /-- Never condensed: system prompt, task specification. -/
  pinned : Array Message
  items : List Item
  deriving Repr

structure Budget where
  /-- Condense once the conversation exceeds this. -/
  trigger : Nat
  /-- Condense down to this. -/
  target : Nat
  target_lt_trigger : target < trigger

end Condenser
