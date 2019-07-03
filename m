Content-Type: multipart/mixed; boundary="===============8673413295623998827=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 02/10] atutil: guard call to g_hash_table_destroy()
Date: Wed, 03 Jul 2019 20:09:47 +0200
Message-ID: <20190703180955.18246-3-martin@geanix.com>
In-Reply-To: <20190703180955.18246-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8673413295623998827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Glib emits a warning when g_hash_table_destroy() is called on a NULL
pointer:

  GLib-CRITICAL **: 13:27:40.269: g_hash_table_destroy: assertion 'hash_tab=
le !=3D NULL' failed

Add a check to avoid this warning.
---
 drivers/atmodem/atutil.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 1db524e3..bbdb01c4 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -769,7 +769,9 @@ GAtChat *at_util_open_device(struct ofono_modem *modem,=
 const char *key,
 	}
 =

 	channel =3D g_at_tty_open(device, options);
-	g_hash_table_destroy(options);
+
+	if (options)
+		g_hash_table_destroy(options);
 =

 	if (channel =3D=3D NULL)
 		return NULL;
-- =

2.22.0


--===============8673413295623998827==--

