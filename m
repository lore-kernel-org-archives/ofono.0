Content-Type: multipart/mixed; boundary="===============6212908465334509970=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 00/12] mmsd: Support Delivery Report notification
Date: Fri, 17 Aug 2012 16:35:01 +0200
Message-ID: <1345214113-25597-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6212908465334509970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches concern mmsd and add delivery report notification support.
Add MMS M-Delivery.ind PDU decoding support.
Update meta file of the sent message to store the received msg_id and to ad=
d a
group [delivery_status] if delivery_report is requested.
Upon MMS M-Delivery.ind PDU reception, update delivery_status recipient ent=
ry
with the received status (this is described in doc/storage.txt) and signal =
the
new delivery_report status for the recipient concerned.
Modify the monitor_mms test script to add report_changed monitoring.
Update message-api.txt doc to describe new ReportChanged signal.

Ronald Tessier (12):
  mmsutil: Define mms_delivery_ind struct
  mmsutil: Decode delivery_ind msg
  service: Store msg_id provided by M-Send.conf PDU
  service: Move mms_address_to_string() up
  service: Add a group [delivery_status] in the msg status
  service: Support M-Delivery.ind in mms_service_push_notify()
  service: Support delivery_ind notif on start
  store: Define MMS_META_UUID_XXX len and suffix
  service: Process delivery_ind notification
  service: Send a delivery changed signal
  test: Add ReportChanged to monitored signals
  doc: Add ReportChanged signal description

 doc/message-api.txt |    7 ++
 src/mmsutil.c       |   22 ++++-
 src/mmsutil.h       |    8 ++
 src/service.c       |  260 ++++++++++++++++++++++++++++++++++++++++++++++-=
----
 src/store.c         |    8 +-
 src/store.h         |    5 +
 test/monitor-mms    |   10 ++
 7 files changed, 292 insertions(+), 28 deletions(-)

--
1.7.9.5


--===============6212908465334509970==--

