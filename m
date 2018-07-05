Content-Type: multipart/mixed; boundary="===============7278267880160935669=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] gprs: store APN in settings for auto-discovered contexts
Date: Thu, 05 Jul 2018 10:45:18 +0200
Message-ID: <1530780318-20577-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7278267880160935669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

APN has to be stored in settings file after it is modified in
ofono_gprs_cid_activated function.
---
 src/gprs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index 377eced..22d5e36 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2063,6 +2063,13 @@ void ofono_gprs_cid_activated(struct ofono_gprs  *gp=
rs, unsigned int cid,
 =

 		strcpy(pri_ctx->context.apn, apn);
 =

+		if (gprs->settings) {
+			g_key_file_set_string(gprs->settings, pri_ctx->key,
+							"AccessPointName", apn);
+			storage_sync(gprs->imsi, SETTINGS_STORE,
+								gprs->settings);
+		}
+
 		ofono_dbus_signal_property_changed(conn, pri_ctx->path,
 					OFONO_CONNECTION_CONTEXT_INTERFACE,
 					"AccessPointName",
-- =

2.7.4


--===============7278267880160935669==--

