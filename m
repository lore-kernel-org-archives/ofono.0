Content-Type: multipart/mixed; boundary="===============0868465484598847857=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 1/3] TODO: Add new tasks
Date: Mon, 21 May 2012 17:59:21 +0200
Message-ID: <1337615963-9443-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1337615963-9443-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0868465484598847857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index a4330b3..6e54f6f 100644
--- a/TODO
+++ b/TODO
@@ -16,6 +16,73 @@ Background
   once the task is better understood.
 =

 =

+MMS Delivery Report
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Add delivery report request when sending message.
+  Modify SendMessage D-Bus API to add delivery report request flag.
+  Update message structure to manage this flag.
+  Modify MMS M-Send.Req PDU encoder to encode delivery report request.
+  Modify test script related to message sending to support new delivery fl=
ag.
+
+  Priority: Medium
+  Complexity: C2
+  Owner: Ronald Tessier <ronald.tessier@linux.intel.com>
+
+- Update message status stored in its associated Meta file.
+  Add a group [delivery_status] in the message status to handle delivery
+  reports, this group contains an entry for each message recipients.
+  Each recipient entry will be updated when the corresponding report will =
be
+  received and then remove the temporary stored delivery report.
+  Upon M-Send.Conf reception, store the received Message_ID to match deliv=
ery
+  reports (needed only if delivery report was requested).
+
+  Priority: Medium
+  Complexity: C2
+  Depends:
+  Owner: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>
+
+- Add MMS M-Delivery.ind PDU decoding support.
+  Modify mms_service_push_notify() to handle MMS Delivery Report WAP Push
+  notification and temporary store the M-Delivery.ind PDU.
+  Decode M-Delivery.ind PDU.
+  Add MMS M-Delivery.ind PDU sample PDU to unit test.
+
+  Priority: Medium
+  Complexity: C2
+  Depends:
+  Owner: Ronald Tessier <ronald.tessier@linux.intel.com>
+
+- Update message Meta file.
+  Upon MMS M-Delivery.ind PDU reception, update delivery_status recipient =
entry
+  with the received status (this is described in doc/storage.txt).
+
+  Priority: Medium
+  Complexity: C2
+  Depends:
+  Owner: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>
+
+
+D-Bus API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Add the "org.ofono.mms.Service" interface "DeleteMessages" method
+  implementation.
+  The D-Bus Message API documentation is available under /doc/service-api.=
txt.
+
+  Priority: Medium
+  Complexity: C2
+  Owner: S=C3=A9bastien Bianti <sebastien.bianti@linux.intel.com>
+
+- Add the "org.ofono.mms.Service" interface "DeleteConversation" method
+  implementation.
+  The D-Bus Message API documentation is available under /doc/service-api.=
txt.
+
+  Priority: Medium
+  Complexity: C2
+  Owner: Ronald Tessier <ronald.tessier@linux.intel.com>
+
+
 Miscellaneous
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.4.1


--===============0868465484598847857==--

