Content-Type: multipart/mixed; boundary="===============1910263592267044734=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH] control: use correct dbus error domain
Date: Thu, 12 Jul 2012 10:06:10 +0200
Message-ID: <1342080370-24537-2-git-send-email-morphis@gravedo.de>
In-Reply-To: <1342080370-24537-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1910263592267044734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Before it was org.ofono.phonesimError but should be consistent with the oth=
er error
reports and should use org.ofono.phonesim.Error.

Signed-off-by: Simon Busch <morphis@gravedo.de>
---
 src/control.cpp |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/control.cpp b/src/control.cpp
index 9085acd..3f1dd45 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -711,7 +711,7 @@ QString Script::Run(const QString &name, const QDBusMes=
sage &msg)
     QScriptValue qsScript =3D engine.evaluate(contents);
     if (qsScript.isError()) {
         QString info =3D fileName + ", line " + qsScript.property("lineNum=
ber").toString() + ", " + qsScript.toString();
-        QDBusMessage reply =3D msg.createErrorReply(SERVICE "Error.ScriptE=
xecError", info);
+        QDBusMessage reply =3D msg.createErrorReply(SERVICE ".Error.Script=
ExecError", info);
         QDBusConnection::sessionBus().send(reply);
         return QString();
     }
-- =

1.7.9.5


--===============1910263592267044734==--

