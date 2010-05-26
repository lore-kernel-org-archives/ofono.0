Content-Type: multipart/mixed; boundary="===============8215833038730123737=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 00/13] misc cleanups and SMS ID API
Date: Wed, 26 May 2010 12:49:14 -0700
Message-ID: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8215833038730123737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Hi All

This set of patches introduce:

 - a few cleanups, code documentations nippets, .gitignore additions,
   header file dependency fixes in smutil.h =


 - adds BUILD_BUG_ON() [linux kernel style], printf-like attribute
   checking for {write,read}_file()

 - make write_file() transaction-safe

 - Introduce the SMS ID API (rfc, still incomplete).

feedback?

Thanks!


The following changes since commit 6b0f2328c5e190053f6a28ed119d01581e2119b3:
  Denis Kenzior (1):
        Update TODO

are available in the git repository at:

  git://gitorious.org/~inakypg/ofono/ofono-inakypg.git master

Patches follow for reviewing convenience.

Inaky Perez-Gonzalez (13):
      Update .gitignore to ignore cscope databases and backup files
      sms_send_message: add a short roadmap
      documentation: add note about referencing standards
      sms_assembly_add_fragment_backup: clarify how insertion spot is found
      util.h: Add BUILD_BUG_ON() and friends for compile-time assert checki=
ng
      smutil.h: add missing header file dependencies
      write_file: make transaction-safe
      storage: add __attribute__((format)) to {write,read}_file() for print=
f-like variable arg verification
      Add function doc headers to ofono_sms_{create,register}
      doc: explain debugging options to -d, add a pointer in -h to manpage
      automake: fix installation of udev rules in VPATH builds
      SMS: introduce message ID API
      SMS: implement SHA256-based message IDs [incomplete]

 .gitignore             |    3 +
 HACKING                |   10 +++
 Makefile.am            |    7 +-
 doc/ofonod.8           |    5 +-
 doc/standards.txt      |    8 ++
 src/main.c             |    4 +-
 src/sms.c              |   69 +++++++++++++---
 src/smsutil.c          |  197 ++++++++++++++++++++++++++++++++++++++++++++
 src/smsutil.h          |   92 +++++++++++++++++++++
 src/storage.c          |   42 +++++++---
 src/storage.h          |    6 +-
 src/util.h             |   29 +++++++
 unit/test-sms-msg-id.c |  212 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 13 files changed, 657 insertions(+), 27 deletions(-)
 create mode 100644 doc/standards.txt
 create mode 100644 unit/test-sms-msg-id.c

--===============8215833038730123737==--

