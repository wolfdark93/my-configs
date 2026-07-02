#!/usr/bin/env fish
# Script de instalación y configuración para MPD + RMPC + Auto-DJ + Mpris + Last.fm

echo "🎵 Iniciando la instalación del ecosistema musical..."

# 1. Detectar el instalador AUR
if type -q paru
    set AUR_HELPER paru
else if type -q yay
    set AUR_HELPER yay
else
    echo "❌ No se encontró paru ni yay. Instala uno primero."
    exit 1
end

echo "📦 Instalando paquetes necesarios..."
$AUR_HELPER -S --needed mpd rmpc mpdscribble ashuffle mpd-mpris

# 2. Crear las carpetas estructurales necesarias
echo "📁 Creando carpetas de configuración..."
mkdir -p ~/.config/mpd
mkdir -p ~/Music/playlists
mkdir -p ~/.config/systemd/user/mpd.service.d
mkdir -p ~/.config/rmpc/themes
mkdir -p ~/.config/mpdscribble

# 3. Restaurar configuraciones desde el repositorio
echo "🔄 Restaurando configuraciones desde el repositorio..."
# Asumimos que el script corre desde la carpeta del repositorio y los configs están en la carpeta .config
set DOTFILES_DIR (dirname (status --current-filename))/../.config

if test -d $DOTFILES_DIR
    cp -r $DOTFILES_DIR/rmpc/* ~/.config/rmpc/ 2>/dev/null
    cp -r $DOTFILES_DIR/mpd/* ~/.config/mpd/ 2>/dev/null
    cp -r $DOTFILES_DIR/mpdscribble/* ~/.config/mpdscribble/ 2>/dev/null
    echo "✅ Archivos copiados correctamente."
else
    echo "⚠️  No se encontró la carpeta de configuraciones ($DOTFILES_DIR). Asegúrate de correr el script en el repositorio correcto."
end

# 4. Configurar Last.fm interactivamente
echo ""
echo "--- Autenticación de Last.fm ---"
read -P "Ingresa tu usuario de Last.fm (o presiona Enter para omitir): " lastfm_user
if test -n "$lastfm_user"
    read -s -P "Ingresa tu contraseña de Last.fm: " lastfm_pass
    echo ""

    set SCRIBBLE_CONF ~/.config/mpdscribble/mpdscribble.conf
    if test -f $SCRIBBLE_CONF
        sed -i "s#username = .*#username = $lastfm_user#" $SCRIBBLE_CONF
        sed -i "s#password = .*#password = $lastfm_pass#" $SCRIBBLE_CONF
        echo "✅ Credenciales inyectadas con éxito."
    else
        echo "⚠️  No se encontró $SCRIBBLE_CONF. Creando uno básico..."
        echo "host = 127.0.0.1" > $SCRIBBLE_CONF
        echo "port = 6600" >> $SCRIBBLE_CONF
        echo "log = $HOME/.config/mpdscribble/mpdscribble.log" >> $SCRIBBLE_CONF
        echo "verbose = 1" >> $SCRIBBLE_CONF
        echo "" >> $SCRIBBLE_CONF
        echo "[last.fm]" >> $SCRIBBLE_CONF
        echo "url = http://post.audioscrobbler.com/" >> $SCRIBBLE_CONF
        echo "username = $lastfm_user" >> $SCRIBBLE_CONF
        echo "password = $lastfm_pass" >> $SCRIBBLE_CONF
        echo "journal = $HOME/.config/mpdscribble/lastfm.journal" >> $SCRIBBLE_CONF
    end
else
    echo "Saltando configuración de Last.fm..."
end

# 4.5 Crear servicio para ashuffle (Auto-DJ)
echo "⚙️ Configurando servicio de ashuffle..."
set ASHUFFLE_SERVICE ~/.config/systemd/user/ashuffle.service
if not test -f $ASHUFFLE_SERVICE
    echo "[Unit]" > $ASHUFFLE_SERVICE
    echo "Description=ashuffle - Auto-DJ for MPD" >> $ASHUFFLE_SERVICE
    echo "After=mpd.service" >> $ASHUFFLE_SERVICE
    echo "" >> $ASHUFFLE_SERVICE
    echo "[Service]" >> $ASHUFFLE_SERVICE
    echo "ExecStart=/usr/bin/ashuffle --queue-buffer 1 -t play-on-startup=false" >> $ASHUFFLE_SERVICE
    echo "Restart=on-failure" >> $ASHUFFLE_SERVICE
    echo "" >> $ASHUFFLE_SERVICE
    echo "[Install]" >> $ASHUFFLE_SERVICE
    echo "WantedBy=default.target" >> $ASHUFFLE_SERVICE
end

# 5. Habilitar e iniciar los servicios en segundo plano
echo "🚀 Iniciando servicios en segundo plano..."
systemctl --user daemon-reload
systemctl --user enable --now mpd.service
systemctl --user enable --now mpd-mpris.service
systemctl --user enable --now mpdscribble.service
systemctl --user enable --now ashuffle.service

echo "✅ ¡Todo listo! Ya puedes abrir 'rmpc' y disfrutar."
