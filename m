Content-Type: multipart/mixed; boundary="===============6015287217318625244=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: DUN Client implementation
Date: Tue, 09 Nov 2010 02:42:53 -0200
Message-ID: <1289277781-6378-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6015287217318625244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Here follows my current implementation for the Bluetooth Dial-up Profile
in oFono. It is still partially working, it is stopping at some point in
the PPP negotiation. I haven't found time to debug this lately so I'm
posting all the code I have here then others can look, make comments,
help the development, etc.

To run it just enable the dunmodem and them activate the context. The
log from my ofnod stops in the PPP phase 1:


ofonod[1548]: src/gprs.c:gprs_attach_callback() /dun/001A6BF7A10E_000AD97C7=
140 error =3D 0
ofonod[1548]: src/gprs.c:registration_status_cb() /dun/001A6BF7A10E_000AD97=
C7140 error 0 status 1
ofonod[1548]: src/gprs.c:ofono_gprs_status_notify() /dun/001A6BF7A10E_000AD=
97C7140 status 1
ofonod[1548]: > AT+CGDCONT=3D2,"IP",""\r
ofonod[1548]: < AT+CGDCONT=3D2,"IP",""\r
ofonod[1548]: < \r\nOK\r\n
ofonod[1548]: > AT+CGDATA=3D"PPP",2\r
ofonod[1548]: < AT+CGDATA=3D"PPP",2\r
ofonod[1548]: < \r\nCONNECT\r\n
Entering new phase: 1


Gustavo F. Padovan (8):
  Bluetooth DUN modem prototype
  Add dun_enable() function
  Add dun_disable() to power down the modem
  dun: Add GAtChat for the rfcomm device
  dun: add network registration atom
  Add gprs-context to DUN
  gprs: Prevent crash due to a NULL pid_map
  Add gprs drivers for dunmodem

 Makefile.am                             |    9 +
 drivers/dunmodem/dunmodem.c             |   56 +++++
 drivers/dunmodem/dunmodem.h             |   36 +++
 drivers/dunmodem/gprs.c                 |  110 +++++++++
 drivers/dunmodem/network-registration.c |   91 ++++++++
 plugins/bluetooth.c                     |   11 +
 plugins/bluetooth.h                     |    3 +
 plugins/dun.c                           |  379 +++++++++++++++++++++++++++=
++++
 src/gprs.c                              |    8 +-
 9 files changed, 699 insertions(+), 4 deletions(-)
 create mode 100644 drivers/dunmodem/dunmodem.c
 create mode 100644 drivers/dunmodem/dunmodem.h
 create mode 100644 drivers/dunmodem/gprs.c
 create mode 100644 drivers/dunmodem/network-registration.c
 create mode 100644 plugins/dun.c

-- =

1.7.3


--===============6015287217318625244==--

