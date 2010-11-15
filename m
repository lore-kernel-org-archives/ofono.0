Content-Type: multipart/mixed; boundary="===============6701676530438119428=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [PATCH 0/4] Emergency Calls (4th round)
Date: Mon, 15 Nov 2010 18:57:53 +0200
Message-ID: <cover.1289838927.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6701676530438119428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is a new proposal for emergency calls handling.

Steps in handling emergency calls:
- subscribe to modem online notifications (add modem online watcher)
- an emergency call detected (phone number is emergency number)
- increment emergency mode
  - advertise "EmergencyMode" property change on D-Bus (first call)
  - set modem online if it's in offline mode (minimal setup)
    - adevertise "Online" property change on D-Bus
- if modem is not online postpone making the call, otherwise make
  the emergency call
- when modem online notification comes and there is postponed call request
  make the emergency call
- when an emergency call ends decrement emergency mode
  - set modem offline if it was set online due to the emergency call (last =
call)
    - advertise "Online" property change on D-Bus
  - advertise "EmergencyMode" property change on D-Bus (last call)
 =

Note: emergency calls with SIM card (network registered or unregistered) and
without SIM card are supported.

Andras Domokos (4):
  modem: add modem online-offline watch
  modem: add EmergencyMode property
  modem: move dial_request_cb function
  voicecall: add emergency call handling

 src/modem.c     |  180 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h     |   12 ++++
 src/voicecall.c |  175 +++++++++++++++++++++++++++++++++++++++++++--------=
--
 3 files changed, 334 insertions(+), 33 deletions(-)


--===============6701676530438119428==--

