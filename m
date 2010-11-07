Content-Type: multipart/mixed; boundary="===============8325087920361912422=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] Update TODO.
Date: Sun, 07 Nov 2010 18:42:20 +0100
Message-ID: <1289151740-9922-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1289151740-9922-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8325087920361912422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/TODO b/TODO
index 0d04208..c0dee09 100644
--- a/TODO
+++ b/TODO
@@ -76,6 +76,19 @@ SMS
   Complexity: C4
   Owner: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
 =

+- Asynchronously acknowledge SMS DELIVER messages sent by the SMS driver
+  to core using ofono_sms_deliver_notify().  This may require the struct
+  ofono_sms_driver to be extended with one more function pointer like:
+    void (*deliver_ack)(unsigned char *pdu, int len, cb_t cb, void *data)
+  because currently messages are automatically acknowledged by either the
+  modem (this is the case of some AT modems) or the driver right after
+  ofono_sms_deliver_notify() and a failure to deliver at an upper level is
+  ignored.  The PDU can be an RP-ACK or RP-ERROR message with optional
+  TP-User-Content element, for example if returned from USIM Data Download.
+
+  Priority: Low
+  Complexity: C2
+
 SIM / SIM File system
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

@@ -339,15 +352,6 @@ Sim Toolkit
   Priority: High
   Complexity: C8
 =

-- Support 'SMS-PP' Download Envelope.  Whenever a special type of SMS is
-  received indicating that this is an SMS-PP Download message, this message
-  will be sent to the SIM via an SMS-PP Download Envelope.  No user intera=
ction
-  will be required.  If the modem hardware supports this transparently, th=
en
-  no indication to oFono will be necessary.
-
-  Priority: High
-  Complexity: C2
-
 - Support Language Notification proactive command.
 =

   Priority: Medium
-- =

1.7.1.86.g0e460.dirty


--===============8325087920361912422==--

