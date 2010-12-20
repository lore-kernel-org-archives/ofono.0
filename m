Content-Type: multipart/mixed; boundary="===============5719736059303576817=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [PATCH 0/4] Emergency Calls
Date: Mon, 20 Dec 2010 15:21:40 +0200
Message-ID: <cover.1292849833.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5719736059303576817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Steps in handling emergency calls:
- subscribe to modem online notifications
- emergency call detected (phone number is an emergency number)
- increment emergency mode =

  - advertise "Emergency" property change on D-Bus (first call)
  - set modem online (minimal setup) if mode was offline
    - adevertise "Online" property change on D-Bus
- if modem is not online postpone making the call, otherwise make
  the emergency call
- when modem online notification comes and there is postponed emergency call
  request, make the emergency call
- when an emergency call ends decrement emergency mode
  - set modem to pre emergency call state (last call)
    - advertise "Online" property change on D-Bus (if any)
  - advertise "Emergency" property change on D-Bus (last call)

Andras Domokos (3):
  modem: add Emergency property
  modem: move dial request_cb function
  voicecall: add emergency call handling

 src/dbus.c      |    7 ++
 src/modem.c     |  207 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/ofono.h     |    5 ++
 src/voicecall.c |  186 ++++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 369 insertions(+), 36 deletions(-)


--===============5719736059303576817==--

