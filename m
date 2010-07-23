Content-Type: multipart/mixed; boundary="===============8775686820025562565=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 00/20] SMS D-Bus support and misc small patches
Date: Fri, 23 Jul 2010 13:59:48 -0700
Message-ID: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8775686820025562565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This (3rd? 4th?) version of the patchset builds the D-Bus support on
top of the new _txq_submit() callback mechanism.

Note there are still a couple of opens that need discussion:

 - the message ID is generated based on the contents of the message --
   thus, the current way doesn't work. We need the caller to
   _txq_submit() to generate it. It's been left out of the STK
   stc.c:handle_command_send_sms() because I am not sure what is the
   right way to do it -- need feedback on that.

 - The generation of the SMS message ID based on contents still has
   shortcomings: if we submit two messages with the same content and
   destination number, the ID is the same [sms.c:sms_msg_send()]. What
   other factor would make sense to add? time?

The following changes since commit 94344e967b4cd3edd65aa5254ef4b4f5dd037e69:
  Denis Kenzior (1):
        TODO: Major updates to STK related tasks

are available in the git repository at:

  git://gitorious.org/~inakypg/ofono/ofono-inakypg.git master

Patches follow for reviewing convenience.

Inaky Perez-Gonzalez (20):
      bug.h: Add BUILD_BUG_ON() and friends for compile-time assert checking
      write_file: make transaction-safe
      manpage: explain debugging options to -d
      SMS: introduce message ID API
      introduce DECLARE_SMS_ADDR_STR()
      _assembly_encode_address: export and rename
      SMS: implement SHA256-based message IDs [incomplete]
      sms: document the org.ofono.SMSMessage D-Bus interface
      SMS: document handle_sms_status_report()
      sms_text_prepare: document @use_delivery_reports
      SMS: rename create_tx_queue_entry() to tx_queue_entry_new()
      struct tx_queue_entry: add a destructor
      SMS: encapsulate D-Bus specific data in 'struct sms_msg_dbus_data'
      SMS: introduce bare state machine and transitions
      SMS: introduce Wait-for-Status-Report state and infrastructure
      SMS: introduce a state change callback for TX messages
      SMS: export outgoing messages over D-Bus
      SMS: send D-Bus SMS-MSG::PropertyChanged signals when message changes=
 status
      SMS: introduce sms_msg_cancel and its D-Bus wrapper
      SMS: Implement D-Bus SMS-MSG::GetProperties

 HACKING                        |   10 +
 Makefile.am                    |    5 +-
 doc/ofonod.8                   |    5 +-
 doc/sms-api.txt                |   49 ++++-
 src/bug.h                      |   50 ++++
 src/ofono.h                    |   42 +++-
 src/sms.c                      |  598 ++++++++++++++++++++++++++++++++++--=
----
 src/smsutil.c                  |  206 ++++++++++++++-
 src/smsutil.h                  |  122 ++++++++
 src/stk.c                      |   24 ++-
 src/storage.c                  |   42 ++-
 test/test-sms-msg-cancel       |  173 ++++++++++++
 test/test-sms-msg-state-change |   24 ++
 unit/test-sms-msg-id.c         |  212 ++++++++++++++
 14 files changed, 1449 insertions(+), 113 deletions(-)
 create mode 100644 src/bug.h
 create mode 100755 test/test-sms-msg-cancel
 create mode 100755 test/test-sms-msg-state-change
 create mode 100644 unit/test-sms-msg-id.c

--===============8775686820025562565==--

