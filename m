Content-Type: multipart/mixed; boundary="===============6109565284320923496=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 2/3] doc: Describe delivered group in storage doc
Date: Thu, 31 May 2012 10:52:55 +0200
Message-ID: <1338454376-12806-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1338454376-12806-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6109565284320923496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/storage.txt |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/doc/storage.txt b/doc/storage.txt
index 8e76382..0aa6d9d 100644
--- a/doc/storage.txt
+++ b/doc/storage.txt
@@ -18,6 +18,7 @@ Meta file Example
 [info]
 read=3Dfalse
 state=3Dnotification
+message_id=3D0123456789ABCDEF


 Meta file Keys/Values details
@@ -31,3 +32,32 @@ state: The message local state, possible values can be:
     - "received": m-Retrieve.Conf PDU downloaded and successfully acknowle=
dged.
     - "draft": m-Send.Req PDU ready for sending.
     - "sent": m-Send.Req PDU successfully sent.
+
+message_id: this is the value provided in the M-Send.conf PDU (assigned by=
 MMSC
+in response to a M-Send.req message), this entry will only be created upon
+M-Send.conf message reception if the delivery report was requested.
+
+For sent messages, a group [delivery_status] could take place in addition =
to
+[info] if delivery report is requested.
+In this group, every recipient has a MMS Delivery status value which can b=
e one
+of the following:
+    - "none": no report has been received yet.
+    - "expired": recipient did not retrieve the MMS before expiration.
+    - "retrieved": MMS successfully retrieved by the recipient.
+    - "rejected": recipient rejected the MMS.
+    - "deferred": recipient decided to retrieve the MMS at a later time.
+    - "indeterminate": cannot determine if the MMS reached its destination.
+    - "forwarded": recipient forwarded the MMS without retrieving it first.
+    - "unreachable": recipient is not reachable.
+
+
+Example of a sent_message meta file with delivery report requested
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+[info]
+state=3Dsent
+message_id=3D0123456789ABCDEF
+
+[delivery_status]
+21345=3Dretrieved
+09876=3Dnone
--
1.7.4.1


--===============6109565284320923496==--

