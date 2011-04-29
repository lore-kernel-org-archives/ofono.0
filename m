Content-Type: multipart/mixed; boundary="===============3486213737331324226=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Remove a debug information, since the info is useless,
 and more, it can display invalid info due to var not initialise in some case
Date: Fri, 29 Apr 2011 15:20:08 +0200
Message-ID: <1304083208-25740-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3486213737331324226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 74c943a..2940762 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -1336,7 +1336,7 @@ static void sms_dispatch(struct ofono_sms *sms, GSLis=
t *sms_list)
 			}
 		}
 =

-		DBG("dst %d src %d 8bit %u", cdst, csrc, is_8bit);
+		DBG("dst %d src %d", cdst, csrc);
 =

 		if (srcport !=3D csrc || dstport !=3D cdst) {
 			ofono_error("Source / Destination ports across "
-- =

1.7.1

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

--===============3486213737331324226==--

