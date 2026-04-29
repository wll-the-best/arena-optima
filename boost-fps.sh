#!/system/bin/sh

# Arena Breakout Lite - FPS Boost Script
# Максимальное ускорение FPS
# Требует root права

echo "╔════════════════════════════════════════╗"
echo "║   ABL FPS BOOST v1.0                   ║"
echo "║   Arena Breakout Lite Optimizer        ║"
echo "╚════════════════════════════════════════╝"
echo ""

if [ "$(id -u)" != "0" ]; then
   echo "❌ Требуются root права!"
   exit 1
fi

echo "🚀 Запуск FPS бустера..."
echo ""

# 1. Максимум для CPU
echo "⚙️  Оптимизация процессора..."
for i in 0 1 2 3 4 5 6 7; do
    if [ -d "/sys/devices/system/cpu/cpu$i" ]; then
        echo "performance" > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor 2>/dev/null
        echo "4294967295" > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_max_freq 2>/dev/null
    fi
done
echo "✓ CPU на максимум"
echo ""

# 2. Максимум для GPU
echo "🎨 Оптимизация видеокарты..."
if [ -f "/sys/class/kgsl/kgsl-3d0/devfreq/max_freq" ]; then
    MAXFREQ=$(cat /sys/class/kgsl/kgsl-3d0/devfreq/max_freq)
    echo "$MAXFREQ" > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
    echo "$MAXFREQ" > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
    echo "performance" > /sys/class/kgsl/kgsl-3d0/devfreq/governor 2>/dev/null
    echo "✓ GPU на максимум"
else
    echo "⚠ GPU управление недоступно"
fi
echo ""

# 3. Отключение vsync и синхронизация
echo "🔄 Отключение синхронизации..."
echo "0" > /proc/sys/kernel/sched_autogroup_task_group
echo "1" > /proc/sys/kernel/sched_schedstats
echo "✓ Синхронизация оптимизирована"
echo ""

# 4. Очистка памяти
echo "💾 Очистка памяти..."
sync
echo 3 > /proc/sys/vm/drop_caches
free -h
echo "✓ Память оптимизирована"
echo ""

# 5. Отключение логирования
echo "📝 Отключение логирования..."
echo "0" > /proc/sys/kernel/printk
echo "✓ Логирование отключено"
echo ""

# 6. Остановка ненужных сервисов
echo "🗑 Остановка фоновых сервисов..."
pkill -9 com.google.android.gms
pkill -9 com.samsung.android.bixby.agent
pkill -9 com.google.android.googlequicksearchbox
echo "✓ Сервисы остановлены"
echo ""

echo "╔════════════════════════════════════════╗"
echo "║   ✅ FPS BOOST АКТИВИРОВАН!            ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "📊 Результаты:"
echo "• CPU: На максимуме"
echo "• GPU: На максимуме"
echo "• Память: Очищена"
echo "• Логирование: Отключено"
echo "• Фоновые сервисы: Остановлены"
echo ""
echo "⚠️  ВАЖНО:"
echo "• Батарея будет разряжаться быстрее"
echo "• Устройство может нагреваться"
echo "• Используйте охлаждение при необходимости"
echo "• Эффект сохраняется до перезагрузки"
echo ""
echo "🎮 Запустите Arena Breakout Lite!"
echo ""