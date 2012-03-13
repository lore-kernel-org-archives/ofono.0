Content-Type: multipart/mixed; boundary="===============7149169526527428377=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 1/1] TODO: remove completed tasks
Date: Tue, 13 Mar 2012 17:57:27 +0100
Message-ID: <1331657847-2658-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1331657847-2658-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7149169526527428377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 TODO |   59 -----------------------------------------------------------
 1 files changed, 0 insertions(+), 59 deletions(-)

diff --git a/TODO b/TODO
index c202d13..42e25a6 100644
--- a/TODO
+++ b/TODO
@@ -19,42 +19,7 @@ Background
 MMS Submission
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- Add HTTP GWeb POST request support.
-  This feature integration should be consistent with what has already be d=
one
-  for the HTTP GWeb GET request support.
-
-  Priority: High
-  Complexity: C2
-  Owner: Sebastien Bianti <sebastien.bianti@linux.intel.com>
-
-- Add MMS M-Send.Req PDU encoding support.
-  The M-Send.Req PDU has to be encoded from the data retrieved in the
-  mms_message structure into a temporary file. The encoding has to be
-  consistent with the encoding of the already existing M-NotifyResp.Ind PDU
-  encoding implementation.
-
-  Priority: High
-  Complexity: C2
-  Owner: Ronald Tessier <ronald.tessier@linux.intel.com>
-
 - Add MMS submit support.
-  Upon the reception of a Dbus Service: SendMessage Request, the mms_messa=
ge
-  structure is filled with the information extracted from the D-Bus reques=
t.
-  A new D-Bus MMS message object is registered, and a Dbus Service Signal
-  =E2=80=9CMessageAdded=E2=80=9D is emitted. This implementation needs to =
be completed with the
-  the encoding of a M-Send-Req PDU (requires to generate a transaction id),
-  its addition to the store and the creation of a new entry in the META fi=
le
-  (status: draft). A HTTP POST request must be initiated to send the M-Sen=
d-Req
-  PDU to the MMSC. The HTTP POST request callback has to be implemented to
-  process the request result.
-  If the HTTP POST request is completed successfully, the HTTP POST respon=
se
-  result file (M-Send.Conf) PDU must be decoded to get the request result
-  (a message id should also be provided in this case, and may be stored in=
 the
-  META information), if the submit request has been accepted by the MMSC t=
he
-  META file entry for the M-Send-Req must be updated (status: draft -> sen=
t),
-  the MMS message object status property changed (status: draft -> sent) a=
nd
-  the Dbus Service: SendMessage Request asynchronous reply sent back to the
-  caller.
   In case of error (HTTP communication error, MMSC rejection of the submit
   request), the SendMessage Request asynchronous reply should also be sent=
 with
   the appropriate DBus error status (see __mms_error_XXXX).
@@ -69,23 +34,6 @@ MMS Reception
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

 - Add MMS Automatic Retrieval support.
-  Add the M-Notify.Ind PDU entry to the META file (status: notify.ind).
-  Initiate a HTTP GET Request with the "Content Location" URI provided in =
the
-  M-Notify.Ind PDU.
-  Implement the HTTP GET request callback to process the request result.
-  if the the HTTP GET operation is completed successfully, the retrieved
-  M-Retrieve.Conf PDU file has to be parsed and added to the store.
-  META file has to be updated too: the M-Notify.Ind PDU entry has to be re=
moved
-  and a new entry for the M-Retrieve.Conf PDU has to be created
-  (status: retrieve.conf).
-  In order to complete the transaction a M-NotifyResp.ind PDU must be enco=
ded
-  with the "retrieved" status and the M-Notify.Ind PDU transaction ID.
-  This PDU has to be temporarily stored.
-  A HTTP POST request must be initiated to send the M-NotifyResp.ind PDU t=
o the
-  MMSC. If the HTTP POST request is completed successfully the META file e=
ntry
-  for the M-Retrieve.Conf PDU has to be updated (status: retrieve.conf ->
-  received), a DBus Message object has to be registered (see =

-  mms_message_register()) and the Dbus Service Signal =E2=80=9CMessageAdde=
d=E2=80=9D emitted.
   Error cases should handled and reported to the application layer.
 =

   Priority: High
@@ -112,13 +60,6 @@ MMS Storage
 D-Bus API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- Add the "org.ofono.mms.Message" interface implementation.
-  The D-Bus Message API documentation is available under /doc/message-api.=
txt.
-
-  Priority: High
-  Complexity: C2
-  Owner: Ronald Tessier <ronald.tessier@linux.intel.com>
-
 - Add the "org.ofono.mms.Service" interface "GetConversation" method =

   implementation.
   The D-Bus Message API documentation is available under /doc/service-api.=
txt.
-- =

1.7.4.4


--===============7149169526527428377==--

