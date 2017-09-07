Content-Type: multipart/mixed; boundary="===============6594085191335482024=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 5/6] gprs: use registration_status_to_string in debug messages
Date: Thu, 07 Sep 2017 22:22:59 +0200
Message-ID: <20170907202300.23952-5-lynxis@fe80.eu>
In-Reply-To: <20170907202300.23952-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6594085191335482024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index a4132cc06760..420c96f92238 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2596,7 +2596,8 @@ void ofono_gprs_detached_notify(struct ofono_gprs *gp=
rs)
 =

 void ofono_gprs_status_notify(struct ofono_gprs *gprs, int status)
 {
-	DBG("%s status %d", __ofono_atom_get_path(gprs->atom), status);
+	DBG("%s status %s (%d)", __ofono_atom_get_path(gprs->atom),
+			registration_status_to_string(status), status);
 =

 	gprs->status =3D status;
 =

-- =

2.14.1


--===============6594085191335482024==--

