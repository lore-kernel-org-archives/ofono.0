Content-Type: multipart/mixed; boundary="===============5456721999778921589=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 00/23] Exports SMS over D-Bus and mis cleanups
Date: Fri, 25 Jun 2010 16:15:22 -0700
Message-ID: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5456721999778921589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Hi All

This patchset is the current state of my tree that changes the D-Bus
interface for SMS:

 - adds object based management of SMS messages

 - adds a cancelation operation for in-transit / pending messages

 - holds messages waiting for acknoledgement (delivery report) -- this
   is still not fully integrated with the code that was commited last
   days (thus once the delivery arrives the message is not
   automatically cleaned up as "confirmed").

 - generates truly unique SMS message IDs using hashing of contents
   and receiver address

 - miscelaeous small cleanups / additions, carryover from a previous
   submit that got neither not acked or no resolution was agreed upon

Please review and suggest what else needs to be done / changed.

Thx,


The following changes since commit 1fedd096a0ba2ce8625a9e4d1c2ce25bb8f6dfe4:
  Marcel Holtmann (1):
        Check sanity the MNC length value from the SIM card

are available in the git repository at:

  git://gitorious.org/~inakypg/ofono/ofono-inakypg.git master

Patches follow for reviewing convenience.

Inaky Perez-Gonzalez (23):
      documentation: add note about referencing standards
      util.h: Add BUILD_BUG_ON() and friends for compile-time assert checki=
ng
      smutil.h: add missing header file dependencies
      write_file: make transaction-safe
      doc: explain debugging options to -d, add a pointer in -h to manpage
      SMS: introduce message ID API
      introduce DECLARE_SMS_ADDR_STR()
      export sms_assembly_encode_address
      SMS: implement SHA256-based message IDs [incomplete]
      sms: add doc about the extensions D-Bus API (not yet implemented)
      struct tx_queue_entry: add fields and destructor
      SMS: produce a unique, persistent name for in-transit messages
      SMS: introduce bare state machine and transitions
      SMS: export outgoing messages over D-Bus (skeleton)
      SMS: split sms_send_message() into a D-Bus front end and an internal =
API
      SMS: introduce wait-for-ack state and infrastructure
      SMS: introduce sms_msg_cancel and its D-Bus wrapper
      SMS: rename tx_queue_entry->msg to ->dbus_msg for clarity
      SMS: Implement D-Bus SMS-MSG::GetProperties
      SMS: send D-Bus SMS-MSG::ProperyChanged signals when message changes =
status
      SMS: make D-Bus SendMessage and Cancel fully synchronous
      SMS: set the SRR bit in outgoing PDUs if WFA is requested
      sms_text_prepare: document @use_delivery_reports

 HACKING                        |   10 +
 Makefile.am                    |    5 +-
 doc/ofonod.8                   |    5 +-
 doc/sms-api.txt                |   94 ++++++++
 doc/standards.txt              |    8 +
 src/main.c                     |    4 +-
 src/sms.c                      |  512 +++++++++++++++++++++++++++++++++++-=
----
 src/smsutil.c                  |  202 ++++++++++++++++-
 src/smsutil.h                  |  125 ++++++++++
 src/storage.c                  |   42 +++-
 src/util.h                     |   28 +++
 test/test-sms-msg-state-change |   24 ++
 unit/test-sms-msg-id.c         |  212 +++++++++++++++++
 13 files changed, 1199 insertions(+), 72 deletions(-)
 create mode 100644 doc/standards.txt
 create mode 100755 test/test-sms-msg-state-change
 create mode 100644 unit/test-sms-msg-id.c

--===============5456721999778921589==--

