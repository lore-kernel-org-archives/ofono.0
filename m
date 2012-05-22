Content-Type: multipart/mixed; boundary="===============3912612071434344082=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] test: Add timeout to be compliant with GCF
Date: Tue, 22 May 2012 14:49:16 +0200
Message-ID: <1337690956-3199-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3912612071434344082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With some GCF test cases, default python script timeout
is too short to pass the tests.
---
 test/private-chat |    2 +-
 test/swap-calls   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/private-chat b/test/private-chat
index 4938a25..e7c8026 100755
--- a/test/private-chat
+++ b/test/private-chat
@@ -14,7 +14,7 @@ path =3D modems[0][0]
 manager =3D dbus.Interface(bus.get_object('org.ofono', path),
 						'org.ofono.VoiceCallManager')
 =

-mpty =3D manager.PrivateChat(sys.argv[1])
+mpty =3D manager.PrivateChat(sys.argv[1], timeout=3D100)
 =

 for path in mpty:
 	print path
diff --git a/test/swap-calls b/test/swap-calls
index 4996e0c..eeb257b 100755
--- a/test/swap-calls
+++ b/test/swap-calls
@@ -17,4 +17,4 @@ if (len(sys.argv) =3D=3D 2):
 manager =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.VoiceCallManager')
 =

-manager.SwapCalls()
+manager.SwapCalls(timeout=3D100)
-- =

1.7.5.4


--===============3912612071434344082==--

