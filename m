Content-Type: multipart/mixed; boundary="===============5952083974663575589=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/6] Fix common misspellings in documentation
Date: Tue, 14 Sep 2010 00:06:00 -0300
Message-ID: <1284433565-26126-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <4C8EDFF9.4060006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5952083974663575589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix common misspellings by using the list available at
http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_mac=
hines.

From the list cited above, the substitution script found the following
misspellings:

accomodate->accommodate
targetted->targeted
transfering->transferring
witheld->withheld
withold->withhold
---
 doc/call-settings-api.txt    |    6 +++---
 doc/ofono-paper.txt          |    4 ++--
 doc/voicecallmanager-api.txt |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/call-settings-api.txt b/doc/call-settings-api.txt
index a345b9c..e98ce0c 100644
--- a/doc/call-settings-api.txt
+++ b/doc/call-settings-api.txt
@@ -47,7 +47,7 @@ Properties	string CallingLinePresentation [readonly]
 			Contains the value of the connected line identification
 			restriction property. The value indicates the state of
 			the COLR supplementary service in the network.  If
-			enabled, the network will withold subscriber number
+			enabled, the network will withhold subscriber number
 			information from the calling party on incoming calls.
 			The possible values are:
 				"disabled",
@@ -77,12 +77,12 @@ Properties	string CallingLinePresentation [readonly]
 		string HideCallerId [readwrite]
 =

 			Sets whether the ID of the caller will should be
-			provided or witheld for outgoing calls.  This setting
+			provided or withheld for outgoing calls.  This setting
 			is also modified by the status of the CLIR supplementary
 			service in the network (see the CallingLineRestriction
 			property).  The three possible values are:
 				"default" - Uses the network setting
-				"enabled" - CLIR invoked, caller id is witheld
+				"enabled" - CLIR invoked, caller id is withheld
 				"disabled" - CLIR suppressed, caller id is
 						provided
 =

diff --git a/doc/ofono-paper.txt b/doc/ofono-paper.txt
index df3f0b3..ec6d01b 100644
--- a/doc/ofono-paper.txt
+++ b/doc/ofono-paper.txt
@@ -7,7 +7,7 @@ Linux and other open source components are now used extensi=
vely on both desktop
 and mobile embedded devices.  They provide networking, power management,
 database and other core OS infrastructure.  However, up to this point no
 viable open source solution for mobile telephony existed.  oFono aims to
-change that; it is a telephony host stack specifically targetted at both
+change that; it is a telephony host stack specifically targeted at both
 mobile embedded and desktop systems.
 =

 Launched on May 11, 2009 oFono aims to provide a solid framework for buili=
dng
@@ -97,7 +97,7 @@ for low-level operations.  This interface is based on 3GP=
P TS 27.007 "AT
 command set for User Equipment" and 3GPP TS 27.005 "DTE-DCE interface for =
SMS
 and CBS".  oFono assumes that all operations are fully asynchronous.
 =

-This means that oFono can accomodate a wide variety of devices, including
+This means that oFono can accommodate a wide variety of devices, including
 full-featured modems (AT command based and otherwise), data-only cards, and
 modem like devices (e.g. Bluetooth Handsfree and Sim Access Profile device=
s,
 etc.)
diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 620720f..11af23a 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -34,7 +34,7 @@ Methods		array{object,dict} GetCalls()
 =

 			Joins the currently Active (or Outgoing, depending
 			on network support) and Held calls together and
-			disconnects both calls. In effect transfering
+			disconnects both calls. In effect transferring
 			one party to the other. This procedure requires
 			an Active and Held call and the Explicit Call Transfer
 			(ECT) supplementary service to be active.
-- =

1.7.2.3


--===============5952083974663575589==--

