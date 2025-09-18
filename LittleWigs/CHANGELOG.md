# LittleWigs – uwow version Changelog

---

## v40

### General

* **Key start UI:** the custom **Start Key** button now runs its **own synced countdown** (tied to BigWigs), **cancels on second press**, posts a **/rw** countdown if allowed, and **auto-starts the key** when the timer ends.
* **Auto RIO check:** will **not** trigger if the whispering player is **already in your group**.

### Dungeons

* **Return to Karazhan: Lower** — Opera *Stage Events*: added a **“Cup of Power”** button that shows the **current week’s Opera rotation** in a personal message and in group/raid chat. (Key not required to see it.)
* **The Arcway** — *Door event*: on key start, detect **which side is active** and announce it (tank or key owner posts to party chat).
* **Black Rook Hold (trash)** — fixed false timer triggers for **Commanding Shout**.
* **Halls of Valor (trash)** — timers now include the **mob’s raid marker** for each **Piercing Shot** cast.
  **The Four Kings** — visual polish to the active **`!pull`** dialog button.
* **Darkheart Thicket (trash)** — timers show the **mob’s marker** per **Foul Explosion** cast.
* **Vault of the Wardens — Cordana** — corrected **dialog/activation timers**.
* **Seat of the Triumvirate — Saprish** — replaced the old chat blip for **Ghostly Strike** with a **/say countdown** to the start of the dash sequence.
* **Neltharion’s Lair — Rokmora** — corrected **dialog/activation timers**.
* **Shadowmoon Burial Grounds (trash)** — **Void Spawn** (“Child of the Void”): added **announce + timer** when it **switches sides**.

---

## v39

### General

* **Auto RIO**: automatic `.ch` on new whispers (short or full output), with **per-unit spam guard** and module toggles under **PARTY INFO**.
* **Auto LFG listing**: when you link a key in public chat, the **Premade Group listing** auto-fills from the key’s data (toggle in **PARTY INFO**).
* **Key start frame**: added **Ready Check** + **5-sec pull** buttons.
* **Richer timers for important casts**: per-cast bars show **the mob’s marker** (or a per-cast index if unmarked) for spells like **Storm Shield, Voidlash, Necrotic Burst, Commanding Shout, Shell Armor, Entropic Mist, Scorching Rain, Hurricane Eye, etc.**

### Dungeons

* **Court of Stars**

  * **Buff macro system**: tuned for **high-ping clients**; fixed **EN macros**.
  * **“Spy Finder”**: target-based **`_scan`** with a **cooldown bar**, **true/false spy** hints, party announce when you’ve targeted the **real spy**; also leverages **other players’ scans**.
  * **“Room active”**: leader/tank announces when the **first checkpoint** is activated with people still **outside**.
* **Seat of the Triumvirate (trash)** — timer for **Entropic Mist**.
* **Cathedral of Eternal Night (trash)** — timer for **Scorching Rain**.
* **The Everbloom — Yalnu** — fixed **activation timer**; added a **trampled-flowers counter**.
* **Halls of Valor**

  * **Pre-Hyrja trash (Olmyr/Solsten)**: suppressed **boss-only** bars.
  * **The Four Kings**: RL dialog now has **Ready Check** and **`!pull`** buttons.
* **Upper Karazhan — Curator** — adjusted **Summon Unstable Energy** timer; added timer+announce for **Energy Discharge**; removed **orb stack/jump** spam.
* **Neltharion’s Lair** — **Ularogg** and **Dargrul** timers/announces polished; **trash** timer+announce for **Call Worm**.
* **Maw of Souls — Skjal** — target & self alerts for **No Mercy**.
* **Black Rook Hold (trash)** — improved responsiveness for **Risen Archer – Shoot** alerts.

**Automarks additions:** selectable entries for **Nightborne Reanimator** (Arcway) and **Soulless Defender** (BRH).

---

## v38  — *“From 3k rio to 3k pivo”*

### General

* Removed chat spam about **skipping cinematics**.
* **Automarks modules** added to **all M+ dungeons** (off by default). Configure per-dungeon under **“⇒ AutoMarks ⇐”**.
* **Auto-start key** on countdowns from **Exorsus Raid Tools** or **BigWigs** (must use the **key owner’s** countdown).
* **Auto-confirm Personal Loot** popups (for things like **Bloodhunter’s Trophies**, **Light’s Treasure**, etc.).
* **Autosave** (`.save`) can now be **disabled** (see **Antorus → Info** module).

### Dungeons

* **The Everbloom — Ancient Protectors** — optional setting to **show the target** of **Nature’s Wrath** and **Water Bolt**.
* **Neltharion’s Lair**

  * **Rokmora**: improved add-spawn trigger; don’t start the next add timer if it would overlap **Shatter**.
  * **Ularogg Cragshaper**: timer fixes.
* **Halls of Valor — Skovald** — activation-timer fix.
* **Eye of Azshara**

  * **Warlord Parjesh**: adjusted **Spear Throw** offset.
  * **Trash / Wrath of Azshara**: **Arcane Bomb** explosion timer when **you** carry it.
* **Darkheart Thicket — Shade of Xavius** — new trigger/text for **Apocalyptic Nightmare**.
* **Cathedral of Eternal Night**

  * **Nal’asha (trash)** — timer fixes.
  * **Domatrax** — portal-spawn announces; optional **/say countdown** for **Chaotic Energy**.
* **Return to Karazhan**

  * **Opera (Beauty & the Beast)** — activation-timer fix.
  * **Huntsman Attumen** — adjusted **HP threshold** for phase behavior.
* **Court of Stars — Advisor Melandrus** — activation-timer fix.
* **Maw of Souls** — **Skjal**: added timers; **trash**: added **from-pull** timers.
* **Court of Stars — Group buff check macro** (run **after the boat**): macro scans all **available buffs** for your group; it **doesn’t list** buffs you already have or that your comp can’t obtain. *(Requires BigWigs v98.1.)*

---

## v37

### General

* Auto-exec **`.save`** after you loot (**22s throttle**).
* **Leader announce** to update **dungeon difficulty after a key**, once everyone leaves.

### Dungeons

* **Eye of Azshara**

  * **Warlord Parjesh — Piercing Spear**: **/say countdown** for remaining debuff; **clear marker** if avoided via **Meld/Feign**.
  * **Lady Hatecoil — Witch’s Curse** overlaps **Lightning Ring**: **/say countdown** shows a **skull** (avoid knocking teammates).
  * **Serpentrix — Poisoned Wound**: **/say countdown**.
  * **Wrath of Azshara — Sea’s Fury**: **/say countdown**; **clear marker** if avoided via **Meld/Feign**.
  * **Mak’rana Siltwalker — Sand Blast**: timer fix.
  * **Mak’rana Hardshell — Shell Armor**: added timer.
* **Darkheart Thicket — Oakheart** — **Crushing Grip**: **/say countdown**.
* **Cathedral of Eternal Night**

  * **Thrashbite the Scornful — Scornful Gaze**: **/say countdown**.
  * **Domatrax** — **auto-mark** on portal add spawns.
* **Seat of the Triumvirate**

  * **Zuraal the Ascended** — **energy gain** announce + **chat at 100%**; **Fixate** (focus) **/say countdown**.
  * **Before last boss** — **AFK timer** for the gate opening.
* **Return to Karazhan: Lower**

  * **Broom — Hard Sweep**: **/say countdown**.
  * **Maiden of Virtue — Holy Ground**: **/say countdown**.
  * **Huntsman Attumen** — **Shared Suffering**: **/say countdown**; **Mounted** phase timing adjusted; **20% HP** announce.
  * **The Curator — Unstable Energy**: **/say if it’s on you** + **/say countdown**.
  * **Various trash** — pre-cast warnings when **low HP** (*Banshee Wail*, *Drunken Skull Crack*); **Spectral Stable Hand — Healing Touch**: timer + announce.
* **Return to Karazhan: Upper**

  * **Shade of Medivh** — show targets for **Piercing Missiles**, **Inferno Bolt**, **Frostbite**.
  * **Viz’aduum the Watcher** — **Fel Beam**: **/say countdown**; **Dark Phlegm** timer tuned.
  * **“King” event** — **25% HP** warning; suppress vulnerability timers below 25%; **skull** marker auto-set/cleared; **Pre-last door** AFK timer.
* **Halls of Valor**

  * **The Four Kings** — starting **multiple kings** no longer needs the chat command; when the leader clicks a dialog, everyone with this version auto-confirms their chosen king. Also: **Call Ancestors** timer+announce; **Mug of Mead** interaction announce; **Hyrja** activation timer; fixed timer clearing for opening **Sanctify/Eye of the Storm**; **Expel Light**: **/say countdown**.
  * **Odyn — Runic Brand** helper directions clarified (tanks face **away** from the throne; others face **toward** it).
  * **Fenryr — Scent of Blood**: **/say countdown**; **Ravenous Leap**: **/say pre-leap** and `/say {skull}` on leap-into-you with **Bam** sound.
* **Court of Stars**

  * **Signal the Patrol** — **AFK timer**.
  * **Disable the Beacon** — party announce.
  * **Talixae Flamewreath** — cast-indexing & timer corrections for **Infernal Eruption**, **Intense Burning**, **Withered Soul**.
  * **Advisor Melandrus** — activation trigger/timer fix.
  * **Protection Paladin** “Truthseeker” artifact: **spy detection** announce when the artifact is placed.
* **Neltharion’s Lair**

  * **Understone Colossus — Fissure**: timer.
  * **Rokmora** — activation timer/trigger fixes; **Shatter**: colored timing announce for add spawns (early = **orange/Punch**, late = **red/Bam** + screen flash).
  * **Naraxas — Spiked Tongue**: mark the target; **/say if on you**; **/say** remaining cast time.
  * **“Barrel ride”**: **AFK timer**.
* **Black Rook Hold**

  * **Amalgam of Souls — Soul Echo**: start trigger changed; **sound** if it targets you; **cross** mark; **/say countdown**.
  * **Devour Souls** — stack announce; **Soul Burst** — alert + screen flash.
  * **Illysanna Ravencrest — Piercing Gaze**: **/say countdown** + target mark; **phase** bars/announces.
  * **Smashspite the Hateful — Hateful Gaze**: **/say countdown** + mark; **Brutal Haymaker** warnings at **90%/100%** rage (with **Bam** at 100%); **Fel Vomit** target announce; **Felbat Summon** timer.
  * **Latosius** — **Relentless Strike (tank)** shows **cast index**; **Dark Volley** timer; **Stinging Swarm** target mark + swarm mark.
  * **Gate open** — **AFK timer**.
* **The Arcway**

  * **Corstilax — Suppression Protocol**: **if on you** announce + **/say countdown**; debuff timer fix.
  * **Nal’tira (mob)** — **first Devour** timer.
  * **Advisor Vandros** — activation timer; **Unstable Mana** — **/say countdown**; **Time Split** timer; **Time Lock (Timeless Wraith)** — target announce + **/say countdown**.
  * **Ivanyr — Unstable Magic** — **/say countdown**.
  * **Warp Shade / Arcane Anomaly** — **Arcane Reconstitution** pre-cast warning when **<60% HP**.
* **Vault of the Wardens**

  * **Cordana Felsong** — activation trigger/timer; **Elune’s Light** **/say** on pickup; **Fel Glaive** announce+timer; **Creeping Doom** timer; **Avatar of Vengeance** timer fix.
  * **Tirathon Saltheril** — activation fixes.
  * **Ash’golm** — **Security System** timer correction.
