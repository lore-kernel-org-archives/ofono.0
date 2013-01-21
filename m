Content-Type: multipart/mixed; boundary="===============3798835909248594937=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v0 0/3] HFP driver improvements
Date: Mon, 21 Jan 2013 11:10:25 +0100
Message-ID: <1358763028-20412-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3798835909248594937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

While testing the HFP modem driver with several phones, I found out an issu=
e with the Nokia 500, as described in patch v0 3/3.

The first two patches address a somehow unrelated issue regarding how call =
states should be reported.

Mikel Astiz (3):
  hfpmodem: Refactor voicecall notify with foreach
  hfpmodem: Avoid transitional voicecall states
  hfpmodem: Fix release-and-swap without +CIEV

 drivers/hfpmodem/voicecall.c | 70 ++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 64 insertions(+), 6 deletions(-)

-- =

1.7.11.7


--===============3798835909248594937==--

