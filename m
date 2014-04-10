Content-Type: multipart/mixed; boundary="===============6240660640150270267=="
MIME-Version: 1.0
From: Homam Dabis <hdabis@digisoft.tv>
Subject: Remote dbus commands (AccessDenied)
Date: Thu, 10 Apr 2014 12:57:08 +0100
Message-ID: <CAK+sfovbsPNC6OunUPkeS-djuCi=9Gox2WoSsp8GtRZwvsX2AQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6240660640150270267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am trying to run dbus commands remotely. On the remote machine I have
edited system.conf to listen on port 55556.

I can run connmand dbus commands remotely.

I have edited list-modems to the following:

bus=3Ddbus.bus.BusConnection("tcp:host=3D10.42.243.96,port=3D55556")

I get the following when I run the script:

ERROR:dbus.proxies:Introspect error on :1.1:/:
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.AccessDenied:
Rejected send message, 2 matched rules; type=3D"method_call", sender=3D":1.=
7"
(pid=3D0 comm=3D"") interface=3D"org.freedesktop.DBus.Introspectable"
member=3D"Introspect" error name=3D"(unset)" requested_reply=3D"0"
destination=3D":1.1" (uid=3D0 pid=3D4352 comm=3D"ofonod ")
Traceback (most recent call last):
  File "./list-modems", line 11, in <module>
    modems =3D manager.GetModems()
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in
__call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in
__call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651, in
call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.AccessDenied:
Rejected send message, 2 matched rules; type=3D"method_call", sender=3D":1.=
7"
(pid=3D0 comm=3D"") interface=3D"org.ofono.Manager" member=3D"GetModems" er=
ror
name=3D"(unset)" requested_reply=3D"0" destination=3D":1.1" (uid=3D0 pid=3D=
4352
comm=3D"ofonod ")


Any suggestions as to what is happening?

Thanks

Homam

--===============6240660640150270267==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SSBhbSB0cnlpbmcgdG8gcnVuIGRidXMgY29tbWFuZHMgcmVtb3RlbHku
IE9uIHRoZSByZW1vdGUgbWFjaGluZSBJIGhhdmUgZWRpdGVkIHN5c3RlbS5jb25mIHRvIGxpc3Rl
biBvbiBwb3J0IDU1NTU2LjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBjYW4gcnVuIGNvbm5tYW5kIGRi
dXMgY29tbWFuZHMgcmVtb3RlbHkuPGJyPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIGVkaXRl
ZCBsaXN0LW1vZGVtcyB0byB0aGUgZm9sbG93aW5nOjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2
PmJ1cz1kYnVzLmJ1cy5CdXNDb25uZWN0aW9uKCZxdW90O3RjcDpob3N0PTEwLjQyLjI0My45Nixw
b3J0PTU1NTU2JnF1b3Q7KTxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgZ2V0IHRoZSBm
b2xsb3dpbmcgd2hlbiBJIHJ1biB0aGUgc2NyaXB0OjwvZGl2PjxkaXY+wqA8YnIgY2xlYXI9ImFs
bCI+PGRpdj48ZGl2PkVSUk9SOmRidXMucHJveGllczpJbnRyb3NwZWN0IGVycm9yIG9uIDoxLjE6
LzogZGJ1cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb246IG9yZy5mcmVlZGVza3RvcC5EQnVzLkVy
cm9yLkFjY2Vzc0RlbmllZDogUmVqZWN0ZWQgc2VuZCBtZXNzYWdlLCAyIG1hdGNoZWQgcnVsZXM7
IHR5cGU9JnF1b3Q7bWV0aG9kX2NhbGwmcXVvdDssIHNlbmRlcj0mcXVvdDs6MS43JnF1b3Q7IChw
aWQ9MCBjb21tPSZxdW90OyZxdW90OykgaW50ZXJmYWNlPSZxdW90O29yZy5mcmVlZGVza3RvcC5E
QnVzLkludHJvc3BlY3RhYmxlJnF1b3Q7IG1lbWJlcj0mcXVvdDtJbnRyb3NwZWN0JnF1b3Q7IGVy
cm9yIG5hbWU9JnF1b3Q7KHVuc2V0KSZxdW90OyByZXF1ZXN0ZWRfcmVwbHk9JnF1b3Q7MCZxdW90
OyBkZXN0aW5hdGlvbj0mcXVvdDs6MS4xJnF1b3Q7ICh1aWQ9MCBwaWQ9NDM1MiBjb21tPSZxdW90
O29mb25vZCAmcXVvdDspPC9kaXY+CjxkaXY+VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOjwvZGl2PjxkaXY+wqAgRmlsZSAmcXVvdDsuL2xpc3QtbW9kZW1zJnF1b3Q7LCBsaW5lIDEx
LCBpbiAmbHQ7bW9kdWxlJmd0OzwvZGl2PjxkaXY+wqAgwqAgbW9kZW1zID0gbWFuYWdlci5HZXRN
b2RlbXMoKTwvZGl2PjxkaXY+wqAgRmlsZSAmcXVvdDsvdXNyL2xpYi9weXRob24yLjcvZGlzdC1w
YWNrYWdlcy9kYnVzL3Byb3hpZXMucHkmcXVvdDssIGxpbmUgNzAsIGluIF9fY2FsbF9fPC9kaXY+
CjxkaXY+wqAgwqAgcmV0dXJuIHNlbGYuX3Byb3h5X21ldGhvZCgqYXJncywgKiprZXl3b3Jkcyk8
L2Rpdj48ZGl2PsKgIEZpbGUgJnF1b3Q7L3Vzci9saWIvcHl0aG9uMi43L2Rpc3QtcGFja2FnZXMv
ZGJ1cy9wcm94aWVzLnB5JnF1b3Q7LCBsaW5lIDE0NSwgaW4gX19jYWxsX188L2Rpdj48ZGl2PsKg
IMKgICoqa2V5d29yZHMpPC9kaXY+PGRpdj7CoCBGaWxlICZxdW90Oy91c3IvbGliL3B5dGhvbjIu
Ny9kaXN0LXBhY2thZ2VzL2RidXMvY29ubmVjdGlvbi5weSZxdW90OywgbGluZSA2NTEsIGluIGNh
bGxfYmxvY2tpbmc8L2Rpdj4KPGRpdj7CoCDCoCBtZXNzYWdlLCB0aW1lb3V0KTwvZGl2PjxkaXY+
ZGJ1cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb246IG9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9y
LkFjY2Vzc0RlbmllZDogUmVqZWN0ZWQgc2VuZCBtZXNzYWdlLCAyIG1hdGNoZWQgcnVsZXM7IHR5
cGU9JnF1b3Q7bWV0aG9kX2NhbGwmcXVvdDssIHNlbmRlcj0mcXVvdDs6MS43JnF1b3Q7IChwaWQ9
MCBjb21tPSZxdW90OyZxdW90OykgaW50ZXJmYWNlPSZxdW90O29yZy5vZm9uby5NYW5hZ2VyJnF1
b3Q7IG1lbWJlcj0mcXVvdDtHZXRNb2RlbXMmcXVvdDsgZXJyb3IgbmFtZT0mcXVvdDsodW5zZXQp
JnF1b3Q7IHJlcXVlc3RlZF9yZXBseT0mcXVvdDswJnF1b3Q7IGRlc3RpbmF0aW9uPSZxdW90Ozox
LjEmcXVvdDsgKHVpZD0wIHBpZD00MzUyIGNvbW09JnF1b3Q7b2Zvbm9kICZxdW90Oyk8L2Rpdj4K
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXY+QW55IHN1Z2dlc3Rp
b25zIGFzIHRvIHdoYXQgaXMgaGFwcGVuaW5nPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhh
bmtzPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ib21hbTwvZGl2PjwvZGl2Pgo8L2Rpdj48L2Rp
dj48L2Rpdj4K

--===============6240660640150270267==--

