Content-Type: multipart/mixed; boundary="===============0539797026197161446=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH] gprs: Fix the ContextAdded() signal Introspection
Date: Tue, 22 Dec 2015 08:15:29 +0000
Message-ID: <1450772147-30239-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0539797026197161446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

This matches the behavior described by the documentation the signal
value returned by the code. This was causing a headache when using
stricter D-Bus wrappers like dbus-c++.
---
 src/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index ba797dd..9192e68 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2385,7 +2385,7 @@ static const GDBusSignalTable manager_signals[] =3D {
 	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ GDBUS_SIGNAL("ContextAdded",
-			GDBUS_ARGS({ "path", "o" }, { "properties", "v" })) },
+			GDBUS_ARGS({ "path", "o" }, { "properties", "a{sv}" })) },
 	{ GDBUS_SIGNAL("ContextRemoved", GDBUS_ARGS({ "path", "o" })) },
 	{ }
 };
-- =

1.9.1

--===============0539797026197161446==--

