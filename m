Content-Type: multipart/mixed; boundary="===============6248293513466426500=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 4/4] add mbm_gprs_create/destroy_interface to mbm
 gprs_context_driver
Date: Mon, 09 Nov 2009 15:38:01 +0800
Message-ID: <1257752281-22251-4-git-send-email-martin.xu@intel.com>
In-Reply-To: <1257752281-22251-3-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6248293513466426500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/gprs-context.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index ecbafa0..d3e03b7 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -172,6 +172,25 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void mbm_gprs_create_interface(struct ofono_gprs_context *gc,
+					struct ofono_gprs_primary_context *ctx)
+{
+	const char *interface;
+	struct ofono_modem *modem =3D ofono_gprs_context_get_modem(gc);
+
+	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+
+	g_free(ctx->interface);
+	ctx->interface =3D g_strdup(interface);
+}
+
+static void mbm_gprs_destroy_interface(struct ofono_gprs_context *gc,
+					struct ofono_gprs_primary_context *ctx)
+{
+	g_free(ctx->interface);
+	ctx->interface =3D NULL;
+}
+
 static void e2nap_notifier(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
@@ -237,6 +256,8 @@ static struct ofono_gprs_context_driver driver =3D {
 	.remove			=3D mbm_gprs_context_remove,
 	.activate_primary	=3D mbm_gprs_activate_primary,
 	.deactivate_primary	=3D mbm_gprs_deactivate_primary,
+	.create_interface	=3D mbm_gprs_create_interface,
+	.destroy_interface	=3D mbm_gprs_destroy_interface,
 };
 =

 void mbm_gprs_context_init()
-- =

1.6.1.3


--===============6248293513466426500==--

