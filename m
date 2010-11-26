Content-Type: multipart/mixed; boundary="===============7288922334927159930=="
MIME-Version: 1.0
From: ext-arun.1.ravindran@nokia.com
Subject: [PATCH] doc: cdma-voicecall-manager-api.txt
Date: Fri, 26 Nov 2010 11:54:02 +0200
Message-ID: <1290765242-30673-2-git-send-email-ext-arun.1.ravindran@nokia.com>
In-Reply-To: <1290765242-30673-1-git-send-email-ext-arun.1.ravindran@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7288922334927159930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>

---
 doc/cdma-voicecall-manager-api.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/doc/cdma-voicecall-manager-api.txt b/doc/cdma-voicecall-manage=
r-api.txt
index b457af7..958402f 100644
--- a/doc/cdma-voicecall-manager-api.txt
+++ b/doc/cdma-voicecall-manager-api.txt
@@ -35,6 +35,16 @@ Methods		dict GetProperties()
 			'*', '#', 'A', 'B', 'C', 'D'.  The last four are
 			typically not used in normal circumstances.
 =

+		void SetProperty(string property, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as readwrite are
+			changeable. On success a PropertyChanged signal
+			will be emitted.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.DoesNotExist
+
 Signals		PropertyChanged(string property, variant value)
 =

 			Signal is emitted whenever a property has changed.
@@ -81,3 +91,23 @@ Properties	string State [readonly]
 			currently supported values are:
 				"short",
 				"long"
+
+		string LineIdentification [readonly]
+
+			Contains the Line Identification information returned
+			by the network, if present. For incoming calls this is
+			effectively the CLIP. For outgoing calls this attribute
+			will hold the dialed number.
+
+			Please note that after sending flash this property
+			will be empty.
+
+		string StartTime [readonly, optional]
+
+			Contains the starting time of the call.  The time is
+			stamped when the call enters the "active" state.
+			Client applications can use this to infer somewhat
+			reliable call duration information.
+
+			Please note that after sending Flash, there will not be
+			any StartTime property change for the Flash string/number.
-- =

1.7.0.4


--===============7288922334927159930==--

