Content-Type: multipart/mixed; boundary="===============8490756255719991111=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 00/17] pull request
Date: Thu, 05 Aug 2010 17:55:22 -0700
Message-ID: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8490756255719991111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

v5 (there have been more than five submissions, but whatever) contains
the following changes as requested by Dennis:

- multi fragment message ref and the unique message ID are decoupled
  now. this allows...

- UUID is generated in tx_queue_entry_new()

- UUID is expanded to 32-bits from 16 bits


Catchas

- UUID is not used in the RX path yet, the old mechanism
  (sms->next_msg_id) is still in place

- __ofono_sms_txq_submit() still has to be modified. No better
  alternatives have been proposed.


The following changes since commit f01de438bd4f834a27f9c36e74e6a1067f778a21:
  Jo=C3=A3o Paulo Rechi Vita (1):
        huawei: Fix SIM state logic

are available in the git repository at:

  git://gitorious.org/~inakypg/ofono/ofono-inakypg.git master

Patches follow for reviewing convenience.

Inaky Perez-Gonzalez (17):
      sms: replace sequential SMS message ID with hash
      sms: _txq_submit() returns pointer to object
      sms: document the org.ofono.SmsMessage interface
      sms: document handle_sms_status_report()
      sms: introduce bare state machine and transitions
      sms: introduce the Wait-for-Status-Report state
      sms: introduce a state change callback for messages
      sms: export outgoing messages over D-Bus
      sms: send PropertyChanged signals on state change
      sms: introduce sms_msg_cancel and its D-Bus wrapper
      sms: Implement D-Bus SMS-MSG::GetProperties
      sms: document SMS Message's D-Bus 'To' property
      sms: test code for message's D-Bus GetProperties
      automake: fix generation of symlinks for headers
      sms: document variable usage in sms_msg_send()
      sms: add test case for message cancel
      sms: add test case for state change signals

 Makefile.am                      |    2 +-
 doc/sms-api.txt                  |   54 ++++-
 src/ofono.h                      |   46 +++-
 src/sms.c                        |  576 ++++++++++++++++++++++++++++++++++=
----
 src/stk.c                        |   19 ++-
 test/test-sms-msg-cancel         |  173 ++++++++++++
 test/test-sms-msg-get-properties |   26 ++
 test/test-sms-msg-state-change   |   24 ++
 8 files changed, 852 insertions(+), 68 deletions(-)
 create mode 100755 test/test-sms-msg-cancel
 create mode 100755 test/test-sms-msg-get-properties
 create mode 100755 test/test-sms-msg-state-change

--===============8490756255719991111==--

