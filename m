Content-Type: multipart/mixed; boundary="===============7620962531557895719=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 08/20] sms: document the org.ofono.SMSMessage D-Bus interface
Date: Fri, 23 Jul 2010 13:59:56 -0700
Message-ID: <070f79ee2435a9d659652ae117c97fd203e70fe9.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7620962531557895719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

---
 doc/sms-api.txt |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/doc/sms-api.txt b/doc/sms-api.txt
index 1fc32ac..af4baae 100644
--- a/doc/sms-api.txt
+++ b/doc/sms-api.txt
@@ -22,9 +22,27 @@ Methods		dict GetProperties()
 			Possible Errors: [service].Error.InvalidArguments
 					 [service].Error.DoesNotExist
 =

-		void SendMessage(string to, string text)
+		string SendMessage(string destination_number, string text)
 =

-			Send the message in text to the number in to.
+                        Submit a message for delivery /
+                        processing. oFono owns it from now on until
+                        successful delivery, cancellation (by the
+                        user) or cancellation (by oFono). User has to
+                        keep a copy around as oFono only offers
+                        persistence to satisfy its needs.
+
+                        Returns the name of the D-Bus object that
+                        represents said SMS Message.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+                array{string} PendingMessages()
+
+                        Returns a list of SMS Messages that have been
+                        submitted for delivery and that are still
+                        pending.
+
+                        FIXME: currently not implemented
 =

 Signals		PropertyChanged(string name, variant value)
 =

@@ -64,3 +82,30 @@ Properties	string ServiceCenterAddress
 				"ps-preferred" - Use CS if PS is unavailable
 =

 			By default oFono uses "cs-preferred" setting.
+
+
+SMS / Messaging interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+Service		org.ofono
+Interface	org.ofono.SMSMessage
+Object path	[variable prefix]/modemX/message_id
+
+Methods		dict GetProperties()
+
+			Returns a dictionary with the current
+			properties of a message.
+
+                void Cancel()
+
+                        Cancels a pending message's delivery.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string TXState
+
+			Current transmission state.
+
-- =

1.6.6.1


--===============7620962531557895719==--

