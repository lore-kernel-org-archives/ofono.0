Content-Type: multipart/mixed; boundary="===============4600840980492554322=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 13/19] ubloxmodem: push back APN into gprs context
Date: Wed, 09 Mar 2016 16:44:54 +0100
Message-ID: <1457538300-7183-14-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4600840980492554322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It can be that the APN is different than what a user provided. So let
the core know. This happens for example when using the default bearer:
the user doesn't provide any APN, so read the one from CGCONTRDP.
---
 drivers/ubloxmodem/gprs-context.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-co=
ntext.c
index f80e1d8..b6eaa5e 100644
--- a/drivers/ubloxmodem/gprs-context.c
+++ b/drivers/ubloxmodem/gprs-context.c
@@ -183,6 +183,7 @@ static void cgcontrdp_bridge_cb(gboolean ok, GAtResult =
*result, gpointer user_da
 	const char *laddrnetmask =3D NULL;
 	const char *gw =3D NULL;
 	const char *dns[2+1] =3D { NULL, NULL, NULL };
+	const char *apn =3D NULL;
 =

 	DBG("ok %d", ok);
 =

@@ -197,7 +198,6 @@ static void cgcontrdp_bridge_cb(gboolean ok, GAtResult =
*result, gpointer user_da
 	while (g_at_result_iter_next(&iter, "+CGCONTRDP:")) {
 		/* tmp vals for ignored fields */
 		int bearer_id;
-		char *apn;
 =

 		if (!g_at_result_iter_next_number(&iter, &cid))
 			break;
@@ -234,6 +234,16 @@ static void cgcontrdp_bridge_cb(gboolean ok, GAtResult=
 *result, gpointer user_da
 	if (dns[0])
 		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
 =

+	if (gcd->active_context =3D=3D ublox_data.default_context_id) {
+		/*
+		 * Only for automatic default context: the APN set by the user
+		 * might not be the correct one because the default context was
+		 * used instead.
+		 */
+		ofono_gprs_context_set_apn(gc, apn);
+		strcpy(gcd->apn, apn);
+	}
+
 	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
 =

-- =

2.5.0


--===============4600840980492554322==--

