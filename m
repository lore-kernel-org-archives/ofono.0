Content-Type: multipart/mixed; boundary="===============8026698472188330637=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 0/6] mmsd: support delivery_ind notification
Date: Wed, 12 Sep 2012 15:55:07 +0200
Message-ID: <1347458113-29039-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8026698472188330637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches concern mmsd and add support for delivery report notification.
I splitted the old "Process delivery_ind notification" patch in 2 parts to =
use
MMS_META_UUID_SUFFIX in a separate patch and process delivery_ind notificat=
ion
in the other one.
The ReportChanged signal documentation now comes before its implementation =
in
the serie. Furthermore, the signal now sends a global status
(delivered/partially_delivered/not_delivered) with the details as a diction=
ary.

Ronald Tessier (6):
  service: Use MMS_META_UUID_SUFFIX
  mmsutil: Decode delivery_ind msg
  service: Process delivery_ind notification
  doc: Add ReportChanged signal description
  test: Add ReportChanged to monitored signals
  service: Send a delivery changed signal

 doc/message-api.txt |    8 ++
 src/mmsutil.c       |   21 ++++-
 src/service.c       |  231 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 test/monitor-mms    |   13 +++
 4 files changed, 268 insertions(+), 5 deletions(-)

--
1.7.9.5


--===============8026698472188330637==--

