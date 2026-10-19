/-!
# Gilded Rose: legacy implementation

This is a faithful port of the original Gilded Rose refactoring kata
(https://github.com/emilybache/GildedRose-Refactoring-Kata). The tangled
nested `if`s are deliberate. Don't clean them up yet: they are what the
exercises refactor.

Requirements, paraphrased from the kata:
* Every item has a `sellIn` (days left to sell it) and a `quality`.
* At the end of each day, the system lowers both values for every item.
* Once the sell-by date has passed, quality degrades twice as fast.
* Quality is never negative.
* "Aged Brie" gains quality as it gets older.
* Quality is never more than 50.
* "Sulfuras", a legendary item, never has to be sold and never loses
  quality. Its quality is 80 and never changes.
* "Backstage passes" gain quality as the concert approaches: +2 when there
  are 10 days or fewer left, and +3 when there are 5 days or fewer. Quality
  drops to 0 after the concert.
-/

namespace GildedRose

structure Item where
  name : String
  sellIn : Int
  quality : Int
  deriving Repr, DecidableEq

def agedBrie := "Aged Brie"
def backstagePasses := "Backstage passes to a TAFKAL80ETC concert"
def sulfuras := "Sulfuras, Hand of Ragnaros"

/-- Advance one item by one day. -/
def updateItem (item : Item) : Item := Id.run do
  let mut sellIn := item.sellIn
  let mut quality := item.quality
  if item.name ≠ agedBrie && item.name ≠ backstagePasses then
    if quality > 0 then
      if item.name ≠ sulfuras then
        quality := quality - 1
  else
    if quality < 50 then
      quality := quality + 1
      if item.name = backstagePasses then
        if sellIn < 11 then
          if quality < 50 then
            quality := quality + 1
        if sellIn < 6 then
          if quality < 50 then
            quality := quality + 1
  if item.name ≠ sulfuras then
    sellIn := sellIn - 1
  if sellIn < 0 then
    if item.name ≠ agedBrie then
      if item.name ≠ backstagePasses then
        if quality > 0 then
          if item.name ≠ sulfuras then
            quality := quality - 1
      else
        quality := quality - quality
    else
      if quality < 50 then
        quality := quality + 1
  return { item with sellIn, quality }

/-- Advance the whole inventory by one day. -/
def updateQuality (items : List Item) : List Item :=
  items.map updateItem

def sampleInventory : List Item := [
  { name := "+5 Dexterity Vest", sellIn := 10, quality := 20 },
  { name := agedBrie, sellIn := 2, quality := 0 },
  { name := "Elixir of the Mongoose", sellIn := 5, quality := 7 },
  { name := sulfuras, sellIn := 0, quality := 80 },
  { name := backstagePasses, sellIn := 15, quality := 20 },
  { name := backstagePasses, sellIn := 10, quality := 49 },
  { name := backstagePasses, sellIn := 5, quality := 49 }
]

#eval updateQuality sampleInventory

/-- The inventory after `days` days. -/
def simulate (days : Nat) (items : List Item) : List Item :=
  match days with
  | 0 => items
  | d + 1 => simulate d (updateQuality items)

#eval simulate 12 sampleInventory

end GildedRose
