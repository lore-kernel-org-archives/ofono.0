Content-Type: multipart/mixed; boundary="===============2918793963613435518=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 2/3] Support phonesim proactive command notification
Date: Fri, 09 Jul 2010 22:52:07 +0800
Message-ID: <1278687128-8983-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1278687128-8983-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2918793963613435518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/stk.c |   25 +++++++++++++++++++++++++
 plugins/phonesim.c    |    2 +-
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index 6058d69..91b9195 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -39,9 +39,11 @@
 =

 #include "atmodem.h"
 #include "stk.h"
+#include "vendor.h"
 =

 struct stk_data {
 	GAtChat *chat;
+	unsigned int vendor;
 };
 =

 static const char *csim_prefix[] =3D { "+CSIM:", NULL };
@@ -264,10 +266,32 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void phonesim_tcmd_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_data *data =3D ofono_stk_get_data(stk);
+	GAtResultIter iter;
+	int length;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "*TCMD:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &length))
+		return;
+
+	at_sim_fetch_command(data->chat, stk, length);
+}
+
 static gboolean at_stk_register(gpointer user)
 {
 	struct ofono_stk *stk =3D user;
+	struct stk_data *sd =3D ofono_stk_get_data(stk);
 =

+	if (sd->vendor =3D=3D OFONO_VENDOR_PHONESIM)
+		g_at_chat_register(sd->chat, "*TCMD", phonesim_tcmd_notify,
+							FALSE, stk, NULL);
 	ofono_stk_register(stk);
 =

 	return FALSE;
@@ -280,6 +304,7 @@ static int at_stk_probe(struct ofono_stk *stk, unsigned=
 int vendor, void *data)
 =

 	sd =3D g_new0(struct stk_data, 1);
 	sd->chat =3D chat;
+	sd->vendor =3D vendor;
 =

 	ofono_stk_set_data(stk, sd);
 	g_idle_add(at_stk_register, stk);
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index d0cd7f3..9c5b2cb 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -289,7 +289,7 @@ static void phonesim_pre_sim(struct ofono_modem *modem)
 	else
 		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
 =

-	ofono_stk_create(modem, 0, "atmodem", data->chat);
+	ofono_stk_create(modem, OFONO_VENDOR_PHONESIM, "atmodem", data->chat);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

1.7.0.4


--===============2918793963613435518==--

