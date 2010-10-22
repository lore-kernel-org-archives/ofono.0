Content-Type: multipart/mixed; boundary="===============5918259001730317498=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Emergency Calls
Date: Fri, 22 Oct 2010 19:47:34 +0300
Message-ID: <cover.1287763218.git.andras.domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5918259001730317498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This is a proposal for handling emergency calls in ofono:

Detect when an emergency call is requested/ended and notify the interested,
subscribed parties, so that steps can be taken to ensure that the emergency
call can be established and maintained.

The "EmergencyMode" boolean property added to the VoicecallManager D-Bus
interface will reflect the emergency call situation.

There is an emergency watchlist in ofono_voicecall, where the watchers of
the interested parties are stored. When there is a change with regards to =

emergency calls (call starts/ends), the watchers in the list are notified.
One interested watcher is the modem, it has to change the modem state from
offline to online for the duration of an emergency call.

The modem has a modem state watchlist, so that interested parties can =

learn about the modem state changes. For emergency calls, voicecall manager
needs to know when the modem reached the online state, if a modem state cha=
nge
to online was necessary.

The important details are in the patches.

Cheers,
Andras

Andras Domokos (3):
  modem: modem state watch added
  voicecall: emergency call handling added
  modem: emergency state handling added

 include/voicecall.h |   12 +++
 src/modem.c         |  101 +++++++++++++++++++++---
 src/ofono.h         |   15 ++++
 src/voicecall.c     |  221 ++++++++++++++++++++++++++++++++++++++++++++++-=
---
 4 files changed, 319 insertions(+), 30 deletions(-)


--===============5918259001730317498==--

