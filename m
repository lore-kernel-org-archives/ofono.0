Content-Type: multipart/mixed; boundary="===============8300701579778937333=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 3/4] huawei: send a prefix with AT commands
Date: Tue, 25 May 2010 17:23:26 +0300
Message-ID: <20100525142326.10449.58784.stgit@potku.valot.fi>
In-Reply-To: <20100525142205.10449.64616.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8300701579778937333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


---

 plugins/huawei.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 962895a..d7697b9 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -47,6 +47,9 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+static const char *none_prefix[] =3D { NULL };
+static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
+
 struct huawei_data {
 	GAtChat *chat;
 	GAtChat *event;
@@ -167,7 +170,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 							FALSE, modem, NULL);
 =

 	/* query current sim state */
-	g_at_chat_send(data->chat, "AT^SYSINFO", NULL, sysinfo_cb, modem, NULL);
+	g_at_chat_send(data->chat, "AT^SYSINFO", sysinfo_prefix,
+					sysinfo_cb, modem, NULL);
 }
 =

 static GAtChat *create_port(const char *device)
@@ -231,9 +235,9 @@ static int huawei_enable(struct ofono_modem *modem)
 =

 	data->sim_state =3D 0;
 =

-	g_at_chat_send(data->chat, "ATE0", NULL, NULL, NULL, NULL);
+	g_at_chat_send(data->chat, "ATE0", none_prefix, NULL, NULL, NULL);
 =

-	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
+	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
 					cfun_enable, modem, NULL);
 =

 	return -EINPROGRESS;
@@ -271,7 +275,7 @@ static int huawei_disable(struct ofono_modem *modem)
 =

 	g_at_chat_cancel_all(data->chat);
 	g_at_chat_unregister_all(data->chat);
-	g_at_chat_send(data->chat, "AT+CFUN=3D0", NULL,
+	g_at_chat_send(data->chat, "AT+CFUN=3D0", none_prefix,
 					cfun_disable, modem, NULL);
 =

 	return -EINPROGRESS;


--===============8300701579778937333==--

