Content-Type: multipart/mixed; boundary="===============8697726202387103262=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] test-voicecall: Fix typo
Date: Tue, 31 Jul 2012 11:47:46 +0200
Message-ID: <1343728066-15690-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8697726202387103262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-voicecall |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/test-voicecall b/test/test-voicecall
index 3b0d432..7118eb8 100755
--- a/test/test-voicecall
+++ b/test/test-voicecall
@@ -12,7 +12,7 @@ def hangup_all():
 =

 def print_calls():
 	calls =3D vcmanager.GetCalls()
-	if (len(calls) !=3D 0):
+	if (len(calls) =3D=3D 0):
 		print "No calls available"
 	else:
 		for path, properties in calls:
-- =

1.7.5.4


--===============8697726202387103262==--

