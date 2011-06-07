Content-Type: multipart/mixed; boundary="===============4047336225546990402=="
MIME-Version: 1.0
From: Bernhard.Guillon@hale.at
Subject: [PATCH] network-registration.c: enhance CIND=? support
Date: Tue, 07 Jun 2011 14:04:49 +0200
Message-ID: <1307448289-4413-1-git-send-email-Bernhard.Guillon@hale.at>
In-Reply-To: <4DDB5BD5.7010303@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4047336225546990402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bernhard Guillon <Bernhard.Guillon@hale.at>

*add support for CIND=3D? tokens like ("signal",(0-7,99))
*add support for token encapsulation e.g.
    (("one",(0-7,99)),("two",(0-7,99)))
---
 drivers/atmodem/network-registration.c |   51 ++++++++++++++++++++++++++++=
---
 1 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index b3aa511..18f2299 100644
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
@@ -666,7 +667,10 @@ static void ciev_notify(GAtResult *result, gpointer us=
er_data)
 	if (!g_at_result_iter_next_number(&iter, &strength))
 		return;
 =

-	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
+	if (strength =3D=3D nd->signal_invalid)
+		strength =3D -1;
+	else
+		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
 	ofono_netreg_strength_notify(netreg, strength);
 }
 =

@@ -798,7 +802,10 @@ static void cind_cb(gboolean ok, GAtResult *result, gp=
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
@@ -1133,7 +1140,9 @@ static void cind_support_cb(gboolean ok, GAtResult *r=
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
@@ -1145,14 +1154,45 @@ static void cind_support_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
 	index =3D 1;
 =

 	while (g_at_result_iter_open_list(&iter)) {
+		/*
+		 * Some modems encapsulate the result list in braces
+		 * So we just skip the opening brace in this case.
+		 * We do not need to care about the closing one.
+		 */
+		g_at_result_iter_open_list(&iter);
+
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
+			/*
+			 * This part of code makes havy use of the implementation
+			 * details of g_at_result_iter_next_range()
+			 * We currently support this token type ("signal",(0-5))
+			 * While tokens like this ("call",(0,1))
+			 * will be parsed to the end to get to the next token.
+			 * With the same idea we can support tokens like
+			 * ("signal",(0-7,99)) it is unlikely that a valid
+			 * token is "signal",(0-0) so if both values are the
+			 * same we know we are at the 99 case of (0-7,99)
+			 * This implementation only works because of how the =

+			 * g_at_result_iter_next_range() function is implemented
+			 * if it changes this code will break.
+			 */
+			if(tmp_min!=3Dtmp_max) {
+				min=3Dtmp_min;
+				max=3Dtmp_max;
+			}
+			else {
+				invalid=3Dtmp_min;
+			}
+		}
 =

 		if (!g_at_result_iter_close_list(&iter))
 			goto error;
@@ -1164,6 +1204,7 @@ static void cind_support_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 			nd->signal_index =3D index;
 			nd->signal_min =3D min;
 			nd->signal_max =3D max;
+			nd->signal_invalid =3D invalid;
 		}
 =

 		index +=3D 1;
-- =

1.7.0.4



--
Scanned by MailScanner.


--===============4047336225546990402==--

