Content-Type: multipart/mixed; boundary="===============2027368795440268553=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] cdmamodem: remove an unneeded buffer and sprintf.
Date: Wed, 03 Aug 2011 18:33:48 +0200
Message-ID: <1312389228-25454-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2027368795440268553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index 0df93eb..7d77387 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -188,7 +188,6 @@ static void cdma_connman_activate(struct ofono_cdma_con=
nman *cm,
 					void *data)
 {
 	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
-	char buf[64];
 =

 	DBG("");
 =

@@ -199,9 +198,7 @@ static void cdma_connman_activate(struct ofono_cdma_con=
nman *cm,
 =

 	cd->state =3D STATE_ENABLING;
 =

-	sprintf(buf, "ATD#777");
-
-	if (g_at_chat_send(cd->chat, buf, none_prefix,
+	if (g_at_chat_send(cd->chat, "ATD#777", none_prefix,
 				atd_cb, cm, NULL) > 0)
 		return;
 =

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

--===============2027368795440268553==--

