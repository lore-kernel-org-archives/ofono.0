Content-Type: multipart/mixed; boundary="===============6251579075451458263=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 5/5] update gprs context settings when activating primary
 conext
Date: Tue, 17 Nov 2009 23:49:13 +0800
Message-ID: <1258472953-2922-5-git-send-email-martin.xu@intel.com>
In-Reply-To: <1258472953-2922-4-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6251579075451458263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/gprs-context.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index ecbafa0..b800d4a 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -116,6 +116,18 @@ static void mbm_cgdcont_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

+static void update_gprs_context_settings(struct ofono_gprs_context *gc)
+{
+	const char *interface;
+
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+
+	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+
+	ofono_gprs_context_update_settings(gc, interface, "dhcp",
+						NULL, NULL, NULL, NULL);
+}
+
 static void mbm_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
 				ofono_gprs_context_cb_t cb, void *data)
@@ -132,6 +144,8 @@ static void mbm_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 =

 	cbd->user =3D gc;
 =

+	update_gprs_context_settings(gc);
+
 	/* TODO: Handle username / password fields */
 	len =3D sprintf(buf, "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
 =

-- =

1.6.1.3


--===============6251579075451458263==--

