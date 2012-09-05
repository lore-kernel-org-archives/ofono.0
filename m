Content-Type: multipart/mixed; boundary="===============3808948399939347430=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/3] phonesim: Reject specific outgoing call for SAT test
 purpose
Date: Wed, 05 Sep 2012 19:21:07 +0200
Message-ID: <1346865667-24888-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346865667-24888-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3808948399939347430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/callmanager.cpp |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/callmanager.cpp b/src/callmanager.cpp
index 4567548..1995c6d 100644
--- a/src/callmanager.cpp
+++ b/src/callmanager.cpp
@@ -79,6 +79,13 @@ bool CallManager::command( const QString& cmd )
             return true;
         }
 =

+        // For SAT test purpose, reject the dialing number 0123401234 if t=
here
+        // is a connected call.
+        if ( hasCall( CallState_Active ) && number =3D=3D "+0123401234" ) {
+            send( "NO CARRIER" );
+            return true;
+         }
+
         // If there is a connected call, place it on hold.
         changeGroup( CallState_Active, CallState_Held );
 =

-- =

1.7.9.5


--===============3808948399939347430==--

