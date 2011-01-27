Content-Type: multipart/mixed; boundary="===============2991239184634928487=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC] voicecallmanager-api: call related SS signals (proposal)
Date: Thu, 27 Jan 2011 12:20:50 +0200
Message-ID: <e514ceea10c7e8eb0f8d556e9764ea4e0c9abe04.1296122953.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1296122953.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2991239184634928487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is a proposal for expanding VoiceCallManager's DBus interface with =

call related Supplementary Services signals.
The implementation would be based on the functionality provided by the SSN
atom (handling the CSSU codes). =


---
 doc/voicecallmanager-api.txt |   54 ++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 2bf9ded..5212eac 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -123,7 +123,59 @@ Methods		dict GetProperties()
 			'*', '#', 'A', 'B', 'C', 'D'.  The last four are
 			typically not used in normal circumstances.
 =

-Signals		CallAdded(object path, dict properties)
+Signals		CallForwarded(object path)
+
+			Signal sent during call setup when the incoming call is
+			a forwarded call. The signal contains the object path of
+			the call in cause.
+
+		ClosedUserGroupCall(object path, int32 index)
+
+			Signal sent during call setup when the incoming call is
+			a Closed User Group call. Since the user may belong to
+			multiple groups, the index indicates the group that is
+			applied to the incoming call.
+
+		CallOnHold(object path)
+
+			Signal sent during voice call when a call has been put
+			on hold by the remote party.
+
+		HoldRetrieved(object path)
+
+			Signal sent during voice call when the call has been
+			retrived from held state by the remote party.
+
+		MulipartyCall(object path)
+
+			Signal sent during voice call when a call has been
+			added to a multiparty/conference call.
+
+		HoldReleased(object path)
+
+			Signal sent during voice call when a call put earlier on
+			hold has been released.
+
+		CallForwardCheck()
+
+			Signal sent when a forward check message has been received.
+
+		CallInTransfer(object path)
+
+			Signal sent during voice call with the remote party in
+			alerting state in explicit call transfer operation.
+
+		CallTransferred(object path)
+
+			Signal sent when the call has been connected with the
+			remote party in explicit call transfer operation.
+
+		CallDeflected(object path)
+
+			Signal sent during call setup when the incoming call is
+			a deflected call.
+
+		CallAdded(object path, dict properties)
 =

 			Signal that is sent when a new call is added.  It
 			contains the object path of the new voice call and
-- =

1.7.0.4


--===============2991239184634928487==--

