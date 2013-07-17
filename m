Content-Type: multipart/mixed; boundary="===============3822013535329658739=="
MIME-Version: 1.0
From: Jesper Larsen <jesper.larsen@ixonos.com>
Subject: [PATCH 1/3] sim900: Enable serial receiver
Date: Wed, 17 Jul 2013 09:14:13 +0200
Message-ID: <1374045255-26600-2-git-send-email-jesper.larsen@ixonos.com>
In-Reply-To: <1374045255-26600-1-git-send-email-jesper.larsen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3822013535329658739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The read option must be set to 'on' in order for two-way
communication with SIM900 module to work.
---
 plugins/sim900.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/sim900.c b/plugins/sim900.c
index 6cfed65..643de51 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -127,6 +127,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	g_hash_table_insert(options, "XonXoff", "off");
 	g_hash_table_insert(options, "Local", "off");
 	g_hash_table_insert(options, "RtsCts", "off");
+	g_hash_table_insert(options, "Read", "on");
 =

 	channel =3D g_at_tty_open(device, options);
 	g_hash_table_destroy(options);
-- =

1.7.10.4


--===============3822013535329658739==--

