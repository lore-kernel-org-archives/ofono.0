Content-Type: multipart/mixed; boundary="===============3832110875402257625=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] phonesim: Fix call scripting capability
Date: Wed, 29 Feb 2012 14:56:05 +0100
Message-ID: <1330523765-10592-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3832110875402257625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/scriptable.txt |    6 +++---
 src/control.cpp    |    3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/scriptable.txt b/doc/scriptable.txt
index 670bd21..95ae1e1 100644
--- a/doc/scriptable.txt
+++ b/doc/scriptable.txt
@@ -7,8 +7,8 @@ call, you have to do some operations manually within phones=
im GUI).  Below are
 several examples:
 =

 1. call.js (stand for incoming call and copy it to /tmp/call/)
-tabRegistration.gbIncomingCall.leCaller.text =3D "12345";
-tabRegistration.gbIncomingCall.pbIncomingCall.click();
+tabCall.gbIncomingCall.leCaller.text =3D "12345";
+tabCall.gbIncomingCall.pbIncomingCall.click();
 =

 Then set the path of script and run the script with its name:
 =

@@ -50,6 +50,6 @@ Reference" for details.
 For example, if you want to know the current incoming number, you may writ=
e a
 script as below:
 // number.js
-tabRegistration.gbIncomingCall.leCaller.text
+tabCall.gbIncomingCall.leCaller.text
 =

 After running the script the similar way as above, you may get the number.
diff --git a/src/control.cpp b/src/control.cpp
index 2666b4c..ee1e7d8 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -667,6 +667,9 @@ Script::Script(QObject *obj, Ui_ControlBase *ui) : QDBu=
sAbstractAdaptor(obj)
 =

     QScriptValue qsTab8 =3D engine.newQObject(ui->tab_8);
     engine.globalObject().setProperty("tabPosition", qsTab8);
+
+    QScriptValue qsTab9 =3D engine.newQObject(ui->tab_9);
+    engine.globalObject().setProperty("tabCall", qsTab9);
 }
 =

 void Script::SetPath(const QString &path, const QDBusMessage &msg)
-- =

1.7.1


--===============3832110875402257625==--

