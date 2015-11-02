Content-Type: multipart/mixed; boundary="===============3535810964080897734=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 0/5] Support multi-SIM for HFP in emulator
Date: Mon, 02 Nov 2015 18:27:15 +0100
Message-ID: <1446485240-22049-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3535810964080897734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series handles the multi-SIM case for HFP in the emulator,
for incoming calls. This means that calls can be accepted, rejected, and
hung from a headset with HFP support regardless of the modem in which
the call is received.

In case a call is initiated from the headset, we use the first SIM in
the list of modems with HFP atoms. In the future this should be handled
via a system setting.

The patches change the emulator interface to use the atom instead of the
emulator instance as token to identify which modem is sending an event.
The concept of preferred modem is introduced to route events between
headset and modems: there is a default modem that is used unless an
incoming call arrives in any modem, at that moment the modem with the
active call is the preferred modem until the call is over.

Finally, the patches have still some rough edges but I think it is worth
sharing to gather comments, regardless of whether this gets merged or
not.

Alfonso Sanchez-Beato (5):
  include: Support for multiple SIM in emulator
  emulator: Add multi-sim support
  plugins: Adapt to emulator changes
  examples: Adapt to emulator changes
  src: Adapt to emulator changes

 examples/emulator.c     |  12 ++-
 include/emulator.h      |  11 +-
 plugins/dun_gw_bluez4.c |  12 ++-
 plugins/dun_gw_bluez5.c |  12 ++-
 plugins/hfp_ag_bluez4.c |  12 ++-
 plugins/hfp_ag_bluez5.c |   8 +-
 plugins/phonesim.c      |   3 +-
 src/emulator.c          | 266 +++++++++++++++++++++++++++++++++++++++++++-=
----
 src/modem.c             |  10 +-
 src/network.c           |  30 +++---
 src/ofono.h             |   2 +-
 src/sim.c               |  10 +-
 src/voicecall.c         |  35 +++----
 13 files changed, 323 insertions(+), 100 deletions(-)

-- =

2.1.4


--===============3535810964080897734==--

