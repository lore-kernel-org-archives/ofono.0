Content-Type: multipart/mixed; boundary="===============5192597019489082124=="
MIME-Version: 1.0
From: mario@tokarz.eu
Subject: [RFC 0/2] Add stubs for dun gprs-context and dun_dt plug-in.
Date: Thu, 04 Aug 2011 18:08:25 +0200
Message-ID: <1312474107-8729-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5192597019489082124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

Hi all,

so, this is basically a draft for the missing piece in the dun functionalit=
y.

The gprs-context brings up the PPP, while the basic bluetooth communication=
 is =

part of the dun_dt plug-in.

Still, I don't have it all straight yet. The code will bring up the modem o=
nce,
but closing PPP in the context will also close the IoChannel, which means it
cannot be reopened. =


I'm sure the solution is pretty obvious, but I am a bit trapped in the dark,
so any hint on how to best sort the necessary calls would be highly appreci=
ated.


Cheers,
Mario


Mario Tokarz (2):
  dunmodem: Add stub for gprs-context.
  dun_dt: Add baseline for dun_dt plug-in.

 Makefile.am                     |    6 +-
 drivers/dunmodem/dunmodem.c     |    2 +
 drivers/dunmodem/dunmodem.h     |    3 +
 drivers/dunmodem/gprs-context.c |  220 +++++++++++++++++++++++
 plugins/dun_dt.c                |  375 +++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 605 insertions(+), 1 deletions(-)
 create mode 100644 drivers/dunmodem/gprs-context.c
 create mode 100644 plugins/dun_dt.c

-- =

1.7.4.1


--===============5192597019489082124==--

