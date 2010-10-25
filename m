Content-Type: multipart/mixed; boundary="===============0957415742812382840=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Call counters proposal (TODO patch)
Date: Mon, 25 Oct 2010 16:02:32 +0300
Message-ID: <4CC57FE8.3030009@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0957415742812382840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am proposing adding Call counters to Voicecall. Here is the TODO patch:

diff --git a/TODO b/TODO
index d9a6580..89e180c 100644
--- a/TODO
+++ b/TODO
@@ -329,6 +329,15 @@ Voicecall
    Complexity: C2
    Owner: Pekka Pessi <pekka.pessi@nokia.com>

+- Call counters. Provide total outgoing and incoming call duration =

information.
+  Separate call counters will be maintained for each SIM card. Call =

counters
+  can be read and reset to 0, and must be backed up periodically to a
+  non-volatile storage place.
+
+  Priority: Medium
+  Complexity: C2
+  Owner: Andras Domokos <andras.domokos@nokia.com>
+


--===============0957415742812382840==--

