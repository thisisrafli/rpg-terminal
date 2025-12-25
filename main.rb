# =========================
# RPG TERMINAL GAME - RUBY
# =========================

class Character
  attr_accessor :name, :hp, :attack, :defense

  def initialize(name, hp, attack, defense)
    @name = name
    @hp = hp
    @attack = attack
    @defense = defense
  end

  def alive?
    @hp > 0
  end

  def take_damage(damage)
    actual_damage = [damage - @defense, 0].max
    @hp -= actual_damage
    actual_damage
  end
end

class Player < Character
  attr_accessor :potion

  def initialize(name)
    super(name, 100, 20, 5)
    @potion = 3
  end

  def heal
    if @potion > 0
      @hp += 30
      @hp = 100 if @hp > 100
      @potion -= 1
      puts "🧪 Kamu minum potion (+30 HP)"
    else
      puts "❌ Potion habis!"
    end
  end
end

class Monster < Character
  def initialize
    super("Goblin", 80, 15, 3)
  end
end

# =========================
# GAME START
# =========================

puts "⚔️ SELAMAT DATANG DI RPG TERMINAL ⚔️"
print "Masukkan nama hero kamu: "
player_name = gets.chomp

player = Player.new(player_name)
monster = Monster.new

puts "\n🔥 Seekor #{monster.name} muncul!\n"

while player.alive? && monster.alive?
  puts "\n======================"
  puts "#{player.name} HP: #{player.hp} | Potion: #{player.potion}"
  puts "#{monster.name} HP: #{monster.hp}"
  puts "======================"

  puts "\nPilih aksi:"
  puts "1. ⚔️ Attack"
  puts "2. 🧪 Heal"
  puts "3. 🏃 Kabur"
  print "> "
  choice = gets.to_i

  case choice
  when 1
    damage = monster.take_damage(player.attack)
    puts "⚔️ Kamu menyerang #{monster.name} dan memberi #{damage} damage!"
  when 2
    player.heal
  when 3
    puts "🏃 Kamu kabur dari pertarungan!"
    exit
  else
    puts "❌ Pilihan tidak valid!"
    next
  end

  # Monster turn
  if monster.alive?
    damage = player.take_damage(monster.attack)
    puts "💀 #{monster.name} menyerang balik dan memberi #{damage} damage!"
  end
end

# =========================
# GAME RESULT
# =========================

if player.alive?
  puts "\n🎉 SELAMAT! Kamu mengalahkan #{monster.name}!"
else
  puts "\n☠️ Kamu kalah... Game Over."
end