Content-Type: multipart/mixed; boundary="===============7588645989248901824=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH lte 0/8] QMI LTE series
Date: Tue, 11 Apr 2017 10:18:10 +0200
Message-ID: <20170411081818.19544-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7588645989248901824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LTE is different from other 'GPRS' technologies in that a default bearer
always gets set up when the modem registers to the network.  Ofono has
some support for this and this series tries to set this up for QMI
modems.

This seems to work, but I think that this whole process needs to be
re-thought a bit.  It's far from obvious how this works.  The GPRS
atom is still responsible for maintaining some form of "online" status,
but it does so in a round-about way where set_attached never gets called
because LTE doesn't have an "attached" state like GPRS does.

Other open questions:

What happens when the modem moves from LTE to UMTS network, or from
UMTS network to LTE when a context already has been set up?  Should the
default bearer still be set up on LTE?  Or should the default bearer be
taken down when moving away from LTE?

Jonas Bonn (8):
  qmi: NAS definitions adjustment
  qmi: add WDS parameter definition
  qmi: retrieve GPRS context parameters
  qmi: implement read_settings for automatic contexts
  lte: activate default bearer on network registration
  qmi: add LTE atom driver
  qmi: watch for automatic context activation
  gobi: add LTE atom

 Makefile.am                     |   1 +
 drivers/qmimodem/gprs-context.c |  78 ++++++++++++++
 drivers/qmimodem/gprs.c         |  90 ++++++++++++++++-
 drivers/qmimodem/lte.c          | 219 ++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/nas.h          |  14 ++-
 drivers/qmimodem/qmimodem.c     |   2 +
 drivers/qmimodem/qmimodem.h     |   3 +
 drivers/qmimodem/wds.h          |   2 +
 include/lte.h                   |   2 +
 plugins/gobi.c                  |   3 +
 src/lte.c                       | 115 +++++++++++++++++++++
 11 files changed, 525 insertions(+), 4 deletions(-)
 create mode 100644 drivers/qmimodem/lte.c

-- =

2.9.3


--===============7588645989248901824==--

