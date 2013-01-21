Content-Type: multipart/mixed; boundary="===============6979970595679859445=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v1 0/3] HFP driver improvements
Date: Mon, 21 Jan 2013 16:30:21 +0100
Message-ID: <1358782224-28632-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6979970595679859445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

v1 fixes the comment added in patch v0 2/3, otherwise the rest stays the sa=
me.

From original cover-letter:

While testing the HFP modem driver with several phones, I found out an issu=
e with the Nokia 500, as described in patch v0 3/3.

The first two patches address a somehow unrelated issue regarding how call =
states should be reported.

Mikel Astiz (3):
  hfpmodem: Refactor voicecall notify with foreach
  hfpmodem: Avoid transitional voicecall states
  hfpmodem: Fix release-and-swap without +CIEV

 drivers/hfpmodem/voicecall.c | 72 ++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 66 insertions(+), 6 deletions(-)

-- =

1.7.11.7


--===============6979970595679859445==--

