Content-Type: multipart/mixed; boundary="===============2197313713270672741=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 11/11] plugins: remove NULL check
Date: Sat, 29 Jan 2011 05:34:44 -0800
Message-ID: <1296308084-3726-12-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2197313713270672741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/gobi.c     |    2 +-
 plugins/hso.c      |    4 ----
 plugins/ifx.c      |    4 ----
 plugins/mbm.c      |    4 ----
 plugins/novatel.c  |    2 +-
 plugins/phonesim.c |   12 ------------
 plugins/sierra.c   |    2 +-
 plugins/ste.c      |    4 ----
 plugins/tc65.c     |    4 ----
 plugins/zte.c      |    2 +-
 10 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 1a5830d..e2f988d 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -251,7 +251,7 @@ static void gobi_set_online(struct ofono_modem *modem, =
ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL || data->chat =3D=3D NULL)
+	if (data->chat =3D=3D NULL)
 		goto error;
 =

 	if (g_at_chat_send(data->chat, command, NULL,
diff --git a/plugins/hso.c b/plugins/hso.c
index 990be6d..4594c52 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -346,13 +346,9 @@ static void hso_set_online(struct ofono_modem *modem, =
ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
diff --git a/plugins/ifx.c b/plugins/ifx.c
index 79cd150..411c012 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -661,14 +661,10 @@ static void ifx_set_online(struct ofono_modem *modem,=
 ofono_bool_t online,
 =

 	DBG("%p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(data->dlcs[AUX_DLC], command, NULL,
 					set_online_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
diff --git a/plugins/mbm.c b/plugins/mbm.c
index e826240..600b358 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -470,13 +470,9 @@ static void mbm_set_online(struct ofono_modem *modem, =
ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
diff --git a/plugins/novatel.c b/plugins/novatel.c
index fbd1216..1948c49 100644
--- a/plugins/novatel.c
+++ b/plugins/novatel.c
@@ -309,7 +309,7 @@ static void novatel_set_online(struct ofono_modem *mode=
m, ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL || chat =3D=3D NULL)
+	if (chat =3D=3D NULL)
 		goto error;
 =

 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 28306b5..2b36fe0 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -143,9 +143,6 @@ static void phonesim_deactivate_primary(struct ofono_gp=
rs_context *gc,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[128];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D gc;
 =

 	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", id);
@@ -154,7 +151,6 @@ static void phonesim_deactivate_primary(struct ofono_gp=
rs_context *gc,
 				at_cgact_down_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -273,14 +269,10 @@ static void phonesim_ctm_query(struct ofono_ctm *ctm,
 =

 	DBG("");
 =

-	if (!cbd)
-		goto error;
-
 	if (g_at_chat_send(chat, "AT+PTTY?", ptty_prefix,
 				ctm_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, 0, data);
@@ -305,16 +297,12 @@ static void phonesim_ctm_set(struct ofono_ctm *ctm, o=
fono_bool_t enable,
 =

 	DBG("");
 =

-	if (!cbd)
-		goto error;
-
 	snprintf(buf, sizeof(buf), "AT+PTTY=3D%d", enable);
 =

 	if (g_at_chat_send(chat, buf, none_prefix,
 				ctm_set_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	CALLBACK_WITH_FAILURE(cb, data);
 	g_free(cbd);
 }
diff --git a/plugins/sierra.c b/plugins/sierra.c
index b3edcf4..f387b98 100644
--- a/plugins/sierra.c
+++ b/plugins/sierra.c
@@ -195,7 +195,7 @@ static void sierra_set_online(struct ofono_modem *modem=
, ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL || data->chat =3D=3D NULL)
+	if (data->chat =3D=3D NULL)
 		goto error;
 =

 	if (g_at_chat_send(data->chat, command, NULL,
diff --git a/plugins/ste.c b/plugins/ste.c
index 6b44780..0b02a0d 100644
--- a/plugins/ste.c
+++ b/plugins/ste.c
@@ -320,13 +320,9 @@ static void ste_set_online(struct ofono_modem *modem, =
ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
diff --git a/plugins/tc65.c b/plugins/tc65.c
index 60f66e7..f58f33d 100644
--- a/plugins/tc65.c
+++ b/plugins/tc65.c
@@ -159,13 +159,9 @@ static void tc65_set_online(struct ofono_modem *modem,=
 ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
diff --git a/plugins/zte.c b/plugins/zte.c
index 4693d93..822098d 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -250,7 +250,7 @@ static void zte_set_online(struct ofono_modem *modem, o=
fono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (cbd =3D=3D NULL || chat =3D=3D NULL)
+	if (chat =3D=3D NULL)
 		goto error;
 =

 	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
-- =

1.7.0.4


--===============2197313713270672741==--

