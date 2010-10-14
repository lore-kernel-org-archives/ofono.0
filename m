Content-Type: multipart/mixed; boundary="===============6906172969009451732=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/2] doc: Describe the scriptable feature
Date: Thu, 14 Oct 2010 20:34:42 +0800
Message-ID: <1287059682-12973-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1287059682-12973-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6906172969009451732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/scriptable.txt |   55 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100644 doc/scriptable.txt

diff --git a/doc/scriptable.txt b/doc/scriptable.txt
new file mode 100644
index 0000000..670bd21
--- /dev/null
+++ b/doc/scriptable.txt
@@ -0,0 +1,55 @@
+With the support of QtScript, now phonesim is scriptable, which means you =
may
+manipulate or extend phonesim's functionality using ECMA script language
+(defined in ECMA-262). At the same time, some D-Bus interface and dedicated
+methods are also defined to facilitate this feature. As a result, full test
+automation can be achieved (Without this, if you want to initiate an incom=
ing
+call, you have to do some operations manually within phonesim GUI).  Below=
 are
+several examples:
+
+1. call.js (stand for incoming call and copy it to /tmp/call/)
+tabRegistration.gbIncomingCall.leCaller.text =3D "12345";
+tabRegistration.gbIncomingCall.pbIncomingCall.click();
+
+Then set the path of script and run the script with its name:
+
+dbus-send --session --print-reply --dest=3Dorg.ofono.phonesim /
+org.ofono.phonesim.Script.SetPath string:/tmp/call
+
+dbus-send --session --print-reply --dest=3Dorg.ofono.phonesim /
+org.ofono.phonesim.Script.Run string:call.js
+
+Now you have simulated an incoming call.
+
+PS: If you want to know the hierarchy of UI elements, check the file
+src/controlbase.ui
+
+2. sms.js (stand for incoming sms and copy it to /tmp/sms/)
+tabSMS.gbMessage1.leMessageSender.text =3D "Yang";
+tabSMS.gbMessage1.leSMSClass.text =3D "1";
+tabSMS.gbMessage1.teSMSText.setPlainText("Sent from phonesim");
+tabSMS.gbMessage1.pbSendSMSMessage.click();
+
+Then do the similar things as first example:
+
+dbus-send --session --print-reply --dest=3Dorg.ofono.phonesim /
+org.ofono.phonesim.Script.SetPath string:/tmp/sms
+
+dbus-send --session --print-reply --dest=3Dorg.ofono.phonesim /
+org.ofono.phonesim.Script.Run string:sms.js
+
+Now you have simulated an incoming sms.
+
+3. Get the current path for script
+dbus-send --session --print-reply --dest=3Dorg.ofono.phonesim /
+org.ofono.phonesim.Script.GetPath
+
+4. Make script return some string
+The string can be any string, number, bool, date, etc in JavaScript, but it
+couldn't be a object because of some side effect. Refer "QScriptValue Class
+Reference" for details.
+For example, if you want to know the current incoming number, you may writ=
e a
+script as below:
+// number.js
+tabRegistration.gbIncomingCall.leCaller.text
+
+After running the script the similar way as above, you may get the number.
-- =

1.7.2.3


--===============6906172969009451732==--

