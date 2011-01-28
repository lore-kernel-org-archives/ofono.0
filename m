Content-Type: multipart/mixed; boundary="===============4860700125324193851=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [ss-notify FYI 6/6] Document notifications in voicecall-api.txt.
Date: Fri, 28 Jan 2011 19:38:19 +0200
Message-ID: <1296236300-19189-7-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1296236300-19189-6-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4860700125324193851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/voicecall-api.txt |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 047b8cb..aae0867 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -56,6 +56,33 @@ Signals		PropertyChanged(string property, variant value)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

+		JoinedMultiparty()
+
+			Signal is emitted when remote party joins the
+			call into a multiparty conference.  Not that
+			there is no corresponding event when call is
+			split from the multiparty conference.
+
+		Waiting()
+
+			Signal is emitted when an outgoing call is waiting.
+
+		OutgoingBarred()
+
+			Signal is emitted when caller's outgoing barring
+			services prevent call from being connected.
+
+			This signal is usually emitted while an
+			announcement is played.
+
+		IngomingBarred()
+
+			Signal is emitted when callee's incoming barring
+			services prevent call from being connected.
+
+			This signal is usually emitted while an
+			announcement is played.
+
 		DisconnectReason(string reason)
 =

 			This signal is emitted when the modem manager can
@@ -105,11 +132,16 @@ Properties	string LineIdentification [readonly]
 		boolean Multiparty [readonly]
 =

 			Contains the indication if the voice call is part
-			of a multiparty call or not.
+			of a multiparty call set up by user or not.
 =

 			Notifications if a call becomes part or leaves a
 			multipart call are sent.
 =

+		boolean OnHold [readonly]
+
+			Contains the indication if the remote party has
+			put call on hold.
+
 		string State [readonly]
 =

 			Contains the state of the current call.  The state
-- =

1.7.1


--===============4860700125324193851==--

