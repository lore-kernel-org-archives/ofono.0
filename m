Content-Type: multipart/mixed; boundary="===============9141376026048693363=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 0/3] Persist TX SMS messages 
Date: Wed, 24 Nov 2010 14:53:19 -0800
Message-ID: <1290639202-12221-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9141376026048693363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series implements a method of persisting pending
outgoing sms messages on disk.  Once an sms message has
been submitted to the transmit queue, each pdu in the
message is stored on disk until the driver indicates that
it has been sent.

Each tx_queue_entry is given an id number that represents
it's order in the queue.  A subdirectory per entry is
created as id-uuid, in order to preserve order when the
queue is loaded in the event of a crash.  Within each
subdirectory, each pdu is saved in order by sequence
number.

When an sms driver is ready for operation, the disk will
be scanned for any saved pending tx sms messages.  If there
are any found, they will be loaded from disk and placed
into the queue in order.

Kristen Carlson Accardi (3):
  sms: store pending tx pdus on disk
  sms: delete sent sms messages from backup
  sms: restore pending tx messages from backup

 src/ofono.h   |    1 +
 src/sms.c     |   64 ++++++++++++++++++++
 src/smsutil.c |  180 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |   13 ++++
 4 files changed, 258 insertions(+), 0 deletions(-)

-- =

1.7.2.3


--===============9141376026048693363==--

