Content-Type: multipart/mixed; boundary="===============7128835856459800345=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v2 0/2] cbs: add a mechanism to split the topics list.
Date: Tue, 02 Aug 2011 16:33:37 +0200
Message-ID: <1312295619-29778-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7128835856459800345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some ZTE modems don't support sending a CBS topics list larger than 50 char=
acters.

Bertrand Aygon (2):
  cbs: add a mechniasm to split the topics list.
  zte: specify the vendor to send cbs in split mode.

 drivers/atmodem/cbs.c |   97 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 plugins/zte.c         |    2 +-
 2 files changed, 93 insertions(+), 6 deletions(-)

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

--===============7128835856459800345==--

