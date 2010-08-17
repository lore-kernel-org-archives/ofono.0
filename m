Content-Type: multipart/mixed; boundary="===============5108022522179385818=="
MIME-Version: 1.0
From: caiwen.zhang <caiwenzhang@163.com>
Subject: [PATCH] update sim api
Date: Tue, 17 Aug 2010 07:48:27 +0000
Message-ID: <1282031276-12898-1-git-send-email-caiwenzhang@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5108022522179385818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: cwzhang <cwzhang@cwzhang-laptop.(none)>

---
 doc/sim-api.txt |   80 ++++++++++++++++++++++++---------------------------=
----
 1 files changed, 35 insertions(+), 45 deletions(-)
 mode change 100644 =3D> 100755 doc/sim-api.txt

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
old mode 100644
new mode 100755
index 72e9ad9..91390c4
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -45,10 +45,37 @@ Signals		PropertyChanged(string name, variant value)
 			This signal indicates a changed value of the given
 			property.
 =

-Properties	boolean Present [readonly]
-
-			True if a SIM card is detected.  There are
-			no other proprerties if false.
+Properties	string Status [readonly]
+			=

+			Contains the string type of the status of the SIM.  =

+			The possible values are:
+			"ready" - Not waiting for a password
+			"pin" - SIM PIN is required
+			"phone" - Phone-to-SIM PIN is required  [GSM only]
+			"firstphone" - Phone-to-very-first SIM
+						PIN is required  [GSM only]
+			"pin2" - SIM PIN2 is required
+			"network" - Network Personalization password is
+						required  [GSM only]
+			"netsub" - Network subset personalization
+						password is required  [GSM only]
+			"service" - Service Provider personalization
+						password is required  [GSM only]
+			"corp" - Corporate personalization password
+						is required  [GSM only]
+			"puk" - SIM PUK is required
+			"firstphonepuk" - Phone-to-very-first SIM PUK is
+						required  [GSM only]
+			"puk2" - SIM PUK2 is required
+			"networkpuk" - Network personalization unblocking
+						password is required  [GSM only]
+			"netsubpuk" - Network subset personalization
+						unblocking password is required  [GSM only]
+			"servicepuk" - Service provider personalization
+						unblocking password is required  [GSM only]
+			"corppuk" - Corporate personalization unblocking
+						password is required  [GSM only]
+			"absent" - No SIM inserted
 =

 		string SubscriberIdentity [readonly, optional]
 =

@@ -80,48 +107,11 @@ Properties	boolean Present [readonly]
 			Contains a dictionary of service dialing numbers from
 			the SIM, if available.
 =

-		string PinRequired [readonly]
-
-			Contains the string type of the pin required by the
-			modem.  The possible values are:
-				"none" - Nothing is required
-				"pin" - SIM PIN is required
-				"phone" - Phone-to-SIM PIN is required
-				"firstphone" - Phone-to-very-first SIM
-						PIN is required
-				"pin2" - SIM PIN2 is required
-				"network" - Network Personalization password is
-						required
-				"netsub" - Network subset personalization
-						password is required
-				"service" - Service Provider personalization
-						password is required
-				"corp" - Corporate personalization password
-						is required
-				"puk" - SIM PUK is required
-				"firstphonepuk" - Phone-to-very-first SIM PUK is
-						required
-				"puk2" - SIM PUK2 is required
-				"networkpuk" - Network personalization unblocking
-						password is required
-				"netsubpuk" - Network subset personalization
-						unblocking password is required
-				"servicepuk" - Service provider personalization
-						unblocking password is required
-				"corppuk" - Corporate personalization unblocking
-						password is required
-
-		array{string} LockedPins [readonly]
-
-			Contains the pins that are currently locked and will
-			require the user to enter the password at startup.
-			Using LockPin and UnlockPin will result in changes to
-			this property.
-
-			The list contains elements of the same format as the
-			PinRequired property.
-
 		string CardIdentifier [readonly]
 =

 			Contains the Intergrated Circuit Card Identifer (ICCID)
 			which is read directly from the SIM.
+		=

+		array{uint8} PinRetryCount [readonly]
+		=

+			 Contains the remain retry count of PIN,PIN2,PUK and PUK2
-- =

1.7.0.4



--===============5108022522179385818==--

