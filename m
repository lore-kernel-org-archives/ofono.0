Content-Type: multipart/mixed; boundary="===============2979375359709584815=="
MIME-Version: 1.0
From: Christopher.Vogl@hale.at
Subject: [PATCH] telit: use CIND "rssi" indicator instead of "signal"
Date: Thu, 15 Dec 2011 14:34:41 +0100
Message-ID: <1323956081-1079-1-git-send-email-Christopher.Vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2979375359709584815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christopher Vogl <christopher.vogl@hale.at>

"signal" indicator permanently reports 99 (not measurable).
---
 drivers/atmodem/network-registration.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 2d808ad..b943241 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1288,6 +1288,7 @@ static void cind_support_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 	GAtResultIter iter;
 	const char *str;
+	char *signal_identifier =3D "signal";
 	int index;
 	int min =3D 0;
 	int max =3D 0;
@@ -1306,8 +1307,10 @@ static void cind_support_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
 	 * Telit encapsulates the CIND=3D? tokens with braces
 	 * so we need to skip them
 	 */
-	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT)
+	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT) {
 		g_at_result_iter_open_list(&iter);
+		signal_identifier =3D "rssi";
+	}
 =

 	while (g_at_result_iter_open_list(&iter)) {
 		/* Reset invalid default value for every token */
@@ -1333,7 +1336,7 @@ static void cind_support_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		if (!g_at_result_iter_close_list(&iter))
 			goto error;
 =

-		if (g_str_equal("signal", str) =3D=3D TRUE) {
+		if (g_str_equal(signal_identifier, str) =3D=3D TRUE) {
 			nd->signal_index =3D index;
 			nd->signal_min =3D min;
 			nd->signal_max =3D max;
-- =

1.7.4.4



--
Scanned by MailScanner.


--===============2979375359709584815==--

