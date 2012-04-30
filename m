Content-Type: multipart/mixed; boundary="===============3994597154178259801=="
MIME-Version: 1.0
From: pablo@gnumonks.org
Subject: [PATCH] Wavecom Q2403/Q2686 support
Date: Mon, 30 Apr 2012 16:45:18 +0200
Message-ID: <1335797120-715-1-git-send-email-pablo@gnumonks.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3994597154178259801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pablo Neira Ayuso <pablo@gnumonks.org>

Hi!

The following patch adds support for Wavecom Q2403 and Q2686.

We (the Osmocom team) are using these modems with ofono in our
testbed setup.

Any chance this can be applied to mainstream?

Thank you!

Pablo Neira Ayuso (1):
  wavecom: add support for Wavecom Q2403/Q2686 modems

 Makefile.am              |    3 +
 drivers/atmodem/sim.c    |    8 ++
 drivers/atmodem/sms.c    |   31 ++++++--
 drivers/atmodem/vendor.h |    1 +
 gatchat/gatchat.c        |    3 +-
 plugins/udev.c           |    2 +
 plugins/wavecom_q.c      |  192 ++++++++++++++++++++++++++++++++++++++++++=
++++
 7 files changed, 234 insertions(+), 6 deletions(-)
 create mode 100644 plugins/wavecom_q.c

-- =

1.7.9.5


--===============3994597154178259801==--

