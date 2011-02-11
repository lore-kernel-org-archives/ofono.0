Content-Type: multipart/mixed; boundary="===============6837428678064059705=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] network: Remove unused SetProperty
Date: Thu, 10 Feb 2011 23:25:18 -0800
Message-ID: <1297409118-2606-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6837428678064059705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-api.txt |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 4cb6366..db8da75 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -12,16 +12,6 @@ Methods		dict GetProperties()
 =

 			Possible Errors: [service].Error.InvalidArguments
 =

-		void SetProperty(string name, variant value)
-
-			Changes the value of the specified property. Only
-			properties that are listed as readwrite are
-			changeable. On success a PropertyChanged signal
-			will be emitted.
-
-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.DoesNotExist
-
 		void Register()
 =

 			Attempts to register to the default network. The
-- =

1.7.0.4


--===============6837428678064059705==--

