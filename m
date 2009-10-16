Content-Type: multipart/mixed; boundary="===============8973200901820712024=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: [PATCH] API documentation fixes
Date: Fri, 16 Oct 2009 12:47:48 +0300
Message-ID: <4AD84144.3060602@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8973200901820712024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Fixes for API documentation.

Regards,
Marko

---
 doc/call-settings-api.txt    |    4 ++--
 doc/sim-api.txt              |   10 +++++-----
 doc/voicecall-api.txt        |    2 +-
 doc/voicecallmanager-api.txt |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/doc/call-settings-api.txt b/doc/call-settings-api.txt
index 870c748..5e5eb40 100644
--- a/doc/call-settings-api.txt
+++ b/doc/call-settings-api.txt
@@ -1,7 +1,7 @@
-Call Forwarding hierarchy
+Call Settings hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Service		org.ofono
-Interface	org.ofono.CallForwarding
+Interface	org.ofono.CallSettings
 Object path	[variable prefix]/{modem0,modem1,...}

 Methods		dict GetProperties()
diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 11ee4c8..9fe9a92 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -12,22 +12,22 @@ Methods		dict GetProperties()

 			Possible Errors: [service].Error.InvalidArguments

-		ChangePin(string type, string oldpin, string newpin)
+		void ChangePin(string type, string oldpin, string newpin)

 			Changes the pin given by string type.

-		EnterPin(string type, string pin)
+		void EnterPin(string type, string pin)

 			Enters the currently pending pin.  The type value must
 			match the pin type being asked in the PinRequired
 			property.

-		ResetPin(string type, string puk, string newpin)
+		void ResetPin(string type, string puk, string newpin)

 			Provides the unblock key to the modem and if correct
 			resets the pin to the new value of newpin.

-		LockPin(string type, string pin)
+		void LockPin(string type, string pin)

 			Activates the lock for the particular pin type.  The
 			device will ask for a PIN automatically next time the
@@ -35,7 +35,7 @@ Methods		dict GetProperties()
 			re-inserter.  The current PIN is required for the
 			operation to succeed.

-		UnlockPin(string type, string pin)
+		void UnlockPin(string type, string pin)

 			Deactivates the lock for the particular pin type.  The
 			current PIN is required for the operation to succeed.
diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 62db5a1..b360cca 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -3,7 +3,7 @@ VoiceCall hierarchy

 Service		org.ofono
 Interface	org.ofono.VoiceCall
-Object path	[variable prefix]/{modem0,modem1,...}/{call0,call1,...}
+Object path	[variable prefix]/{modem0,modem1,...}/{voicecall01,voicecall02=
,...}

 Methods		dict GetProperties()

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 361370a..7877ac5 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -70,7 +70,7 @@ Methods		dict GetProperties()
 			Held calls is invalid, since in GSM a user can have
 			only a single Held call at a time.

-		void HangupAllCalls()
+		void HangupAll()

 			Releases all calls.

-- =

1.6.0.4

--===============8973200901820712024==--

