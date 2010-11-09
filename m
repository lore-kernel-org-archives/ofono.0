Content-Type: multipart/mixed; boundary="===============2249610103655238447=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: [PATCH 0/3] Emergency Calls (2nd round)
Date: Tue, 09 Nov 2010 10:56:54 +0200
Message-ID: <cover.1289226246.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2249610103655238447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andras Domokos <Andras.Domokos@nokia.com>

Here is a new proposal for emergency calls handling.

Steps in handling emergency calls:
- subscribe to modem online notifications (add modem online watcher)
- an emergency call detected (phone number is emergency number)
- increment emergency mode
  - switch modem online if not in online mode
  - advertise "EmergencyMode" property change on D-Bus (for first call)
- if modem is not online postpone making the call, otherwise make
  de emergency call
- when modem online notification comes and there is postponed call request
  make the emergency call
- when an emergency call ends decrement emergency mode
  - advertise "EmergencyMode" property change on D-Bus (for last call)

Note: modem remains online even if it was offline before starting the =

emergency call

Andras Domokos (3):
  modem: add modem online-offline watch
  modem: add EmergencyMode property
  voicecall: add emergency call handling

 src/modem.c     |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 src/ofono.h     |   12 ++++++
 src/voicecall.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 3 files changed, 211 insertions(+), 1 deletions(-)


--===============2249610103655238447==--

