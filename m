Content-Type: multipart/mixed; boundary="===============6656278683891949325=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 07/10] stk: Unregister AT notifiers when removing
Date: Tue, 10 Aug 2010 22:43:46 +0800
Message-ID: <1281451429-17257-8-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6656278683891949325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unregister AT notifications when removing stk driver.
---
 drivers/atmodem/stk.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
index d6c19da..de687f8 100644
--- a/drivers/atmodem/stk.c
+++ b/drivers/atmodem/stk.c
@@ -44,6 +44,8 @@
 struct stk_data {
 	GAtChat *chat;
 	unsigned int vendor;
+	guint tcmd_id;
+	guint tend_id;
 };
 =

 static const char *csim_prefix[] =3D { "+CSIM:", NULL };
@@ -294,10 +296,12 @@ static gboolean at_stk_register(gpointer user)
 	struct stk_data *sd =3D ofono_stk_get_data(stk);
 =

 	if (sd->vendor =3D=3D OFONO_VENDOR_PHONESIM) {
-		g_at_chat_register(sd->chat, "*TCMD:", phonesim_tcmd_notify,
+		sd->tcmd_id =3D g_at_chat_register(sd->chat, "*TCMD:",
+							phonesim_tcmd_notify,
 							FALSE, stk, NULL);
 =

-		g_at_chat_register(sd->chat, "*TEND", phonesim_tend_notify,
+		sd->tend_id =3D g_at_chat_register(sd->chat, "*TEND",
+							phonesim_tend_notify,
 							FALSE, stk, NULL);
 	}
 =

@@ -325,6 +329,9 @@ static void at_stk_remove(struct ofono_stk *stk)
 {
 	struct stk_data *sd =3D ofono_stk_get_data(stk);
 =

+	g_at_chat_unregister(sd->chat, sd->tcmd_id);
+	g_at_chat_unregister(sd->chat, sd->tend_id);
+
 	ofono_stk_set_data(stk, NULL);
 =

 	g_free(sd);
-- =

1.7.0.4


--===============6656278683891949325==--

