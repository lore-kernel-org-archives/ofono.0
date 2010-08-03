Content-Type: multipart/mixed; boundary="===============8454838790640459101=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 00/19] pull request
Date: Tue, 03 Aug 2010 16:50:49 -0700
Message-ID: <cover.1280879410.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8454838790640459101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

- UUID code reworked, simplified to Dennis' suggestion

- UUID code integrated -- still kind of incomplete because we need to
  see what to do when the message contents and destination number is
  the same.

- BUG_ON* removed, not used anymore

- removed 'struct sms_msg_dbus_data', pass around 'dbus_path' as
  private data.

- D-Bus: =


  number of PDUs not longer part of the D-Bus name

  added 'To' to the D-Bus properties; ignored for now
  submittion/delivery times as it will complicate the interface -- we
  need another callback for property change specification. Is it worth
  it?

  Fixed GetProperties method mistakenly marked ASYNC

  Interface renamed to SmsManager

  Cleaned up doc/sms-api.txt according to feedback

- unfolded tx_queue_entry_destroy_free  into
  tx_queue_entry_free_foreach() and tx_queue_entry_free() according to
  feedback. =


- broke up multi-directory commits

- cleaned up style violations

- add a fix to generation of symlinks for headers, it broke in VPATH
  builds.

The following changes since commit 6f1ab8b6794333673fefc3d52f9b0388526a56cd:
  Kristen Carlson Accardi (1):
        test-stkutil: unit test for img to xpm converter

are available in the git repository at:

  git://gitorious.org/~inakypg/ofono/ofono-inakypg.git master

Patches follow for reviewing convenience.

Inaky Perez-Gonzalez (19):
      write_file: make transaction-safe
      sms: introduce message ID API
      sms: implement SHA256-based message IDs [incomplete]
      sms: document the org.ofono.SmsMessage interface
      sms: document handle_sms_status_report()
      struct tx_queue_entry: add a destructor
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
 src/ofono.h                      |   45 +++-
 src/sms.c                        |  581 ++++++++++++++++++++++++++++++++--=
----
 src/smsutil.c                    |   78 +++++
 src/smsutil.h                    |    8 +
 src/stk.c                        |   22 ++-
 src/storage.c                    |   47 +++-
 test/test-sms-msg-cancel         |  173 +++++++++++
 test/test-sms-msg-get-properties |   26 ++
 test/test-sms-msg-state-change   |   24 ++
 11 files changed, 951 insertions(+), 109 deletions(-)
 create mode 100755 test/test-sms-msg-cancel
 create mode 100755 test/test-sms-msg-get-properties
 create mode 100755 test/test-sms-msg-state-change

--===============8454838790640459101==--

