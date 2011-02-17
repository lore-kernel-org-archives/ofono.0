Content-Type: multipart/mixed; boundary="===============0361746432793112539=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/2] Fix reference handling in hfp_ag 
Date: Thu, 17 Feb 2011 16:55:24 +0100
Message-ID: <1297958126-9156-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0361746432793112539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, these patch fixes reference handling in hfp_ag.

First patch makes sure that GATServer properly disconnects client
when modem is put offline. =


Second patch fixes a Glib warning about a socket closed twice.
dun_gw may need something similar.

Fr=C3=A9d=C3=A9ric Dalleau (2):
  emulator: unref GIOChannel after creation
  hfp_ag: Do not close client fd on unref

 plugins/hfp_ag.c |    9 +--------
 src/emulator.c   |    2 ++
 2 files changed, 3 insertions(+), 8 deletions(-)


--===============0361746432793112539==--

