Content-Type: multipart/mixed; boundary="===============5245607744901198249=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH v3] atmodem: Query the list of supported <fac>s from the modem
Date: Mon, 23 Oct 2017 23:52:36 +0300
Message-ID: <1508791956-25711-1-git-send-email-slava.monich@jolla.com>
In-Reply-To: <e5088452-35c4-cafa-ae8b-b256120c228b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5245607744901198249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not all modems support all <fac>s (particularly, "PS"), let's be polite
and not ask them for the ones they don't support.
---
 drivers/atmodem/sim.c | 57 ++++++++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 6395a04..8665274 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -51,6 +51,7 @@ struct sim_data {
 	GAtChat *chat;
 	unsigned int vendor;
 	guint ready_id;
+	guint passwd_type_mask;
 	struct at_util_sim_state_query *sim_state_query;
 };
 =

@@ -1459,9 +1460,8 @@ static void at_pin_enable(struct ofono_sim *sim,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 	int ret;
-	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fac);
 =

-	if (passwd_type >=3D len || at_clck_cpwd_fac[passwd_type] =3D=3D NULL)
+	if (!(sd->passwd_type_mask & (1 << passwd_type)))
 		goto error;
 =

 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",%i,\"%s\"",
@@ -1490,10 +1490,8 @@ static void at_change_passwd(struct ofono_sim *sim,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 	int ret;
-	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fac);
 =

-	if (passwd_type >=3D len ||
-			at_clck_cpwd_fac[passwd_type] =3D=3D NULL)
+	if (!(sd->passwd_type_mask & (1 << passwd_type)))
 		goto error;
 =

 	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
@@ -1550,9 +1548,8 @@ static void at_query_clck(struct ofono_sim *sim,
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
-	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fac);
 =

-	if (passwd_type >=3D len || at_clck_cpwd_fac[passwd_type] =3D=3D NULL)
+	if (!(sd->passwd_type_mask & (1 << passwd_type)))
 		goto error;
 =

 	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2",
@@ -1568,13 +1565,42 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

-static gboolean at_sim_register(gpointer user)
+static void at_clck_query_cb(gboolean ok, GAtResult *result, gpointer user)
 {
 	struct ofono_sim *sim =3D user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	GAtResultIter iter;
+	const char *fac;
 =

-	ofono_sim_register(sim);
+	if (!ok)
+		goto done;
+
+	g_at_result_iter_init(&iter, result);
+
+	/* e.g. +CLCK: ("SC","FD","PN","PU","PP","PC","PF") */
+	if (!g_at_result_iter_next(&iter, "+CLCK:") ||
+				!g_at_result_iter_open_list(&iter))
+		goto done;
+
+	/* Clear the default mask */
+	sd->passwd_type_mask =3D 0;
 =

-	return FALSE;
+	/* Set the bits for <fac>s that are actually supported */
+	while (g_at_result_iter_next_string(&iter, &fac)) {
+		unsigned int i;
+
+		/* Find it in the list of known <fac>s */
+		for (i =3D 0; i < ARRAY_SIZE(at_clck_cpwd_fac); i++) {
+			if (!g_strcmp0(at_clck_cpwd_fac[i], fac)) {
+				sd->passwd_type_mask |=3D (1 << i);
+				DBG("found %s", fac);
+				break;
+			}
+		}
+	}
+
+done:
+	ofono_sim_register(sim);
 }
 =

 static int at_sim_probe(struct ofono_sim *sim, unsigned int vendor,
@@ -1582,6 +1608,7 @@ static int at_sim_probe(struct ofono_sim *sim, unsign=
ed int vendor,
 {
 	GAtChat *chat =3D data;
 	struct sim_data *sd;
+	unsigned int i;
 =

 	sd =3D g_new0(struct sim_data, 1);
 	sd->chat =3D g_at_chat_clone(chat);
@@ -1591,9 +1618,15 @@ static int at_sim_probe(struct ofono_sim *sim, unsig=
ned int vendor,
 		g_at_chat_send(sd->chat, "AT*EPEE=3D1", NULL, NULL, NULL, NULL);
 =

 	ofono_sim_set_data(sim, sd);
-	g_idle_add(at_sim_register, sim);
 =

-	return 0;
+	/* <fac>s supported by default */
+	for (i =3D 0; i < ARRAY_SIZE(at_clck_cpwd_fac); i++)
+		if (at_clck_cpwd_fac[i])
+			sd->passwd_type_mask |=3D (1 << i);
+
+	/* Query supported <fac>s */
+	return g_at_chat_send(sd->chat, "AT+CLCK=3D?", clck_prefix,
+				at_clck_query_cb, sim, NULL) ? 0 : -1;
 }
 =

 static void at_sim_remove(struct ofono_sim *sim)
-- =

1.9.1


--===============5245607744901198249==--

