\c pokemon;

-- Arquivo para popular pokémons --
-- INSERT group 0: ELEMENTO
INSERT INTO elemento (nome) VALUES ('fogo'), ('água'), ('grama'), ('voador'), ('lutador'), ('veneno'), ('elétrico'), ('terra'), ('pedra'), ('psíquico'), ('gelo'), ('inseto'), ('fantasma'), ('ferro'), ('dragão'), ('sombrio'), ('fada'), ('normal');

-- INSERT group 1: MAPA, REGIÃO, POSIÇÃO, REGIAO POSSUI ELEMENTO

-- MAPA
INSERT INTO mapa (id) VALUES (DEFAULT);

-- REGIÃO
INSERT INTO regiao (entrada, id_mapa) VALUES (0, 1), (2, 1), (4, 1);

-- REGIÃO POSSUI ELEMENTO
INSERT INTO regiao_possui_elemento (id_regiao, id_elemento) VALUES 
(1, 3), (1, 4), (1, 5), (1, 8), (1, 12), (1, 18), -- REGIÃO 1
(2, 1), (2, 2), (2, 7), (2, 9), (2, 11), (2, 14), -- REGIÃO 2
(3, 6), (3, 10), (3, 13), (3, 15), (3, 16), (3, 17); -- REGIÃO 3

-- POSIÇÃO
INSERT INTO posicao (id_regiao, norte, sul , leste , oeste , cima , baixo) VALUES
-- POSIÇÕES REGIÃO 1
(1, 2, NULL, 4, NULL, NULL, NULL), (1, NULL, 1, 3, NULL, NULL, NULL), (1, NULL, 4, NULL, 2, NULL, NULL),
(1, 3, 5, 7, 1, NULL, NULL), (1, 4, NULL, 6, NULL, NULL, NULL), (1, 7, NULL, NULL, 5, NULL, NULL),
(1, NULL, 6, 8, 4, NULL, NULL), (1, 9, 11, NULL, 7, NULL, NULL), (1, NULL, 8, 13, 10, NULL, NULL),
(1, NULL, NULL, 9, NULL, NULL, NULL), (1, 8, NULL, 12, NULL, NULL, NULL), (1, 14, NULL, 15, 11, NULL, NULL),
(1, NULL, 14, 15, 9, NULL, NULL), (1, 13, 12, 15, NULL, NULL, NULL), (1, 13, 12, 16, 14, NULL, NULL),
-- POSIÇÕES REGIÃO 2
(2, 19, 17, 20, 15, NULL, NULL), (2, 16, NULL, 18, NULL, NULL, NULL), (2, NULL, NULL, 25, NULL, NULL, NULL),
(2, NULL, 20, NULL, 16, NULL, NULL), (2, 19, NULL, 21, 16, NULL, NULL), (2, NULL, NULL, 22, 20, NULL, NULL),
(2, NULL, 25, 23, 21, NULL, NULL), (2, 24, 26, NULL, 22, NULL, NULL), (2, NULL, 23, NULL, NULL, NULL, NULL),
(2, 22, 27, 26, 28, NULL, NULL), (2, 23, 27, NULL, 25, NULL, NULL), (2, 25, 30, 26, 28, NULL, NULL),
(2, 25, 29, 27, NULL, NULL, NULL), (2, 28, 32, 30, NULL, NULL, NULL), (2, 27, 32, 31, 29, NULL, NULL),
(2, NULL, 32, NULL, 30, NULL, NULL), (2, 30, 33, 31, 29, NULL, NULL),
-- POSIÇÕES REGIÃO 3
(3, 32, 44, NULL, NULL, NULL, 34), (3, NULL, 41, 35, 36, NULL, NULL), (3, NULL, 37, NULL, 34, NULL, NULL),
(3, NULL, 38, 34, NULL, NULL, NULL), (3, 35, 39, NULL, 41, NULL, NULL), (3, 36, 40, 41, NULL, NULL, NULL),
(3, 37, NULL, NULL, 42, NULL, NULL), (3, 38, NULL, 42, NULL, NULL, NULL), (3, 34, 42, 37, 38, NULL, NULL),
(3, 41, NULL, 39, 40, 43, NULL), (3, 46, NULL, NULL, NULL, NULL, NULL), (3, 33, 45, NULL, NULL, NULL, NULL),
(3, 44, 46, NULL, NULL, NULL, NULL), (3, 45, 43, NULL, NULL, NULL, NULL);

-- INSERT group 2: NPC, TREINADOR, MOCHILA, POKEDEX
-- TODO: Quando o mapa for criado, corrigir NPCs e Professor - DONE, mas testar com mapa ainda sim

-- NPC
INSERT INTO npc (nome, fala, profissao, id_posicao) VALUES 
('Mãe', 'Oh, meu filho, cresceu tanto! Já vai sair na sua primeira jornada Pokémon... Não esqueça de me ligar S2', 'matriarca', 2),
('Professor Oak', 'Olá treinador, sou o Professor Oak!! Você sabia que existem vários tipos de pokébola? Cada uma delas possui uma taxa de captura maior. Use elas com sabedoria', 'professor', 4),
('Vendedor June', 'Bem vindo a minha lojinha! Fique avontade!!', 'vendedor', 6),
('BugCatcher April', 'Insetos!! Insetos!! Procuro apenas pokemons Insetos!!', 'bugcatcher', 17),
('Professor Algo', 'Tudo bem treinador? Me chamo Professor Algo. Você sabia que certos pokemons podem evoluir sem adquirir experiência? Basta dar a ele a Evostone correta!!', 'professor', 22),
('Vendedora May', 'Ei muleque, não toque em nada que não vá pagar!!', 'vendedor', 26),
('Aventureiro Jonas', 'Fazem alguns meses desde que sai da minha cidade natal para minha jornada, é um pouco solitário mas é uma experiência incrível', 'aventureiro', 43);

-- Treinador
INSERT INTO treinador (nome, nivel, dinheiro, insignia, id_posicao, id_professor) VALUES ('Ash Ketchum', 0, 500.00, 'iniciante', 1, 2);

-- Mochila
INSERT INTO mochila (id, capacidade, dinheiro_maximo) VALUES ('Ash Ketchum', 50, 500.00);

-- Pokedex
INSERT INTO pokedex (id) VALUES ('Ash Ketchum');

-- Pokemon
INSERT INTO pokemon (especie, tamanho, peso, descricao, elemento1,  taxa_captura, elemento2) VALUES  ('bulbasaur', 7, 69, 'There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.', 3, 0.75, 6), 
('ivysaur', 10, 130, 'When the bulb on its back grows large, it appears to lose the ability to stand on its hind legs.', 3, 0.55, 6), 
('venusaur', 20, 1000, 'Its plant blooms when it is absorbing solar energy. It stays on the move to seek sunlight.', 3, 0.45, 6), 
('charmander', 6, 85, 'It has a preference for hot things. When it rains, steam is said to spout from the tip of its tail.', 1, 0.75, null), 
('charmeleon', 11, 190, 'It has a barbaric nature. In battle, it whips its fiery tail around and slashes away with sharp claws.', 1, 0.55, null), 
('charizard', 17, 905, 'It spits fire that is hot enough to melt boulders. It may cause forest fires by blowing flames.', 1, 0.45, 4), 
('squirtle', 5, 90, 'When it retracts its long neck into its shell, it squirts out water with vigorous force.', 2, 0.75, null), 
('wartortle', 10, 225, 'It is recognized as a symbol of longevity. If its shell has algae on it, that Wartortle is very old.', 2, 0.55, null), 
('blastoise', 16, 855, 'It crushes its foe under its heavy body to cause fainting. In a pinch, it will withdraw inside its shell.', 2, 0.45, null), 
('caterpie', 3, 29, 'For protection, it releases a horrible stench from the antenna on its head to drive away enemies.', 12, 0.75, null), 
('metapod', 7, 99, 'It is waiting for the moment to evolve. At this stage, it can only harden, so it remains motionless to avoid attack.', 12, 0.55, null), 
('butterfree', 11, 320, 'In battle, it flaps its wings at great speed to release highly toxic dust into the air.', 12, 0.45, 4), 
('weedle', 3, 32, 'Beware of the sharp stinger on its head. It hides in grass and bushes where it eats leaves.', 12, 0.75, 6), 
('kakuna', 6, 100, 'Able to move only slightly. When endangered, it may stick out its stinger and poison its enemy.', 12, 0.55, 6), 
('beedrill', 10, 295, 'It has three poisonous stingers on its forelegs and its tail. They are used to jab its enemy repeatedly.', 12, 0.45, 6), 
('pidgey', 3, 18, 'Very docile. If attacked, it will often kick up sand to protect itself rather than fight back.', 18, 0.75, 4), 
('pidgeotto', 11, 300, 'This Pokémon is full of vitality. It constantly flies around its large territory in search of prey.', 18, 0.55, 4), 
('pidgeot', 15, 395, 'This Pokémon flies at Mach 2 speed, seeking prey. Its large talons are feared as wicked weapons.', 18, 0.45, 4), 
('rattata', 3, 35, 'Will chew on anything with its fangs. If you see one, you can be certain that 40 more live in the area.', 18, 0.6, null), 
('raticate', 7, 185, 'Its hind feet are webbed. They act as flippers, so it can swim in rivers and hunt for prey.', 18, 0.5, null), 
('spearow', 3, 20, 'Inept at flying high. However, it can fly around very fast to protect its territory.', 18, 0.6, 4), 
('fearow', 12, 380, 'A Pokémon that dates back many years. If it senses danger, it flies high and away, instantly.', 18, 0.5, 4), 
('ekans', 20, 69, 'The older it gets, the longer it grows. At night, it wraps its long body around tree branches to rest.', 6, 0.6, null), 
('arbok', 35, 650, 'The frightening patterns on its belly have been studied. Six variations have been confirmed.', 6, 0.5, null), 
('pikachu', 4, 60, 'Pikachu that can generate powerful electricity have cheek sacs that are extra soft and super stretchy.', 7, 0.6, null), 
('raichu', 8, 300, 'Its long tail serves as a ground to protect itself from its own high-voltage power.', 7, 0.5, null), 
('sandshrew', 6, 120, 'It loves to bathe in the grit of dry, sandy areas. By sand bathing, the Pokémon rids itself of dirt and moisture clinging to its body.', 8, 0.6, null), 
('sandslash', 10, 295, 'The drier the area Sandslash lives in, the harder and smoother the Pokémon’s spikes will feel when touched.', 8, 0.5, null), 
('nidoran-f', 4, 70, 'Females are more sensitive to smells than males. While foraging, they’ll use their whiskers to check wind direction and stay downwind of predators.', 6, 0.75, null), 
('nidorina', 8, 200, 'The horn on its head has atrophied. It’s thought that this happens so Nidorina’s children won’t get poked while their mother is feeding them.', 6, 0.55, null), 
('nidoqueen', 13, 600, 'Nidoqueen is better at defense than offense. With scales like armor, this Pokémon will shield its children from any kind of attack.', 6, 0.45, 8), 
('nidoran-m', 5, 90, 'The horn on a male Nidoran’s forehead contains a powerful poison. This is a very cautious Pokémon, always straining its large ears.', 6, 0.75, null), 
('nidorino', 9, 195, 'With a horn that’s harder than diamond, this Pokémon goes around shattering boulders as it searches for a moon stone.', 6, 0.55, null), 
('nidoking', 14, 620, 'When it goes on a rampage, it’s impossible to control. But in the presence of a Nidoqueen it’s lived with for a long time, Nidoking calms down.', 6, 0.45, 8), 
('clefairy', 6, 75, 'It is said that happiness will come to those who see a gathering of Clefairy dancing under a full moon.', 17, 0.6, null), 
('clefable', 13, 400, 'A timid fairy Pokémon that is rarely seen, it will run and hide the moment it senses people.', 17, 0.5, null), 
('vulpix', 6, 99, 'While young, it has six gorgeous tails. When it grows, several new tails are sprouted.', 1, 0.6, null), 
('ninetales', 11, 199, 'It is said to live 1,000 years, and each of its tails is loaded with supernatural powers.', 1, 0.5, null), 
('jigglypuff', 5, 55, 'Jigglypuff has top-notch lung capacity, even by comparison to other Pokémon. It won’t stop singing its lullabies until its foes fall asleep.', 18, 0.6, 17), 
('wigglytuff', 10, 120, 'The more air it takes in, the more it inflates. If opponents catch it in a bad mood, it will inflate itself to an enormous size to intimidate them.', 18, 0.5, 17), 
('zubat', 8, 75, 'It emits ultrasonic waves from its mouth to check its surroundings. Even in tight caves, Zubat flies around with skill.', 6, 0.6, 4), 
('golbat', 16, 550, 'It loves to drink other creatures’ blood. It’s said that if it finds others of its kind going hungry, it sometimes shares the blood it’s gathered.', 6, 0.5, 4), 
('oddish', 5, 54, 'If exposed to moonlight, it starts to move. It roams far and wide at night to scatter its seeds.', 3, 0.75, 6), 
('gloom', 8, 86, 'Its pistils exude an incredibly foul odor. The horrid stench can cause fainting at a distance of 1.25 miles.', 3, 0.55, 6), 
('vileplume', 12, 186, 'It has the world’s largest petals. With every step, the petals shake out heavy clouds of toxic pollen.', 3, 0.45, 6), 
('paras', 3, 54, 'Burrows under the ground to gnaw on tree roots. The mushrooms on its back absorb most of the nutrition.', 12, 0.6, 3), 
('parasect', 10, 295, 'The bug host is drained of energy by the mushroom on its back. The mushroom appears to do all the thinking.', 12, 0.5, 3), 
('venonat', 10, 300, 'Its large eyes act as radar. In a bright place, you can see that they are clusters of many tiny eyes.', 12, 0.6, 6), 
('venomoth', 15, 125, 'The powdery scales on its wings are hard to remove from skin. They also contain poison that leaks out on contact.', 12, 0.5, 6), 
('diglett', 2, 8, 'If a Diglett digs through a field, it leaves the soil perfectly tilled and ideal for planting crops.', 8, 0.6, null), 
('dugtrio', 7, 333, 'A team of Diglett triplets. It triggers huge earthquakes by burrowing 60 miles underground.', 8, 0.5, null), 
('meowth', 4, 42, 'It loves to collect shiny things. If it’s in a good mood, it might even let its Trainer have a look at its hoard of treasures.', 18, 0.6, null), 
('persian', 10, 320, 'Getting this prideful Pokémon to warm up to you takes a lot of effort, and it will claw at you the moment it gets annoyed.', 18, 0.5, null), 
('psyduck', 8, 196, 'Psyduck is constantly beset by headaches. If the Pokémon lets its strange power erupt, apparently the pain subsides for a while.', 2, 0.6, null), 
('golduck', 17, 766, 'This Pokémon lives in gently flowing rivers. It paddles through the water with its long limbs, putting its graceful swimming skills on display.', 2, 0.5, null), 
('mankey', 5, 280, 'An agile Pokémon that lives in trees. It angers easily and will not hesitate to attack anything.', 5, 0.6, null), 
('primeape', 10, 320, 'It stops being angry only when nobody else is around. To view this moment is very difficult.', 5, 0.5, null), 
('growlithe', 7, 190, 'It has a brave and trustworthy nature. It fearlessly stands up to bigger and stronger foes.', 1, 0.6, null), 
('arcanine', 19, 1550, 'The sight of it running over 6,200 miles in a single day and night has captivated many people.', 1, 0.5, null), 
('poliwag', 6, 124, 'For Poliwag, swimming is easier than walking. The swirl pattern on its belly is actually part of the Pokémon’s innards showing through the skin.', 2, 0.75, null), 
('poliwhirl', 10, 200, 'Staring at the swirl on its belly causes drowsiness. This trait of Poliwhirl’s has been used in place of lullabies to get children to go to sleep.', 2, 0.55, null), 
('poliwrath', 13, 540, 'Its body is solid muscle. When swimming through cold seas, Poliwrath uses its impressive arms to smash through drift ice and plow forward.', 2, 0.45, 5), 
('abra', 9, 195, 'This Pokémon uses its psychic powers while it sleeps. The contents of Abra’s dreams affect the powers that the Pokémon wields.', 10, 0.75, null), 
('kadabra', 13, 565, 'Using its psychic power, Kadabra levitates as it sleeps. It uses its springy tail as a pillow.', 10, 0.55, null), 
('alakazam', 15, 480, 'It has an incredibly high level of intelligence. Some say that Alakazam remembers everything that ever happens to it, from birth till death.', 10, 0.45, null), 
('machop', 8, 195, 'Its whole body is composed of muscles. Even though it’s the size of a human child, it can hurl 100 grown-ups.', 5, 0.75, null), 
('machoke', 15, 705, 'Its muscular body is so powerful, it must wear a power-save belt to be able to regulate its motions.', 5, 0.55, null), 
('machamp', 16, 1300, 'It quickly swings its four arms to rock its opponents with ceaseless punches and chops from all angles.', 5, 0.45, null), 
('bellsprout', 7, 40, 'Prefers hot and humid places. It ensnares tiny bugs with its vines and devours them.', 3, 0.75, 6), 
('weepinbell', 10, 64, 'When hungry, it swallows anything that moves. Its hapless prey is dissolved by strong acids.', 3, 0.55, 6), 
('victreebel', 17, 155, 'Lures prey with the sweet aroma of honey. Swallowed whole, the prey is dissolved in a day, bones and all.', 3, 0.45, 6), 
('tentacool', 9, 455, 'Tentacool is not a particularly strong swimmer. It drifts across the surface of shallow seas as it searches for prey.', 2, 0.6, 6), 
('tentacruel', 16, 550, 'When the red orbs on Tentacruel’s head glow brightly, watch out. The Pokémon is about to fire off a burst of ultrasonic waves.', 2, 0.5, 6), 
('geodude', 4, 200, 'Commonly found near mountain trails and the like. If you step on one by accident, it gets angry.', 9, 0.75, 8), 
('graveler', 10, 1050, 'Often seen rolling down mountain trails. Obstacles are just things to roll straight over, not avoid.', 9, 0.55, 8), 
('golem', 14, 3000, 'Once it sheds its skin, its body turns tender and whitish. Its hide hardens when it’s exposed to air.', 9, 0.45, 8), 
('ponyta', 10, 300, 'It can’t run properly when it’s newly born. As it races around with others of its kind, its legs grow stronger.', 1, 0.6, null), 
('rapidash', 17, 950, 'This Pokémon can be seen galloping through fields at speeds of up to 150 mph, its fiery mane fluttering in the wind.', 1, 0.5, null), 
('slowpoke', 12, 360, 'Slow-witted and oblivious, this Pokémon won’t feel any pain if its tail gets eaten. It won’t notice when its tail grows back, either.', 2, 0.6, 10), 
('slowbro', 16, 785, 'Slowpoke became Slowbro when a Shellder bit on to its tail. Sweet flavors seeping from the tail make the Shellder feel as if its life is a dream.', 2, 0.5, 10), 
('magnemite', 3, 60, 'At times, Magnemite runs out of electricity and ends up on the ground. If you give batteries to a grounded Magnemite, it’ll start moving again.', 7, 0.6, 14), 
('magneton', 10, 600, 'This Pokémon is three Magnemite that have linked together. Magneton sends out powerful radio waves to study its surroundings.', 7, 0.5, 14), 
('farfetchd', 8, 150, 'The stalk this Pokémon carries in its wings serves as a sword to cut down opponents. In a dire situation, the stalk can also serve as food.', 18, 0.65, 4), 
('doduo', 14, 392, 'Its short wings make flying difficult. Instead, this Pokémon runs at high speed on developed legs.', 18, 0.6, 4), 
('dodrio', 18, 852, 'One of Doduo’s two heads splits to form a unique species. It runs close to 40 mph in prairies.', 18, 0.5, 4), 
('seel', 11, 900, 'Loves freezing-cold conditions. Relishes swimming in a frigid climate of around 14 degrees Fahrenheit.', 2, 0.6, null), 
('dewgong', 17, 1200, 'Its entire body is a snowy white. Unharmed by even intense cold, it swims powerfully in icy waters.', 2, 0.5, 11), 
('grimer', 9, 300, 'Made of congealed sludge. It smells too putrid to touch. Even weeds won’t grow in its path.', 6, 0.6, null), 
('muk', 12, 300, 'Smells so awful, it can cause fainting. Through degeneration of its nose, it lost its sense of smell.', 6, 0.5, null), 
('shellder', 3, 40, 'It swims facing backward by opening and closing its two-piece shell. It is surprisingly fast.', 2, 0.6, null), 
('cloyster', 15, 1325, 'Its shell is extremely hard. It cannot be shattered, even with a bomb. The shell opens only when it is attacking.', 2, 0.5, 11), 
('gastly', 13, 1, 'Born from gases, anyone would faint if engulfed by its gaseous body, which contains poison.', 13, 0.75, 6), 
('haunter', 16, 1, 'Its tongue is made of gas. If licked, its victim starts shaking constantly until death eventually comes.', 13, 0.55, 6), 
('gengar', 15, 405, 'On the night of a full moon, if shadows move on their own and laugh, it must be Gengar’s doing.', 13, 0.45, 6), 
('onix', 88, 2100, 'As it digs through the ground, it absorbs many hard objects. This is what makes its body so solid.', 9, 0.65, 8), 
('drowzee', 10, 324, 'If you sleep by it all the time, it will sometimes show you dreams it had eaten in the past.', 10, 0.6, null), 
('hypno', 16, 756, 'Avoid eye contact if you come across one. It will try to put you to sleep by using its pendulum.', 10, 0.5, null), 
('krabby', 4, 65, 'It can be found near the sea. The large pincers grow back if they are torn out of their sockets.', 2, 0.6, null), 
('kingler', 13, 600, 'Its large and hard pincer has 10,000-horsepower strength. However, being so big, it is unwieldy to move.', 2, 0.5, null), 
('voltorb', 5, 104, 'It is said to camouflage itself as a Poké Ball. It will self-destruct with very little stimulus.', 7, 0.6, null), 
('electrode', 12, 666, 'Stores electrical energy inside its body. Even the slightest shock could trigger a huge explosion.', 7, 0.5, null), 
('exeggcute', 4, 25, 'Though it may look like it’s just a bunch of eggs, it’s a proper Pokémon. Exeggcute communicates with others of its kind via telepathy, apparently.', 3, 0.6, 10), 
('exeggutor', 20, 1200, 'Each of Exeggutor’s three heads is thinking different thoughts. The three don’t seem to be very interested in one another.', 3, 0.5, 10), 
('cubone', 4, 65, 'When the memory of its departed mother brings it to tears, its cries echo mournfully within the skull it wears on its head.', 8, 0.6, null), 
('marowak', 10, 450, 'This Pokémon overcame its sorrow to evolve a sturdy new body. Marowak faces its opponents bravely, using a bone as a weapon.', 8, 0.5, null), 
('hitmonlee', 15, 498, 'This amazing Pokémon has an awesome sense of balance. It can kick in succession from any position.', 5, 0.65, null), 
('hitmonchan', 14, 502, 'Its punches slice the air. They are launched at such high speed, even a slight graze could cause a burn.', 5, 0.65, null), 
('lickitung', 12, 655, 'If this Pokémon’s sticky saliva gets on you and you don’t clean it off, an intense itch will set in. The itch won’t go away, either.', 18, 0.65, null), 
('koffing', 6, 10, 'Its body is full of poisonous gas. It floats into garbage dumps, seeking out the fumes of raw, rotting trash.', 6, 0.6, null), 
('weezing', 12, 95, 'It mixes gases between its two bodies. It’s said that these Pokémon were seen all over the Galar region back in the day.', 6, 0.6, null), 
('rhyhorn', 10, 1150, 'Strong, but not too bright, this Pokémon can shatter even a skyscraper with its charging tackles.', 8, 0.6, 9), 
('rhydon', 19, 1200, 'It begins walking on its hind legs after evolution. It can punch holes through boulders with its horn.', 8, 0.5, 9), 
('chansey', 11, 346, 'The egg Chansey carries is not only delicious but also packed with nutrition. It’s used as a high-class cooking ingredient.', 18, 0.65, null), 
('tangela', 10, 350, 'Hidden beneath a tangle of vines that grows nonstop even if the vines are torn off, this Pokémon’s true appearance remains a mystery.', 3, 0.65, null), 
('kangaskhan', 22, 800, 'Although it’s carrying its baby in a pouch on its belly, Kangaskhan is swift on its feet. It intimidates its opponents with quick jabs.', 18, 0.65, null), 
('horsea', 4, 80, 'Horsea makes its home in oceans with gentle currents. If this Pokémon is under attack, it spits out pitch-black ink and escapes.', 2, 0.6, null), 
('seadra', 12, 250, 'It’s the males that raise the offspring. While Seadra are raising young, the spines on their backs secrete thicker and stronger poison.', 2, 0.5, null), 
('goldeen', 6, 150, 'Its dorsal, pectoral, and tail fins wave elegantly in water. That is why it is known as the Water Dancer.', 2, 0.6, null), 
('seaking', 13, 390, 'In autumn, its body becomes more fatty in preparing to propose to a mate. It takes on beautiful colors.', 2, 0.5, null), 
('staryu', 8, 345, 'If you visit a beach at the end of summer, you’ll be able to see groups of Staryu lighting up in a steady rhythm.', 2, 0.6, null), 
('starmie', 11, 800, 'This Pokémon has an organ known as its core. The organ glows in seven colors when Starmie is unleashing its potent psychic powers.', 2, 0.5, 10), 
('mr-mime', 13, 545, 'The broadness of its hands may be no coincidence—many scientists believe its palms became enlarged specifically for pantomiming.', 10, 0.65, 17), 
('scyther', 15, 560, 'As Scyther fights more and more battles, its scythes become sharper and sharper. With a single slice, Scyther can fell a massive tree.', 12, 0.65, 4), 
('jynx', 14, 406, 'In certain parts of Galar, Jynx was once feared and worshiped as the Queen of Ice.', 11, 0.65, 10), 
('electabuzz', 11, 300, 'Many power plants keep Ground-type Pokémon around as a defense against Electabuzz that come seeking electricity.', 7, 0.65, null), 
('magmar', 13, 445, 'Magmar dispatches its prey with fire. But it regrets this habit once it realizes that it has burned its intended prey to a charred crisp.', 1, 0.65, null), 
('pinsir', 15, 550, 'These Pokémon judge one another based on pincers. Thicker, more impressive pincers make for more popularity with the opposite gender.', 12, 0.65, null), 
('tauros', 14, 884, 'When Tauros begins whipping itself with its tails, it’s a warning that the Pokémon is about to charge with astounding speed.', 18, 0.65, null), 
('magikarp', 9, 100, 'It is virtually worthless in terms of both power and speed. It is the most weak and pathetic Pokémon in the world.', 2, 0.6, null), 
('gyarados', 65, 2350, 'It has an extremely aggressive nature. The Hyper Beam it shoots from its mouth totally incinerates all targets.', 2, 0.5, 4), 
('lapras', 25, 2200, 'A smart and kindhearted Pokémon, it glides across the surface of the sea while its beautiful song echoes around it.', 2, 0.65, 11), 
('ditto', 3, 40, 'It can reconstitute its entire cellular structure to change into what it sees, but it returns to normal when it relaxes.', 18, 0.65, null), 
('eevee', 3, 65, 'It has the ability to alter the composition of its body to suit its surrounding environment.', 18, 0.6, null), 
('vaporeon', 10, 290, 'When Vaporeon’s fins begin to vibrate, it is a sign that rain will come within a few hours.', 2, 0.5, null), 
('jolteon', 8, 245, 'If it is angered or startled, the fur all over its body bristles like sharp needles that pierce foes.', 7, 0.5, null), 
('flareon', 9, 250, 'Once it has stored up enough heat, this Pokémon’s body temperature can reach up to 1,700 degrees Fahrenheit.', 1, 0.5, null), 
('porygon', 8, 365, 'State-of-the-art technology was used to create Porygon. It was the first artificial Pokémon to be created via computer programming.', 18, 0.65, null), 
('omanyte', 4, 75, 'Because some Omanyte manage to escape after being restored or are released into the wild by people, this species is becoming a problem.', 9, 0.6, 2), 
('omastar', 10, 350, 'Weighed down by a large and heavy shell, Omastar couldn’t move very fast. Some say it went extinct because it was unable to catch food.', 9, 0.5, 2), 
('kabuto', 5, 115, 'This species is almost entirely extinct. Kabuto molt every three days, making their shells harder and harder.', 9, 0.6, 2), 
('kabutops', 13, 405, 'Kabutops slices its prey apart and sucks out the fluids. The discarded body parts become food for other Pokémon.', 9, 0.6, 2), 
('aerodactyl', 18, 590, 'This is a ferocious Pokémon from ancient times. Apparently even modern technology is incapable of producing a perfectly restored specimen.', 9, 0.65, 4), 
('snorlax', 21, 4600, 'It is not satisfied unless it eats over 880 pounds of food every day. When it is done eating, it goes promptly to sleep.', 18, 0.65, null), 
('articuno', 17, 554, 'It’s said that this Pokémon’s beautiful blue wings are made of ice. Articuno flies over snowy mountains, its long tail fluttering along behind it.', 11, 0.05, 4), 
('zapdos', 16, 526, 'This Pokémon has complete control over electricity. There are tales of Zapdos nesting in the dark depths of pitch-black thunderclouds.', 7, 0.05, 4), 
('moltres', 20, 600, 'It’s one of the legendary bird Pokémon. When Moltres flaps its flaming wings, they glimmer with a dazzling red glow.', 1, 0.05, 4), 
('dratini', 18, 33, 'Dratini dwells near bodies of rapidly flowing water, such as the plunge pools of waterfalls. As it grows, Dratini will shed its skin many times.', 15, 0.75, null), 
('dragonair', 40, 165, 'This Pokémon lives in pristine oceans and lakes. It can control the weather, and it uses this power to fly into the sky, riding on the wind.', 15, 0.55, null), 
('dragonite', 22, 2100, 'It’s a kindhearted Pokémon. If it spots a drowning person or Pokémon, Dragonite simply must help them.', 15, 0.45, 4), 
('mewtwo', 20, 1220, 'Its DNA is almost the same as Mew’s. However, its size and disposition are vastly different.', 10, 0.05, null), 
('mew', 4, 40, 'When viewed through a microscope, this Pokémon’s short, fine, delicate hair can be seen.', 10, 0.05, null);

-- Instancias
INSERT INTO instancia_pokemon (id_pokemon, experiencia, genero) VALUES  
  (1, 50, 'M')
, (43, 50, 'F')
, (4, 50, 'M')
, (7, 50, 'F')
, (74, 50, 'F')
, (29, 50, 'F')
, (32, 50, 'M')
, (147, 50, 'F')
, (150, 500, null)
, (151, 500, null);

-- INSERT group 3: ESPECIALIZAÇÃO DO ITEM, CANDY, BERRY, POKEBOLA, EVOSTONE E INSTÂNCIA ITEM

INSERT INTO especializacao_do_item (papel) VALUES
  ('candy')
, ('candy')
, ('candy')
, ('candy')
, ('berry')
, ('berry')
, ('berry')
, ('berry')
, ('berry')
, ('evostone')
, ('evostone')
, ('evostone')
, ('evostone')
, ('evostone')
, ('evostone')
, ('evostone')
, ('evostone')
, ('evostone')
, ('evostone')
, ('pokebola')
, ('pokebola')
, ('pokebola')
, ('pokebola');

INSERT INTO candy (id, nome, preco, aumento_experiencia) VALUES
  (1, 'Picante', 1, 3)
, (2, 'Seco', 2, 5)
, (3, 'Doce', 5, 10)
, (4, 'Amargo', 3, 6);

INSERT INTO berry (id, nome, preco, aumento_taxa_captura) VALUES
  (5, 'Morango', 4, 1)
, (6, 'Amora', 2, 0.5)
, (7, 'Blueberry', 5, 0.33)
, (8, 'Banana', 2, 0.52);

INSERT INTO evostone (id, nome, preco, id_elemento) VALUES
  (10, 'Down', 5, 16)
, (11, 'Water', 5, 2)
, (12, 'Dusk', 5, 15)
, (13, 'Fire', 5, 1)
, (14, 'Ice', 5, 1)
, (15, 'Leaf', 5, 3)
, (16, 'Moon', 5, 13)
, (17, 'Shiny', 5, 17)
, (18, 'Sun', 5, 7)
, (19, 'Storm', 5, 12);

INSERT INTO pokebola (id, nome, preco) VALUES
  (20, 'Pokeball', 2)
, (21, 'Great Ball', 5)
, (22, 'Ultra Ball', 10)
, (23, 'Master Ball', 20);

INSERT INTO instancia_item (id_item) VALUES
  (1)
, (5)
, (5)
, (10)
-- Items para Vendedores e treinador
, (20), (20), (20) -- Treinador
, (20), (20), (20), (20), (20), (20), (20), (20), (20), (20), (21), (21), (21), (21), (22) -- Vendedor June pokebolas
, (16), (18) -- Evos
, (20), (21), (21), (21), (21), (21), (21), (21), (21), (21), (22), (22), (22), (22), (23) --Vendedor May pokebolas
, (11), (13), (14), (15) -- Evos
-- Itens no chão
, (20) -- Pokebola
, (14) -- EvoStone Ice
, (5) -- Berry Morango
, (1) -- Candy Picante
, (3) -- Candy Doce
, (23); -- Master Ball

-- Evoluções
INSERT INTO pokemon_evolucao (pokemon_id, evolucao_id, experiencia_evoluir) VALUES  (1, 2, 100), (2, 3, 100), (4, 5, 100), (5, 6, 100), (7, 8, 100), (8, 9, 100), (10, 11, 100), (11, 12, 100), (13, 14, 100), (14, 15, 100), (16, 17, 100), (17, 18, 100), (19, 20, 100), (21, 22, 100), (23, 24, 100), (25, 26, 100), (27, 28, 100), (29, 30, 100), (30, 31, 100), (32, 33, 100), (33, 34, 100), (35, 36, 100), (37, 38, 100), (39, 40, 100), (41, 42, 100), (43, 44, 100), (44, 45, 100), (46, 47, 100), (48, 49, 100), (50, 51, 100), (52, 53, 100), (54, 55, 100), (57, 58, 100), (58, 59, 100), (60, 61, 100), (61, 62, 100), (63, 64, 100), (64, 65, 100), (66, 67, 100), (67, 68, 100), (69, 70, 100), (70, 71, 100), (72, 73, 100), (74, 75, 100), (75, 76, 100), (77, 78, 100), (79, 80, 100), (81, 82, 100), (84, 85, 100), (86, 87, 100), (88, 89, 100), (90, 91, 100), (92, 93, 100), (93, 94, 100), (95, 96, 100), (98, 99, 100), (100, 101, 100), (102, 103, 100), (104, 105, 100), (109, 110, 100), (111, 112, 100), (116, 117, 100), (118, 119, 100), (120, 121, 100), (129, 130, 100), (133, 134, 100), (133, 135, 100), (133, 136, 100), (138, 139, 100), (140, 141, 100), (147, 148, 100), (148, 149, 100);

UPDATE pokemon_evolucao SET necessita_de_item = true where pokemon_id = 25 or  pokemon_id = 37 or  pokemon_id = 25 or  pokemon_id = 29 or  pokemon_id = 44 or  pokemon_id = 58 or  pokemon_id = 61 or  pokemon_id = 70 or  pokemon_id = 133;

INSERT INTO pokemon_evolucao_item (pokemon_id, evolucao_id, item_id) VALUES (25, 26, 19), (37, 38, 13), (35, 36, 16), (39, 40, 16), (44, 45, 15), (58, 59, 13), (61, 62, 11), (70, 71, 15), (133, 134, 11), (133, 135, 19), (133, 136, 13);


-- Guardar items NPC e Mochila
-- Mochila
INSERT INTO mochila_guarda_instancia_de_item VALUES ('Ash Ketchum', 5), ('Ash Ketchum', 6), ('Ash Ketchum', 7);

-- NPCs
INSERT INTO npc_guarda_instancia_de_item VALUES (3, 8), (3, 9), (3, 10), (3, 11), (3, 12), (3, 13), (3, 14), (3, 15), (3, 16), (3, 17), (3, 18), (3, 19), (3, 20), (3, 21), (3, 22), (3, 23), (3, 24), 
(6, 25), (6, 26), (6, 27), (6, 28), (6, 29), (6, 30), (6, 31), (6, 32), (6, 33), (6, 34), (6, 35), (6, 36), (6, 37), (6, 38), (6, 39), (6, 40), (6, 41), (6, 42), (6, 43), (6, 47), (6, 48);

-- INSERT group 6: INSTANCIA ITEM POSICAO e INSTANCIA POKEMON POSICAO

INSERT INTO instancia_item_posicao (id_posicao, id_instancia_item) VALUES
  (10, 44)
, (18, 45)
, (24, 46)
, (36, 47)
, (39, 48)
, (45, 49);

INSERT INTO instancia_pokemon_posicao (id_posicao, id_instancia_pokemon) VALUES
  (11, 1)
, (13, 2)
, (19, 3)
, (29, 4)
, (31, 5)
, (35, 6)
, (37, 7)
, (38, 8)
, (40, 9)
, (41, 10)
;

-- INSERT group 7: REGISTRA, VENDE, CAPTURA, EVENT0_CAPTURA

INSERT INTO registra (id_pokemon, id_pokedex, qtd_vista, qtd_capturada) VALUES
(1, 'Ash Ketchum', 1, 0),
(2, 'Ash Ketchum', 1, 1),
(3, 'Ash Ketchum', 1, 1),
(4, 'Ash Ketchum', 1, 0),
(5, 'Ash Ketchum', 1, 1),
(6, 'Ash Ketchum', 1, 0),
(7, 'Ash Ketchum', 1, 0),
(8, 'Ash Ketchum', 1, 0),
(9, 'Ash Ketchum', 1, 0),
(10, 'Ash Ketchum', 1, 0);

-- INSERT INTO vende (treinador, id_instancia_item, id_npc) VALUES
-- Comprou duas pokebolas e uma great ball do vendedor June
-- ('Ash Ketchum', 8, 3), ('Ash Ketchum', 9, 3), ('Ash Ketchum', 18, 3);

INSERT INTO captura (id_instancia_pokemon, id_treinador) VALUES (3, 'Ash Ketchum'), (2, 'Ash Ketchum'), (5, 'Ash Ketchum');

INSERT INTO evento_captura (id_instancia_pokemon, id_pokebola) VALUES (3, 20), (2, 20), (5, 20);
