Content-Type: multipart/mixed; boundary="===============7806197682268104633=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH v2] TODO: CDMA SMS and CDMA CMAS
Date: Mon, 20 Dec 2010 14:18:03 -0800
Message-ID: <1292883483-8493-1-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <Yes>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7806197682268104633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++------------=
---
 1 files changed, 89 insertions(+), 27 deletions(-)

diff --git a/TODO b/TODO
index d40c0ff..ee32e34 100644
--- a/TODO
+++ b/TODO
@@ -49,33 +49,6 @@ SMS
   Complexity: C1
   Owner: Kristen Carlson Accardi <kristen@linux.intel.com>
 =

-- Add CDMA support to the SMS stack. The idea is to support only the PDU
-  mode. To start with only Submit and Deliver message handling for WMT
-  teleservice will be added to bring the basic CDMA SMS send and receive
-  functionality.
-
-  Priority: Low
-  Complexity: C8
-  Owner: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
-
-- Add CDMA Delivery(Status) Report handling to the SMS stack.
-
-  Priority: Low
-  Complexity: C4
-  Owner: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
-
-- Add CDMA Voice Mail Notification handling to the SMS stack. In CDMA the
-  Message Waiting indication is notified through a specific teleservice ID
-  VMN. No update to corresponding elementary files required since they are
-  not present in the R-UIM. This will result in the message waiting
-  indication being initially processed within the SMS atom and then being
-  passed for delivery to the message waiting atom. Furthemore note that in
-  CDMA only voice mail type is supported.
-
-  Priority: Low
-  Complexity: C4
-  Owner: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
-
 - Asynchronously acknowledge SMS DELIVER messages sent by the SMS driver
   to core using ofono_sms_deliver_notify().  This may require the struct
   ofono_sms_driver to be extended with one more function pointer like:
@@ -529,3 +502,92 @@ CDMA Voicecall
   Priority: High
   Complexity: C2
   Owner: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
+
+CDMA SMS
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Support CDMA SMS stack in PDU mode. This includes basic support of
+  SMS Point-to-Point Message, SMS Broadcast Message and SMS Acknowledge
+  Message as per 3GPP2 C.S0015-B version 2.0.
+
+  Priority: High
+  Complexity: C4
+
+- Support sending Wireless Messaging Teleservice (WMT) Submit Message and
+  receiving WMT Deliver Messsage as defined 3GPP2 C.S0015-B version 2.0.
+
+  Priority: High
+  Complexity: C4
+
+- Support Delivery Acknowledgment. oFono allows requesting of CDMA SMS
+  Delivery Acknowledgment via the MessageManager's
+  UseDeliveryAcknowledgement property. If enabled, oFono's CDMA SMS stack
+  will encode the Reply Option subparameter in the Submit message and
+  process incoming SMS Delivery Acknowledgment Message. oFono will notify
+  UI either via DBus or history plugin API.
+
+  Priority: Medium
+  Complexity: C2
+
+- Support receiving Voice Mail Notification (VMN) Teleservice Deliver
+  message. CDMA network uses VMN Teleservice to deliver the number of
+  messages stored at the Voice Mail System to the CDMA mobile subscriber.
+
+  Priority: High
+  Complexity: C4
+
+- Support sending Wireless Enhanced Messaging Teleservice (WEMT) Submit
+  Message and receiving WEMT Deliver Messsage as defined 3GPP2 C.S0015-B
+  version 2.0.
+
+  WMT does not support message fragmentation thus can not be used to for
+  long message. WEMT is devised to support long message and Enhanced
+  Messaging Service (EMS). The WEMT SMS message's CHARi field of the
+  subparameter User Data encapsulate GSM-SMS TP-User Data as defined in
+  Section 9.2.3.24 of 3GPP TS 23.040.
+
+  Priority: Medium
+  Complexity: C4
+
+- Support sending Wireless Application Protocol (WAP) Teleservice Submit
+  Message and receiving WAP Deliver Messsage as defined 3GPP2 C.S0015-B
+  version 2.0.
+
+  Priority: Medium
+  Complexity: C4
+
+- Support Call-Back Number. The Call-Back Number subparameter indicates
+  the number to be dialed in reply to a received SMS message.
+
+  In transmit direction, oFono allows setting of Call-Back Number. If the
+  Call Back Number property is set, CDMA SMS stack will encode Call-Back
+  Number subparameter in the Submit Message.
+
+  In receiving direction, oFono will process the Call-Back Number
+  subparameter in the incoming Deliver Message and notify UI of the
+  Call-Back Number together with the newly received text message.
+
+  Priority: Medium
+  Complexity: C2
+
+- Support immediately displayed message. oFono CDMA SMS stack will
+  process the optional Message Display Mode subparameter in the incoming
+  SMS message. If Message Display Mode subparameter indicates the
+  message display mode is Immediate Display, oFono will send
+  ImmediateMessage signal, otherwise oFono will send IncomingMessage
+  signal.
+
+  Priority: Medium
+  Complexity: C2
+
+
+CDMA CMAS
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Support Commercial Mobile Alert Service (CMAS) over CDMA systems. CMAS
+  over CDMA system is defined in TIA-1149. The CMAS message is carried in
+  the CHARi field of the User Data subparameter of CDMA SMS Broadcast
+  message.
+
+  Priority: Medium
+  Complexity: C4
-- =

1.7.0.4


--===============7806197682268104633==--

