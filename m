Content-Type: multipart/mixed; boundary="===============2092258564498753984=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] lte: Use the right D-Bus interface for property change signal
Date: Wed, 17 Jun 2020 01:40:14 +0300
Message-ID: <1592347214-28144-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2092258564498753984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/lte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lte.c b/src/lte.c
index fbe0116..951a06f 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -212,7 +212,7 @@ static void lte_set_default_attach_info_cb(const struct=
 ofono_error *error,
 	}
 =

 	ofono_dbus_signal_property_changed(conn, path,
-					OFONO_CONNECTION_CONTEXT_INTERFACE,
+					OFONO_LTE_INTERFACE,
 					key,
 					DBUS_TYPE_STRING, &value);
 =

-- =

1.9.1

--===============2092258564498753984==--

