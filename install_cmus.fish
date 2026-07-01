#!/usr/bin/env fish
# Script de instalación para Cmus (Reproductor Legacy) y Last.fm

echo "🎵 Iniciando la instalación de Cmus..."

# 1. Detectar el instalador AUR
if type -q paru
    set AUR_HELPER paru
else if type -q yay
    set AUR_HELPER yay
else
    echo "❌ No se encontró paru ni yay. Instala uno primero."
    exit 1
end

echo "📦 Instalando cmus y cmusfm..."
$AUR_HELPER -S --needed cmus cmusfm

# 2. Restaurar configuraciones desde el repositorio
echo "📁 Restaurando configuraciones desde el repositorio..."
set DOTFILES_DIR (dirname (status --current-filename))/.config
mkdir -p ~/.config/cmus

if test -d $DOTFILES_DIR/cmus
    cp -r $DOTFILES_DIR/cmus/* ~/.config/cmus/ 2>/dev/null
    echo "✅ Configuraciones y listas de reproducción restauradas."
else
    echo "⚠️  No se encontró la carpeta de configuraciones de cmus en $DOTFILES_DIR."
end

# 3. Instrucciones finales
echo ""
echo "✅ ¡Instalación completada!"
echo ""
echo "⚠️  IMPORTANTE SOBRE LAST.FM:"
echo "Por motivos de seguridad, tu token de sesión no se guarda en el repositorio."
echo "Para volver a conectar cmus con Last.fm, debes ejecutar manualmente:"
echo ""
echo "    cmusfm init"
echo ""
echo "Esto te abrirá el navegador para que autorices la aplicación. Después de eso, ¡ya puedes abrir 'cmus'!"
