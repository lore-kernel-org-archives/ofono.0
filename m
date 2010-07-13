Content-Type: multipart/mixed; boundary="===============4125733720506045817=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/3] Support phonesim proactive command notification
Date: Tue, 13 Jul 2010 18:30:00 +0800
Message-ID: <1279017001-23915-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1279017001-23915-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4125733720506045817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/stk.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index 1283cca..3850f15 100644
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
@@ -262,10 +264,32 @@ error:
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
@@ -278,6 +302,7 @@ static int at_stk_probe(struct ofono_stk *stk, unsigned=
 int vendor, void *data)
 =

 	sd =3D g_new0(struct stk_data, 1);
 	sd->chat =3D chat;
+	sd->vendor =3D vendor;
 =

 	ofono_stk_set_data(stk, sd);
 	g_idle_add(at_stk_register, stk);
-- =

1.7.0.4


--===============4125733720506045817==--

