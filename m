Content-Type: multipart/mixed; boundary="===============4437514249994857467=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] mbm: make sure not to double-free gprs context
Date: Wed, 20 Apr 2011 22:33:40 +0200
Message-ID: <1303331620-27359-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4437514249994857467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If modem is offline, the mms context has been already freed so remove
mbm.c's reference to it.
---
 plugins/mbm.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index 105843f..9518990 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -463,6 +463,19 @@ static void set_online_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

+static void set_offline_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	struct mbm_data *data =3D cbd->user;
+
+	if (ok) {
+		data->gc =3D NULL;
+		data->gprs =3D NULL;
+	}
+
+	return set_online_cb(ok, result, user_data);
+}
+
 static void mbm_set_online(struct ofono_modem *modem, ofono_bool_t online,
 				ofono_modem_online_cb_t cb, void *user_data)
 {
@@ -473,7 +486,11 @@ static void mbm_set_online(struct ofono_modem *modem, =
ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (g_at_chat_send(chat, command, NULL, set_online_cb, cbd, g_free))
+	cbd->user =3D data;
+
+	if (g_at_chat_send(chat, command, NULL,
+				online ? set_online_cb : set_offline_cb,
+				cbd, g_free))
 		return;
 =

 	g_free(cbd);
-- =

1.7.1.86.g0e460.dirty


--===============4437514249994857467==--

