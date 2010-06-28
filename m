Content-Type: multipart/mixed; boundary="===============6318413783102248984=="
MIME-Version: 1.0
From: y@future.research.nokia.com
Subject: [PATCH 1/2] Documented Present property in sim-api.txt.
Date: Mon, 28 Jun 2010 21:17:07 +0300
Message-ID: <1277749028-3443-1-git-send-email-y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6318413783102248984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/sim-api.txt |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 74da31f..72e9ad9 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -7,7 +7,7 @@ Object path	[variable prefix]/{modem0,modem1,...}
 =

 Methods		dict GetProperties()
 =

-			Returns properties for the modem object. See
+			Returns SIM properties for the modem object.  See
 			the properties section for available properties.
 =

 			Possible Errors: [service].Error.InvalidArguments
@@ -32,7 +32,7 @@ Methods		dict GetProperties()
 			Activates the lock for the particular pin type.  The
 			device will ask for a PIN automatically next time the
 			device is turned on or the SIM is removed and
-			re-inserter.  The current PIN is required for the
+			re-inserted.  The current PIN is required for the
 			operation to succeed.
 =

 		void UnlockPin(string type, string pin)
@@ -45,9 +45,14 @@ Signals		PropertyChanged(string name, variant value)
 			This signal indicates a changed value of the given
 			property.
 =

-Properties	string SubscriberIdentity [readonly, optional]
+Properties	boolean Present [readonly]
 =

-			Contains the ISMI of the SIM, if available
+			True if a SIM card is detected.  There are
+			no other proprerties if false.
+
+		string SubscriberIdentity [readonly, optional]
+
+			Contains the IMSI of the SIM, if available.
 =

 		string MobileCountryCode [readonly, optional]
 =

@@ -119,4 +124,4 @@ Properties	string SubscriberIdentity [readonly, optiona=
l]
 		string CardIdentifier [readonly]
 =

 			Contains the Intergrated Circuit Card Identifer (ICCID)
-			and is read directly from the SIM.
+			which is read directly from the SIM.
-- =

1.6.3.3


--===============6318413783102248984==--

