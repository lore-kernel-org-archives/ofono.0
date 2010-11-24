Content-Type: multipart/mixed; boundary="===============5329431657154004631=="
MIME-Version: 1.0
From: ext-arun.1.ravindran@nokia.com
Subject: [PATCH] Doc Update voicecallmanager-api.txt
Date: Wed, 24 Nov 2010 16:56:11 +0200
Message-ID: <1290610571-17684-1-git-send-email-ext-arun.1.ravindran@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5329431657154004631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>

---
 doc/voicecallmanager-api.txt |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index d960f3c..a4048d2 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -5,7 +5,14 @@ Service		org.ofono
 Interface	org.ofono.VoiceCallManager
 Object path	[variable prefix]/{modem0,modem1,...}
 =

-Methods		array{object,dict} GetCalls()
+Methods		dict GetProperties()
+
+			Returns properties for the VoiceCallManager Interface.
+			See the properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		array{object,dict} GetCalls()
 =

 			Get an array of call object paths and properties
 			that represents the currently present calls.
-- =

1.7.0.4


--===============5329431657154004631==--

