Content-Type: multipart/mixed; boundary="===============1770942258823611016=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 1/4] dundee: Fix signal name
Date: Tue, 05 Jun 2012 15:48:16 +0200
Message-ID: <1338904099-13612-2-git-send-email-wagi@monom.org>
In-Reply-To: <1338904099-13612-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1770942258823611016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/manager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dundee/manager.c b/dundee/manager.c
index d7374d6..e8a37bf 100644
--- a/dundee/manager.c
+++ b/dundee/manager.c
@@ -90,7 +90,7 @@ static const GDBusMethodTable manager_methods[] =3D {
 };
 =

 static const GDBusSignalTable manager_signals[] =3D {
-	{ GDBUS_SIGNAL("DevicesAdded",
+	{ GDBUS_SIGNAL("DeviceAdded",
 		GDBUS_ARGS({ "path", "o"},{ "properties", "a{sv}" })) },
 	{ GDBUS_SIGNAL("DeviceRemoved",
 		GDBUS_ARGS({ "path", "o"})) },
-- =

1.7.10.130.g36e6c


--===============1770942258823611016==--

