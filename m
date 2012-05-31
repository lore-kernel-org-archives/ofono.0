Content-Type: multipart/mixed; boundary="===============7939957210139471129=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC 2/3] gprs-context: Add new driver entry definition
Date: Thu, 31 May 2012 11:59:07 +0200
Message-ID: <1338458348-335-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1338458348-335-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7939957210139471129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs-context.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 16893ce..2c70bf3 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -291,6 +291,16 @@ static void at_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 	g_at_ppp_shutdown(gcd->ppp);
 }
 =

+static void at_gprs_release_primary(struct ofono_gprs_context *gc,
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
+	.release_primary	=3D at_gprs_release_primary,
 };
 =

 void at_gprs_context_init(void)
-- =

1.7.5.4


--===============7939957210139471129==--

