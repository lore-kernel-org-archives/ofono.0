Content-Type: multipart/mixed; boundary="===============1543476627956645171=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] ublox: Do not leave vendor_family unset
Date: Sun, 31 Mar 2019 23:19:19 +0200
Message-ID: <20190331211919.10720-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1543476627956645171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

In a recent patch vendor family was only set if the device
did not support USBCONF, but that resulted in drivers
being registered the "generic" vendor. That caused
for instance netreg to use incorrect cmer mode and fail
on TOBY-L210.
---
 plugins/ublox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index dc001765..355bdf9e 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -227,6 +227,8 @@ static void query_model_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	DBG("Model: %s", data->model->name);
 =

+	data->vendor_family =3D OFONO_VENDOR_UBLOX;
+
 	if (data->model->flags & UBLOX_F_HAVE_USBCONF) {
 		if (g_at_chat_send(data->aux, "AT+UUSBCONF?", uusbconf_prefix,
 					query_usbconf_cb, modem, NULL))
@@ -234,8 +236,6 @@ static void query_model_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 		ofono_error("Unable to query USB configuration");
 		goto fail;
-	} else {
-		data->vendor_family =3D OFONO_VENDOR_UBLOX;
 	}
 =

 	if (g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
-- =

2.19.1


--===============1543476627956645171==--

