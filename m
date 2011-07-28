Content-Type: multipart/mixed; boundary="===============6259760185823381496=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH 0/2] speedup: improvement
Date: Thu, 28 Jul 2011 16:16:08 +0200
Message-ID: <1311862570-29780-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6259760185823381496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove online/offline mechanism, since speedup modem have lot of difficulti=
es to exit offline mode.
Delay sending of &C0 to disable data carrier detect.

Bertrand Aygon (2):
  speedup: remove online/offline mechanism.
  speedup: delay &C0.

 plugins/speedup.c |   63 +++++++++++--------------------------------------=
---
 1 files changed, 14 insertions(+), 49 deletions(-)

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============6259760185823381496==--

