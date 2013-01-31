Content-Type: multipart/mixed; boundary="===============1092126848916398273=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] hfp_hf_bluez5: Remove error handling for
 g_io_channel_unix_new()
Date: Thu, 31 Jan 2013 15:30:08 -0300
Message-ID: <1359657008-16198-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1092126848916398273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Apart from g_io_channel_unix_new() not setting errno, it never
returns an NULL pointer on error, because in practice it only
calls g_new().
---
 plugins/hfp_hf_bluez5.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 8cac945..ff4dbad 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -137,11 +137,6 @@ static int service_level_connection(struct ofono_modem=
 *modem,
 	GAtChat *chat;
 =

 	io =3D g_io_channel_unix_new(fd);
-	if (io =3D=3D NULL) {
-		ofono_error("Service level connection failed: %s (%d)",
-						strerror(errno), errno);
-		return -EIO;
-	}
 =

 	syntax =3D g_at_syntax_new_gsm_permissive();
 	chat =3D g_at_chat_new(io, syntax);
-- =

1.8.1.1


--===============1092126848916398273==--

