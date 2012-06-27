Content-Type: multipart/mixed; boundary="===============7576237124651756845=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 5/6] phonesim: Add support for USSD answer
Date: Wed, 27 Jun 2012 17:10:44 +0200
Message-ID: <1340809845-26595-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1340809845-26595-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7576237124651756845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/default.xml |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/default.xml b/src/default.xml
index 7eabfbe..9a6c8c6 100644
--- a/src/default.xml
+++ b/src/default.xml
@@ -2009,6 +2009,13 @@
 </chat>
 =

 <chat>
+    <!-- USSD answer that is supported by the network -->
+    <command>AT+CUSD=3D1,"response",15</command>
+    <response>+CUSD: 0,"Thank you.",15\n\nOK</response>
+    <set name=3D"USD" value=3D"1"/>
+</chat>
+
+<chat>
     <!-- SAT initiated 7-Bit USSD query that is supported by the network -=
->
     <command>AT+CUSD=3D1,"ABCD",240</command>
     <response>+CUSD: 0,"USSD string received from SS",240\n\nOK</response>
-- =

1.7.9.5


--===============7576237124651756845==--

