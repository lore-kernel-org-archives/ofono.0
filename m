Content-Type: multipart/mixed; boundary="===============4952210203024529767=="
MIME-Version: 1.0
From: Bernhard.Guillon@hale.at
Subject: [PATCH v4 1/4] network-registration.c: add telit support
Date: Wed, 08 Jun 2011 17:18:34 +0200
Message-ID: <1307546317-31831-1-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4952210203024529767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bernhard Guillon <Bernhard.Guillon@hale.at>

*add support for CIND=3D? tokens like ("signal",(0-7,99))
*add telit quirk for token encapsulation e.g.
    (("one",(0-7,99)),("two",(0-7,99)))
---
 drivers/atmodem/network-registration.c |   41 ++++++++++++++++++++++++++++=
----
 1 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index b3aa511..7c86fec 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -56,6 +56,7 @@ struct netreg_data {
 	int signal_index; /* If strength is reported via CIND */
 	int signal_min; /* min strength reported via CIND */
 	int signal_max; /* max strength reported via CIND */
+	int signal_invalid; /* invalid strength reported via CIND */
 	int tech;
 	struct ofono_network_time time;
 	guint nitz_timeout;
@@ -666,7 +667,11 @@ static void ciev_notify(GAtResult *result, gpointer us=
er_data)
 	if (!g_at_result_iter_next_number(&iter, &strength))
 		return;
 =

-	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+	if (strength =3D=3D nd->signal_invalid)
+		strength =3D -1;
+	else
+		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+
 	ofono_netreg_strength_notify(netreg, strength);
 }
 =

@@ -798,7 +803,10 @@ static void cind_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 =

 	g_at_result_iter_next_number(&iter, &strength);
 =

-	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+	if (strength =3D=3D nd->signal_invalid)
+		strength =3D -1;
+	else
+		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
 =

 	cb(&error, strength, cbd->data);
 }
@@ -1133,7 +1141,9 @@ static void cind_support_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	GAtResultIter iter;
 	const char *str;
 	int index;
-	int min, max;
+	int min =3D 0;
+	int max =3D 0;
+	int tmp_min, tmp_max, invalid;
 =

 	if (!ok)
 		goto error;
@@ -1144,15 +1154,32 @@ static void cind_support_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
 =

 	index =3D 1;
 =

+	/*
+	 * Telit encapsulates the CIND=3D? tokens with braces
+	 * so we need to skip them
+	 */
+	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT)
+		g_at_result_iter_open_list(&iter);
+
 	while (g_at_result_iter_open_list(&iter)) {
+		/* Reset invalid default value for every token*/
+		invalid =3D 99;
+
 		if (!g_at_result_iter_next_string(&iter, &str))
 			goto error;
 =

 		if (!g_at_result_iter_open_list(&iter))
 			goto error;
 =

-		while (g_at_result_iter_next_range(&iter, &min, &max))
-			;
+		while (g_at_result_iter_next_range(&iter, &tmp_min, &tmp_max)) {
+
+			if (tmp_min !=3D tmp_max) {
+				min =3D tmp_min;
+				max =3D tmp_max;
+			} else
+				invalid =3D tmp_min;
+
+		}
 =

 		if (!g_at_result_iter_close_list(&iter))
 			goto error;
@@ -1164,11 +1191,15 @@ static void cind_support_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
 			nd->signal_index =3D index;
 			nd->signal_min =3D min;
 			nd->signal_max =3D max;
+			nd->signal_invalid =3D invalid;
 		}
 =

 		index +=3D 1;
 	}
 =

+	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT)
+		g_at_result_iter_close_list(&iter);
+
 	if (nd->signal_index =3D=3D 0)
 		goto error;
 =

-- =

1.7.0.4



--
Scanned by MailScanner.


--===============4952210203024529767==--

