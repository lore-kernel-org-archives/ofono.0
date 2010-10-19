Content-Type: multipart/mixed; boundary="===============5123522781523123080=="
MIME-Version: 1.0
From: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
Subject: [PATCH] TODO: Add CDMA support to SMS stack
Date: Tue, 19 Oct 2010 00:23:41 -0700
Message-ID: <1287473021-11521-1-git-send-email-Rajesh.Nagaiah@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5123522781523123080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 3192a46..d8f6397 100644
--- a/TODO
+++ b/TODO
@@ -80,6 +80,32 @@ SMS
   Complexity: C1
   Owner: Kristen Carlson Accardi <kristen@linux.intel.com>
 =

+- Add CDMA support to the SMS stack. The idea is to support only the PDU
+  mode. To start with only Submit and Deliver message handling for WMT
+  teleservice will be added to bring the basic CDMA SMS send and receive
+  functionality.
+
+  Priority: Low
+  Complexity: C8
+  Owner: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
+
+- Add CDMA Delivery(Status) Report handling to the SMS stack.
+
+  Priority: Low
+  Complexity: C4
+  Owner: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
+
+- Add CDMA Voice Mail Notification handling to the SMS stack. In CDMA the
+  Message Waiting indication is notified through a specific teleservice ID
+  VMN. No update to corresponding elementary files required since they are
+  not present in the R-UIM. This will result in the message waiting
+  indication being initially processed within the SMS atom and then being
+  passed for delivery to the message waiting atom. Furthemore note that in
+  CDMA only voice mail type is supported.
+
+  Priority: Low
+  Complexity: C4
+  Owner: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
 =

 SIM / SIM File system
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-- =

1.7.0.4


--===============5123522781523123080==--

