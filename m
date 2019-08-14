Content-Type: multipart/mixed; boundary="===============7932952870823948248=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH 3/4] Revert "gprs: set driver_attached when activating
 automatic contexts"
Date: Wed, 14 Aug 2019 20:24:43 +0200
Message-ID: <20190814182444.13508-3-richard.rojfors@gmail.com>
In-Reply-To: <20190814182444.13508-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7932952870823948248==
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
index cb31e2d2..eb6cd30b 100644
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


--===============7932952870823948248==--

