HOST=$1

BASE_PORT=6090
LOCAL_PORT=6090
 
LAST_DISPLAY=$(ssh $HOST ls /tmp/.X11-unix/ | sort -V | tail -n 1 | cut -c 2-)
REMOTE_DISPLAY=$(($LAST_DISPLAY + 1))
REMOTE_PORT=$(($BASE_PORT + $REMOTE_DISPLAY))
 
echo $LAST_DISPLAY  $REMOTE_DISPLAY
echo "Will create new display :$REMOTE_DISPLAY. To use on the remote, execute the following:"
echo "export DISPLAY=:$REMOTE_DISPLAY"
 
ssh -L 6080:localhost:$BASE_PORT $HOST