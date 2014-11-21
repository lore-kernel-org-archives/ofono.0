Content-Type: multipart/mixed; boundary="===============2911015591836696658=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: [PATCH 2/2] receive-sms: Support printing received SMS with non-ASCII
 characters
Date: Fri, 21 Nov 2014 01:48:26 +0000
Message-ID: <1416534506-19999-2-git-send-email-neil@ossau.homelinux.net>
In-Reply-To: <1416534506-19999-1-git-send-email-neil@ossau.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2911015591836696658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without this I get the following Python traceback, for an SMS that
contains the UK pound sign.

ERROR:dbus.connection:Exception in handler for D-Bus signal:
Traceback (most recent call last):
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 230, in =
maybe_handle_message
    self._handler(*args, **kwargs)
  File "./receive-sms", line 9, in incoming_message
    print("%s" % (message))
UnicodeEncodeError: 'ascii' codec can't encode character u'\xa3' in positio=
n 51: ordinal not in range(128)
---
 test/receive-sms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/receive-sms b/test/receive-sms
index a0c6915..f5e247e 100755
--- a/test/receive-sms
+++ b/test/receive-sms
@@ -6,7 +6,7 @@ import dbus
 import dbus.mainloop.glib
 =

 def incoming_message(message, details, path, interface):
-	print("%s" % (message))
+	print("%s" % (message.encode('utf-8')))
 =

 	for key in details:
 		val =3D details[key]
-- =

2.1.1


--===============2911015591836696658==--

