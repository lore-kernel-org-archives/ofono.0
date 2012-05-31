Content-Type: multipart/mixed; boundary="===============8074346631496348090=="
MIME-Version: 1.0
From: pablo@gnumonks.org
Subject: [PATCH 0/2] v3: Wavecom Q2403/Q2686 modems support
Date: Thu, 31 May 2012 16:01:23 +0200
Message-ID: <1338472885-30645-1-git-send-email-pablo@gnumonks.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8074346631496348090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pablo Neira Ayuso <pablo@gnumonks.org>

Hi!

This patch adds the missing bits to fully support Wavecom
Q2403/Q2686 modems.

Thanks to Denis Kenzior for providing useful tips to get a
much nicer patch.

Pablo Neira Ayuso (2):
  udev: add Wavecom support
  plugins: add support for Wavecom Q2403/Q2686 modems

 drivers/atmodem/sim.c |    3 +++
 plugins/udev.c        |   27 +++++++++++++++++++++++++++
 plugins/wavecom.c     |   21 +++++++++++++++++++--
 3 files changed, 49 insertions(+), 2 deletions(-)

-- =

1.7.10


--===============8074346631496348090==--

