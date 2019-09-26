Content-Type: multipart/mixed; boundary="===============7090819020810441266=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] gprs: free interface name in gprs_context_remove()
Date: Thu, 26 Sep 2019 21:45:00 +0200
Message-ID: <20190926194500.228892-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7090819020810441266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/gprs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/gprs.c b/src/gprs.c
index 8df983a9..a8702958 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2794,6 +2794,7 @@ static void gprs_context_remove(struct ofono_atom *at=
om)
 	if (gc->driver && gc->driver->remove)
 		gc->driver->remove(gc);
 =

+	g_free(gc->interface);
 	g_free(gc);
 }
 =

-- =

2.23.0


--===============7090819020810441266==--

