Content-Type: multipart/mixed; boundary="===============4090146496088725779=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2] TODO: Add CDMA Voicecall Support Tasks
Date: Fri, 10 Dec 2010 15:42:52 -0800
Message-ID: <1292024572-12102-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4090146496088725779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 8d771d6..cbcdac5 100644
--- a/TODO
+++ b/TODO
@@ -484,3 +484,61 @@ Miscellaneous
   Priority: Medium
   Complexity: C2
   Owner: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
+
+CDMA Voicecall
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Add support for Mobile Originated and Mobile Terminated Voice Call over
+  a CDMA network. This includes management of call state and providing
+  appropriate values for the LineIdentification in each case.
+
+  Priority: High
+  Complexity: C2
+  Owner: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
+
+- Add support for Three-Way Calling over a CDMA network. Three-Way Calling
+  provides the subscriber with the capability to add a third party to an
+  established two-party call, so that all three parties may communicate in=
 a
+  three-way call.
+
+  In CDMA mode, the originating subscriber of a current conversation can
+  request for a third party to be added to a conversation by sending a Fla=
sh
+  With Information Message (FWIM) with dialed digits to the network. Upon
+  setting up a two-way conversation with the added party, the originating
+  subscriber can request to establish a three-way conversation by sending
+  another Flash With Information Message. Upon receiving the second Flash =
With
+  Information Message, the MSC reconnects the original party to the
+  conversation thus completing the setup of a three-way conversation.
+
+  CDMA Three-Way Calling is described by Figure B-5 in 3GPP2 C.S0005-E Ver=
sion
+  2.0.
+
+  Priority: High
+  Complexity: C2
+  Owner: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
+
+- Add support for Call Waiting over a CDMA network. Call Waiting (CW) prov=
ides
+  notification of an incoming call to an originating subscriber, while the
+  subscriber's call is in the 2-way state. Subsequently, the originating
+  subscriber can either answer or ignore the incoming call. If the origina=
ting
+  subscriber answers the second call, it may alternate between the two cal=
ls.
+
+  In CDMA mode, the originating subscriber of a current conversation will
+  receive either a Flash With Information Message or an Alert With Informa=
tion
+  Message from the network if there is an additional mobile terminated voi=
ce
+  call incoming. The originating subscriber can change conversation partie=
s by
+  sending a Flash With Information Message to the network and the MSC will
+  toggle the speech path between the two conversations.
+
+  CDMA Call Waiting is described by Figure B-6 in 3GPP2 C.S0005-E Version
+  2.0.
+
+  Priority: High
+  Complexity: C2
+  Owner: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
+
+- Support sending DTMF tones over CDMA network.
+
+  Priority: High
+  Complexity: C2
+  Owner: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
-- =

1.7.0.4


--===============4090146496088725779==--

