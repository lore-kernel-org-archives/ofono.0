Content-Type: multipart/mixed; boundary="===============2039864126290305474=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH] voicecall: fix CreateMultiparty method introspection
Date: Fri, 22 Apr 2016 13:06:10 +0000
Message-ID: <1461330367-19383-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2039864126290305474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

This caused problems with stricter dbus wrappers such as dbus-c++.

---
 src/voicecall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 2d15d12..bdad125 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2165,7 +2165,7 @@ static const GDBusMethodTable manager_methods[] =3D {
 						GDBUS_ARGS({ "calls", "ao" }),
 						multiparty_private_chat) },
 	{ GDBUS_ASYNC_METHOD("CreateMultiparty",
-					NULL, GDBUS_ARGS({ "calls", "o" }),
+					NULL, GDBUS_ARGS({ "calls", "ao" }),
 					multiparty_create) },
 	{ GDBUS_ASYNC_METHOD("HangupMultiparty", NULL, NULL,
 							multiparty_hangup) },
-- =

1.9.1

--===============2039864126290305474==--

