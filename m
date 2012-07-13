Content-Type: multipart/mixed; boundary="===============5628710310838366593=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC_v2 2/3] gprs-context: Add new driver entry definition
Date: Fri, 13 Jul 2012 15:44:27 +0200
Message-ID: <1342187068-10418-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1342187068-10418-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5628710310838366593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs-context.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 16893ce..58a829b 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -291,6 +291,16 @@ static void at_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 	g_at_ppp_shutdown(gcd->ppp);
 }
 =

+static void at_gprs_detach_shutdown(struct ofono_gprs_context *gc,
+					unsigned int cid)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("cid %u", cid);
+
+	g_at_ppp_shutdown(gcd->ppp);
+}
+
 static void cgev_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
@@ -380,6 +390,7 @@ static struct ofono_gprs_context_driver driver =3D {
 	.remove			=3D at_gprs_context_remove,
 	.activate_primary	=3D at_gprs_activate_primary,
 	.deactivate_primary	=3D at_gprs_deactivate_primary,
+	.detach_shutdown	=3D at_gprs_detach_shutdown,
 };
 =

 void at_gprs_context_init(void)
-- =

1.7.5.4


--===============5628710310838366593==--

