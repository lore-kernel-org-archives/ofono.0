Content-Type: multipart/mixed; boundary="===============4786395372469742437=="
MIME-Version: 1.0
From: pablo@gnumonks.org
Subject: [PATCH] v2: support Wavecom Q2403/Q2686 modems
Date: Tue, 29 May 2012 04:14:25 +0200
Message-ID: <1338257667-24281-1-git-send-email-pablo@gnumonks.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4786395372469742437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pablo Neira Ayuso <pablo@gnumonks.org>

Hi!

This is the second version of the patch to support Wavecom Q2403/Q2686
modems. I've tried to address all comments from Denis Kenzior.

I've splitted the patch in two, one per directory directory as you
suggested.

Please, let me know if you find any issue with this patch.

Thank you!

Pablo Neira Ayuso (2):
  wavecom: add support for Wavecom Q2403/Q2686 modems
  wavecom: add support for Wavecom Q2403/Q2686 modems

 drivers/atmodem/sim.c    |    3 +-
 drivers/atmodem/sms.c    |   27 +++++++++++++---
 drivers/atmodem/vendor.h |    1 +
 plugins/udev.c           |   15 +++++++++
 plugins/wavecom.c        |   77 ++++++++++++++++++++++++++++++++++++++++++=
----
 5 files changed, 111 insertions(+), 12 deletions(-)

-- =

1.7.10


--===============4786395372469742437==--

