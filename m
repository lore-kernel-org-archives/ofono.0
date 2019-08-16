Content-Type: multipart/mixed; boundary="===============0888471613831599774=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: atmodem: introduce send_clcc() to reduce code duplication
Date: Fri, 16 Aug 2019 22:27:04 +0200
Message-ID: <20190816202704.rfp6gviv3pl4lta2@devuan>
In-Reply-To: <e8eec1b5-1762-8fae-f6dd-b687cad5b425@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0888471613831599774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Reduce code duplication by introducing send_clcc function.

---

> > Yes, you should have it separate in your inbox ;-). If not, let me
> > know and I'll resend.
> =

> Doesn't look like I do?

sorry about that. Here you go...

Best regards,
								Pavel

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index d55cf008..e22d412c 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -264,14 +264,17 @@ poll_again:
 						poll_clcc, vc);
 }
 =

+static void send_clcc(struct voicecall_data *vd, struct ofono_voicecall *v=
c)
+{
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix, clcc_poll_cb, vc, NULL);
+}
+
 static gboolean poll_clcc(gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				clcc_poll_cb, vc, NULL);
-
+	send_clcc(vd, vc);
 	vd->clcc_source =3D 0;
 =

 	return FALSE;
@@ -297,8 +301,7 @@ static void generic_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
 		}
 	}
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, req->vc, NULL);
+	send_clcc(vd, req->vc);
 =

 	/* We have to callback after we schedule a poll if required */
 	req->cb(&error, req->data);
@@ -316,8 +319,7 @@ static void release_id_cb(gboolean ok, GAtResult *resul=
t,
 	if (ok)
 		vd->local_release =3D 1 << req->id;
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, req->vc, NULL);
+	send_clcc(vd, req->vc);
 =

 	/* We have to callback after we schedule a poll if required */
 	req->cb(&error, req->data);
@@ -962,8 +975,7 @@ static void no_carrier_notify(GAtResult *result, gpoint=
er user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, vc, NULL);
+	send_clcc(vd, vc);
 }
 =

 static void no_answer_notify(GAtResult *result, gpointer user_data)
@@ -971,8 +983,7 @@ static void no_answer_notify(GAtResult *result, gpointe=
r user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, vc, NULL);
+	send_clcc(vd, vc);
 }
 =

 static void busy_notify(GAtResult *result, gpointer user_data)
@@ -984,8 +995,7 @@ static void busy_notify(GAtResult *result, gpointer use=
r_data)
 	 * or UDUB on the other side
 	 * TODO: Handle UDUB or other conditions somehow
 	 */
-	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-			clcc_poll_cb, vc, NULL);
+	send_clcc(vd, vc);
 }
 =

 static void cssi_notify(GAtResult *result, gpointer user_data)


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============0888471613831599774==--

