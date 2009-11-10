Content-Type: multipart/mixed; boundary="===============5030764438588009863=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Update test script to newer api.
Date: Tue, 10 Nov 2009 07:31:20 +0100
Message-ID: <1257834680-22555-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5030764438588009863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also remove an unused "import".
---
 test/create-context |    2 +-
 test/test-phonebook |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/test/create-context b/test/create-context
index 138efd1..08f2960 100755
--- a/test/create-context
+++ b/test/create-context
@@ -25,7 +25,7 @@ for path in properties["Modems"]:
 	properties =3D connmgr.GetProperties()
 =

 	if (properties["PrimaryContexts"] =3D=3D []):
-		path =3D connmgr.CreateContext()
+		path =3D connmgr.CreateContext("Example", "internet")
 	else:
 		path =3D properties["PrimaryContexts"][0]
 =

diff --git a/test/test-phonebook b/test/test-phonebook
index 52004e8..8db25c1 100755
--- a/test/test-phonebook
+++ b/test/test-phonebook
@@ -1,7 +1,5 @@
 #!/usr/bin/python
 =

-import gobject
-
 import dbus
 =

 if __name__ =3D=3D "__main__":
-- =

1.6.1


--===============5030764438588009863==--

