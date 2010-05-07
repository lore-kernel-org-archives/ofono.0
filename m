Content-Type: multipart/mixed; boundary="===============2926996719930902486=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/6] atmodem/sim.c: Pass allowed response prefixes to gatchat.
Date: Fri, 07 May 2010 02:27:19 +0200
Message-ID: <1273192039-11218-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2926996719930902486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not doing this creates a race condition where any notification
comming in in the middle of a sequence of commands may be counted
as a response to one of the commands and get lost.

Instead gatchat could be changed to give priority to registered
unsolicited responses if a line matches one of the registered
prefixes, especially since some non-compliant modems regularly
send unsolicited responses in the middle of a command response.

---
 drivers/atmodem/sim.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 66c95e1..9c1b949 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -47,6 +47,9 @@ struct sim_data {
 };
 =

 static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *clck_prefix[] =3D { "+CLCK:", NULL };
+static const char *none_prefix[] =3D { NULL };
 =

 static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
@@ -488,7 +491,7 @@ static void at_pin_query(struct ofono_sim *sim, ofono_s=
im_passwd_cb_t cb,
 =

 	cbd->user =3D sim;
 =

-	if (g_at_chat_send_full(sd->chat, "AT+CPIN?", NULL, NULL,
+	if (g_at_chat_send_full(sd->chat, "AT+CPIN?", cpin_prefix, NULL,
 				at_cpin_cb, cbd, g_free) > 0)
 		return;
 =

@@ -524,7 +527,7 @@ static void at_pin_send(struct ofono_sim *sim, const ch=
ar *passwd,
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
 =

-	ret =3D g_at_chat_send_full(sd->chat, buf, NULL, NULL,
+	ret =3D g_at_chat_send_full(sd->chat, buf, none_prefix, NULL,
 				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
@@ -553,7 +556,7 @@ static void at_pin_send_puk(struct ofono_sim *sim, cons=
t char *puk,
 =

 	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
 =

-	ret =3D g_at_chat_send_full(sd->chat, buf, NULL, NULL,
+	ret =3D g_at_chat_send_full(sd->chat, buf, none_prefix, NULL,
 				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
@@ -599,7 +602,7 @@ static void at_pin_enable(struct ofono_sim *sim,
 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",%i,\"%s\"",
 			at_clck_cpwd_fac[passwd_type], enable ? 1 : 0, passwd);
 =

-	ret =3D g_at_chat_send_full(sd->chat, buf, NULL, NULL,
+	ret =3D g_at_chat_send_full(sd->chat, buf, none_prefix, NULL,
 				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
@@ -635,7 +638,7 @@ static void at_change_passwd(struct ofono_sim *sim,
 	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
 			at_clck_cpwd_fac[passwd_type], old, new);
 =

-	ret =3D g_at_chat_send_full(sd->chat, buf, NULL, NULL,
+	ret =3D g_at_chat_send_full(sd->chat, buf, none_prefix, NULL,
 				at_lock_unlock_cb, cbd, g_free);
 =

 	memset(buf, 0, sizeof(buf));
@@ -698,7 +701,7 @@ static void at_pin_query_enabled(struct ofono_sim *sim,
 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2",
 			at_clck_cpwd_fac[passwd_type]);
 =

-	if (g_at_chat_send_full(sd->chat, buf, NULL, NULL,
+	if (g_at_chat_send_full(sd->chat, buf, clck_prefix, NULL,
 				at_lock_status_cb, cbd, g_free) > 0)
 		return;
 =

-- =

1.6.1


--===============2926996719930902486==--

