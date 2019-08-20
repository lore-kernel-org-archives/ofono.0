Content-Type: multipart/mixed; boundary="===============5155585152590816439=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH v2 2/3] Revert "gprs: set driver_attached when activating
 automatic contexts"
Date: Tue, 20 Aug 2019 17:56:51 +0200
Message-ID: <20190820155652.8598-2-richard.rojfors@gmail.com>
In-Reply-To: <20190820155652.8598-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5155585152590816439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

This reverts commit 0167c3339ca8f17a653592af995f439d24405de8.

Since gprs_attached_update now takes LTE in account this
should be reverted. This was actually a bad solution since
in case LTE was lost, and we should fall back on GPRS we
have flagged the driver to already being attached, which is not...
---
 src/gprs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index 5829a577..bd9b3680 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -940,7 +940,6 @@ static void pri_read_settings_callback(const struct ofo=
no_error *error,
 =

 	gprs->flags &=3D ~GPRS_FLAG_ATTACHING;
 =

-	gprs->driver_attached =3D TRUE;
 	gprs_set_attached_property(gprs, TRUE);
 =

 	ofono_dbus_signal_property_changed(conn, pri_ctx->path,
-- =

2.20.1


--===============5155585152590816439==--

