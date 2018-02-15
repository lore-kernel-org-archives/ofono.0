Content-Type: multipart/mixed; boundary="===============9132709763158901192=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: [PATCH] modem: ofono_modem_create: log invalid paths
Date: Thu, 15 Feb 2018 13:22:04 +0100
Message-ID: <20180215122204.17349-1-pespin@sysmocom.de>
In-Reply-To: <20180213195338.30077-1-pespin@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9132709763158901192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/modem.c b/src/modem.c
index d5fda7ca..698a7ca8 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1876,8 +1876,10 @@ struct ofono_modem *ofono_modem_create(const char *n=
ame, const char *type)
 	else
 		snprintf(path, sizeof(path), "/%s", name);
 =

-	if (!dbus_validate_path(path, NULL))
+	if (!dbus_validate_path(path, NULL)) {
+		DBG("Invalid dbus path for modem: %s", path);
 		return NULL;
+	}
 =

 	modem =3D g_try_new0(struct ofono_modem, 1);
 =

-- =

2.16.1


--===============9132709763158901192==--

