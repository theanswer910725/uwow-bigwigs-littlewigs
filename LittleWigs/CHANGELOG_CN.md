# LittleWigs – 合并更新日志

---

## v40

### 通用

* **开钥匙按钮**：使用与 **BigWigs** 同步的独立倒计时；**再次点击可取消**；若权限允许，会在**团队通告**（`/rw`）发起倒计时；**倒计时结束自动开始钥石**。
* **自动 RIO 查询**：若密语者**已在你的队伍中**则**不触发**查询。

### 地下城

* **重返卡拉赞：下层** — 歌剧院事件：新增 **“能量之杯”（Cup of Power）** 按钮，显示**当周歌剧院轮换**，会私聊给自己并可在队伍/团队频道广播（**不需要**插钥匙即可查看）。
* **魔法回廊（The Arcway）** — “大门事件”：**开钥匙**时自动识别当周**哪一侧开启**并在队伍频道提示（由**坦克或钥匙持有者**发送）。
* **黑鸦堡垒（Black Rook Hold）·小怪** — 修复 **命令怒吼（Commanding Shout）** 的误触发计时。
* **英灵殿（Halls of Valor）·小怪** — **穿透射击（Piercing Shot）** 计时条会显示**施法单位的团队标记**。
  **四王事件** — `!pull` 对话按钮的**视觉样式优化**。
* **黑心林地（Darkheart Thicket）·小怪** — **污秽爆发（Foul Explosion）** 计时条显示**施法者标记**。
* **守望者地窟（Vault of the Wardens）— 科达娜（Cordana）** — **对话/激活**计时修正。
* **执政团之座（Seat of the Triumvirate）— 萨普瑞什（Saprish）** — 将 **幽灵打击（Ghostly Strike）** 的简短聊天提示替换为 **/say 倒计时**，覆盖其**起手冲锋**阶段。
* **奈萨里奥的巢穴（Neltharion’s Lair）— 洛克莫拉（Rokmora）** — **对话/激活**计时修正。
* **影月墓地（Shadowmoon Burial Grounds）·小怪** — **虚空之子（Void Spawn/Child of the Void）** 在**换边**时增加**提示与计时**。

---

## v39

### 通用

* **自动 RIO**：对**新收到的密语**自动 `.ch`（支持**简略/完整**输出），带**对同一单位的防刷屏**；可在 **“队伍信息（PARTY INFO）”** 模块启用/关闭。
* **自动填写自定义组**：在公共频道**链接钥石**时，活动查找器的**自定义组**会自动**按钥石信息填充**（可在 **PARTY INFO** 开关）。
* **开钥匙面板**：新增**准备就绪（Ready Check）**与**5 秒拉怪**按钮。
* **更丰富的危险施法计时**：对 **Storm Shield / Voidlash / Necrotic Burst / Commanding Shout / Shell Armor / Entropic Mist / Scorching Rain / Hurricane Eye** 等关键施法，计时条会显示**该次施法的单位标记**（若无标记则显示**次序编号**）。

### 地下城

* **群星庭院（Court of Stars）**

  * **增益道具宏系统**：**高延迟**适配；修正**英文宏**。
  * **“找间谍”**：基于目标的 `_scan`，带**冷却条**、**真假间谍**提示；当你**锁定到真间谍**会向队伍提示；也会**利用队友的扫描结果**。
  * **“房间激活”**：当**第一个检查点**被激活而仍有队友**在外面**时，**队长/坦克**会提示。
* **执政团之座·小怪** — 新增 **熵雾（Entropic Mist）** 计时。
* **永夜大教堂（Cathedral of Eternal Night）·小怪** — 新增 **灼热之雨（Scorching Rain）** 计时。
* **永茂林地（The Everbloom）— 雅努（Yalnu）** — **激活计时修正**；新增**被践踏花朵计数器**。
* **英灵殿**

  * **赫娅（Hyrja）之前的小怪（欧米尔/索尔岑）**：屏蔽**仅限首领**的计时条。
  * **四王事件**：团队领袖对话框新增 **Ready Check** 与 **`!pull`** 按钮。
* **重返卡拉赞：上层 — 馆长（Curator）** — 调整 **召唤不稳定能量（Summon Unstable Energy）** 的计时；为 **能量释放（Energy Discharge）** 添加**计时+提示**；移除**宝珠层数/跳跃**的刷屏。
* **奈萨里奥的巢穴** — **乌拉罗格**与**达古尔**的计时/提示**优化**；**小怪**新增 **召唤沙虫（Call Worm）** 的**计时与通报**。
* **噬魂之喉（Maw of Souls）— 斯卡加尔（Skjal）** — **目标与自身**都会获得 **No Mercy** 的预警。
* **黑鸦堡垒·小怪** — **亡灵弓箭手：射击（Shoot）** 的提示**响应更及时**。

**自动标记（Automarks）**：新增可选条目——**魔法回廊：夜之子复活者（Nightborne Reanimator）**，**黑鸦堡垒：无魂防御者（Soulless Defender）**。

---

## v38 — *“从 3k rio 到 3k pivo”*

### 通用

* 移除**跳过过场动画**的聊天刷屏。
* **自动标记模块**：为**所有大秘境**加入（默认**关闭**）。可在各副本的 **“⇒ 自动标记 ⇐（AutoMarks）”** 子页配置。
* **自动开钥匙**：当收到 **Exorsus Raid Tools（ERT）** 或 **BigWigs** 的倒计时时（**以钥匙持有者**的倒计时为准）自动开始。
* **自动确认个人拾取**弹窗（如**猎血者战利品**、**圣光的宝藏**等）。
* **自动保存（`.save`）**：现可**自行关闭**（在 **“安托鲁斯 → 信息（Info）”** 模块里）。

### 地下城

* **永茂林地 — 远古保卫者（Ancient Protectors）** — 可选显示 **自然之怒（Nature’s Wrath）** 与 **水箭（Water Bolt）** 的**目标**。
* **奈萨里奥的巢穴**

  * **洛克莫拉**：改进**小怪刷新**触发；若会与 **碎裂（Shatter）** 重叠则**不启动**下一波小怪计时。
  * **乌拉罗格·塑山（Ularogg Cragshaper）**：计时修正。
* **英灵殿 — 斯科瓦尔德（Skovald）** — **激活计时**修正。
* **艾萨拉之眼（Eye of Azshara）**

  * **督军帕杰什（Warlord Parjesh）**：**投矛**（Impaling/Piercing Spear）**偏移**调整。
  * **小怪 / 海拉加怒（Wrath of Azshara）**：当**你携带** **奥术炸弹（Arcane Bomb）** 时，新增**爆炸计时**。
* **黑心林地 — 萨维斯之影（Shade of Xavius）** — 为 **世界末日之梦（Apocalyptic Nightmare）** 添加**新的触发与文案**。
* **永夜大教堂**

  * **纳拉莎（Nal’asha，小怪）** — 计时修正。
  * **多玛崔克斯（Domatrax）** — **传送门小怪**出现时**广播**；可选\*\*/say 倒计时\*\*提示 **混沌能量（Chaotic Energy）**。
* **重返卡拉赞**

  * **歌剧院（美女与野兽）** — **激活计时**修正。
  * **猎手阿图曼（Huntsman Attumen）** — 调整阶段行为的**血量阈值**。
* **群星庭院 — 顾问麦兰杜斯（Advisor Melandrus）** — **激活计时**修正。
* **噬魂之喉** — **斯卡加尔（Skjal）**：新增**计时**；**小怪**：新增**开怪即启**的计时。
* **群星庭院 — 团队增益检查宏**（**坐船之后**执行）：宏会扫描队伍**可获取**的**所有增益**；不会列出**你已有**或**队伍职业无法获得**的增益。（**需要 BigWigs v98.1**）

> **英文宏（保留原样）**
>
> ```
> /tar Conduit
> /tar Flask
> /tar Orb
> /tar Infernal
> /tar Magical
> /tar Refreshments
> /tar Brew
> /tar Umbral
> /tar Waterlogged
> /tar Bazaar
> /tar Statue
> /tar Discarded
> /tar Wounded
> /cleartarget
> ```

---

## v37

### 通用

* **自动执行 `.save`**：拾取后**自动保存**（**22 秒**节流）。
* **队长提示**：钥石结束、所有人**离开副本**后，提示**更新地下城难度**。

### 地下城

* **艾萨拉之眼**

  * **督军帕杰什** — **穿刺之矛（Piercing/Impaling Spear）**：**/say** 倒计时显示剩余时间；若通过 **影遁/假死**规避，则**清除标记**。
  * **仇恨女巫（Lady Hatecoil）** — 当 **女巫诅咒（Witch’s Curse）** 与 **闪电之环（Lightning Ring）** 重叠时，**/say 倒计时**会带 **{骷髅}** 图标（避免把队友**击退**）。
  * **瑟芬崔斯克（Serpentrix）** — **淬毒创伤（Poisoned Wound）**：**/say 倒计时**。
  * **阿苏纳之怒（Wrath of Azshara）** — **海洋之怒（Sea’s Fury）**：**/say 倒计时**；若通过 **影遁/假死**规避，则**清除标记**。
  * **小怪** — **沙射（Sand Blast）** 计时修正；**甲壳护体（Shell Armor）** 新增计时。
* **黑心林地 — 橡树之心（Oakheart）** — **碾压之握（Crushing Grip）**：**/say 倒计时**。
* **永夜大教堂**

  * **（Thrashbite the Scornful）** — **轻蔑凝视（Scornful Gaze）**：**/say 倒计时**。
  * **多玛崔克斯（Domatrax）** — **传送门小怪**出现时**自动标记**。
* **执政团之座**

  * **升华者祖拉尔（Zuraal the Ascended）** — **能量获取**阶段提示；**100%** 时**聊天通报**；**凝视/集中（Fixate/Focus）**：**/say 倒计时**。
  * **终章前** — **大门开启 AFK 计时**。
* **重返卡拉赞：下层**

  * **扫帚（Broom）** — **大扫除（Hard Sweep）**：**/say 倒计时**。
  * **贞节圣女（Maiden of Virtue）** — **神圣之地（Holy Ground）**：**/say 倒计时**。
  * **猎手阿图曼** — **共受苦难（Shared Suffering）**：**/say 倒计时**；**上马**阶段计时调整；**20% 血量**提示。
  * **馆长（The Curator）** — 当 **不稳定能量（Unstable Energy）** **点到你**时 **/say** 提示 + **/say 倒计时**。
  * **多处小怪** — 在**低血量**时增加**读条预警**（如 **女妖之嚎、灌醉猛击**）；**幽灵马夫（Spectral Stable Hand）— 治疗之触（Healing Touch）**：新增**计时+提示**。
* **重返卡拉赞：上层**

  * **麦迪文之影（Shade of Medivh）** — 显示 **穿刺飞弹（Piercing Missiles）**、**地狱烈焰箭（Inferno Bolt）**、**霜寒（Frostbite）** 的**目标**。
  * **监视者维兹艾杜姆（Viz’aduum the Watcher）** — **魔化射线（Fel Beam）**：**/say 倒计时**；**黑暗之痰（Dark Phlegm）** 计时调整。
  * **“国王事件”** — **25% 血量**警告；当低于 25% 时**不再显示易伤**计时；**自动设置/清除**骷髅标记；**终门前** AFK 计时。
* **英灵殿**

  * **四王事件** — 同时开多个国王**不再需要**聊天指令；当队长点击对话，安装本版本的队员会**自动确认**所选国王。新增 **先祖召唤（Call Ancestors）** 的计时与提示；**啤酒杯（Mug of Mead）** 交互提示；**赫娅** 的激活计时；修复 **奉献/风暴之眼** 开场计时的**清除**逻辑；**放逐之光（Expel Light）**：**/say 倒计时**。
  * **奥丁** — **符文印记（Runic Brand）** 的面向说明更清晰：**坦克背对王座**，其他人**面向王座**。
  * **芬雷尔（Fenryr）** — **嗜血气味（Scent of Blood）**：**/say 倒计时**；**掠食飞扑（Ravenous Leap）**：**起跳前 /say** 提示；若**你**被飞扑，**/say {骷髅}** 并播放 **Bam** 音效。
* **群星庭院**

  * **召唤巡逻（Signal the Patrol）** — **AFK 计时**。
  * **关闭信标（Disable the Beacon）** — **队伍通报**。
  * **塔丽克赛·焰誓（Talixae Flamewreath）** — 为 **炼狱喷发（Infernal Eruption）**、**强烈燃烧（Intense Burning）**、**凋零之魂（Withered Soul）** 做**施法序号与计时**修正。
  * **顾问麦兰杜斯** — **激活触发/计时**修正。
  * **防护圣骑专属神器“寻真者”**：当**放置神器**时会**提示侦测到间谍**。
* **奈萨里奥的巢穴**

  * **岩石巨像（Understone Colossus）** — **裂隙（Fissure）** 计时。
  * **洛克莫拉** — **激活计时/触发**修正；**碎裂（Shatter）**：根据早/晚**小怪刷新时机**给出**颜色提示**（早 = **橙色/Punch**，晚 = **红色/Bam** + 屏幕闪光）。
  * **纳拉克萨斯（Naraxas）** — **尖刺之舌（Spiked Tongue）**：**标记目标**；当点到你时 **/say** 提示与**剩余读条**。
  * **“木桶漂流”** — **AFK 计时**。
* **黑鸦堡垒**

  * **灵魂魔像（Amalgam of Souls）** — **灵魂回响（Soul Echo）** 触发修改；当点到你时**播放音效**；自动**加十字标记**；**/say 倒计时**。
    **吞噬灵魂（Devour Souls）** — **层数通报**；**灵魂爆发（Soul Burst）** — **警报+屏幕闪烁**。
  * **伊莉萨娜·拉文凯斯（Illysanna Ravencrest）** — **穿透凝视（Piercing Gaze）**：**/say 倒计时** + 目标标记；**多个阶段**的计时/提示。
  * **碎骨者（Smashspite the Hateful）** — **仇恨凝视（Hateful Gaze）**：**/say 倒计时** + 标记；**野蛮重击（Brutal Haymaker）** 在 **90%/100% 怒气**时分别预警（100% 播放 **Bam**）；**邪能呕吐（Fel Vomit）** 目标提示；**邪蝠（Felbat）** 刷新计时。
  * **拉托修斯（Latosius）** — **无情打击（Relentless Strike，坦克）** 显示**施法序号**；**暗影箭雨（Dark Volley）** 计时；**毒蜂群（Stinging Swarm）** 标记目标与蜂群。
  * **开门** — **AFK 计时**。
* **魔法回廊**

  * **科蒂拉克斯（Corstilax）— 抑制协议（Suppression Protocol）**：若点到你会**提示**并 **/say 倒计时**；**减益计时**修正。
  * **纳尔提拉（Nal’tira，小怪）** — **第一次吞噬（Devour）** 计时。
  * **顾问凡多斯（Advisor Vandros）** — **激活计时**；**不稳定魔能（Unstable Mana）** — **/say 倒计时**；**时间裂分（Time Split）** 计时；**永恒梦魇（Timeless Wraith）— 时间锁定（Time Lock）**：目标提示 + **/say 倒计时**。
  * **伊凡尔（Ivanyr）— 不稳定魔法（Unstable Magic）** — **/say 倒计时**。
  * **暗影怨灵/奥术畸体（Warp Shade/Arcane Anomaly）** — 当其**生命值 <60%** 时，对 **奥术复原（Arcane Reconstitution）** 做**读条预警**。
* **守望者地窟**

  * **科达娜·邪歌（Cordana Felsong）** — **激活触发/计时**；**艾露恩之光（Elune’s Light）**：拾取时 **/say** 提示；**邪能飞刃（Fel Glaive）** 提示+计时；**缓慢逼近的厄运（Creeping Doom）** 计时；**复仇化身（Avatar of Vengeance）** 计时修正。
  * **提拉松·萨瑟里尔（Tirathon Saltheril）** — **激活**修正。
  * **阿什高姆（Ash’golm）** — **安保系统（Security System）** 计时修正。

