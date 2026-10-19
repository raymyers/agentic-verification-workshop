import Workshop.GildedRose.Impl

/-!
# Gilded Rose: specification

## Part 1: pin down the legacy behavior

Replace each `sorry` with a proof. Together these theorems turn the prose
requirements in `Impl.lean` into checked facts about the legacy code.

## Part 2: refactor

Write a cleaner `updateItem'`, for example one that matches on the item's
category, and prove that it behaves exactly like the original:

    theorem updateItem'_eq (item : Item) : updateItem' item = updateItem item

Once that is proved, every theorem in Part 1 also holds for `updateItem'`.

## Part 3: new feature

The kata's new requirement: "Conjured" items degrade in quality twice as fast
as normal items. Add this to your refactored version, then state and prove
what changes and what stays the same.
-/

namespace GildedRose

/-- An item with none of the special rules. -/
def IsNormal (item : Item) : Prop :=
  item.name ≠ agedBrie ∧ item.name ≠ backstagePasses ∧ item.name ≠ sulfuras

/-! ### Invariants -/

theorem quality_nonneg (item : Item) (h : 0 ≤ item.quality) :
    0 ≤ (updateItem item).quality := by
  sorry

theorem quality_le_fifty (item : Item) (hs : item.name ≠ sulfuras)
    (h : item.quality ≤ 50) :
    (updateItem item).quality ≤ 50 := by
  sorry

theorem sulfuras_unchanged (item : Item) (h : item.name = sulfuras) :
    updateItem item = item := by
  sorry

theorem name_unchanged (item : Item) : (updateItem item).name = item.name := by
  sorry

/-! ### Normal items -/

theorem normal_sellIn (item : Item) (h : IsNormal item) :
    (updateItem item).sellIn = item.sellIn - 1 := by
  sorry

theorem normal_before_sell_by (item : Item) (h : IsNormal item)
    (hs : 0 < item.sellIn) (hq : 0 < item.quality) :
    (updateItem item).quality = item.quality - 1 := by
  sorry

theorem normal_after_sell_by (item : Item) (h : IsNormal item)
    (hs : item.sellIn ≤ 0) (hq : 2 ≤ item.quality) :
    (updateItem item).quality = item.quality - 2 := by
  sorry

/-! ### Aged Brie -/

theorem brie_improves (item : Item) (h : item.name = agedBrie)
    (hq : item.quality < 50) :
    item.quality < (updateItem item).quality := by
  sorry

/-! ### Backstage passes -/

theorem backstage_far (item : Item) (h : item.name = backstagePasses)
    (hs : 10 < item.sellIn) (hq : item.quality < 50) :
    (updateItem item).quality = item.quality + 1 := by
  sorry

theorem backstage_ten_days (item : Item) (h : item.name = backstagePasses)
    (hs1 : 5 < item.sellIn) (hs2 : item.sellIn ≤ 10) (hq : item.quality ≤ 48) :
    (updateItem item).quality = item.quality + 2 := by
  sorry

theorem backstage_five_days (item : Item) (h : item.name = backstagePasses)
    (hs1 : 0 < item.sellIn) (hs2 : item.sellIn ≤ 5) (hq : item.quality ≤ 47) :
    (updateItem item).quality = item.quality + 3 := by
  sorry

theorem backstage_after_concert (item : Item) (h : item.name = backstagePasses)
    (hs : item.sellIn ≤ 0) :
    (updateItem item).quality = 0 := by
  sorry

end GildedRose
