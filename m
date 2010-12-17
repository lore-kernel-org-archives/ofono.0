Content-Type: multipart/mixed; boundary="===============3705044721205186868=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2 0/9] Add CDMA MO Call Support
Date: Fri, 17 Dec 2010 15:11:12 -0800
Message-ID: <1292627481-9109-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3705044721205186868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Submitting new versions for review comments.

This set of patches introduces the foundation for CDMA Voicecall support in
oFono. They cover making a simple MO call over a CDMA network, including ca=
ll
state management, LineIdentification, dialing and hanging up through the
cdma-voicecall atom DBus interface. =

Currently, the implemented call states available are "dialing" and
"disconnected", initiated on dialing and hanging up, and the LineIdentifica=
tion
property is updated only upon dialing. The StartTime for when a call would =
become
"active" has been implemented, but is untested until support for call state
transition changes is implemented. This is future work.

AT command support for dial and hangup is provided with a cdma-atmodem driv=
er.
Also included in these patches are test scripts and a CDMA generic hardware
plugin (cdmagen) to support testing of these features.

These patches have been tested against the Nokia 7205 CDMA device in a teth=
ered
mode.

Limitations
-----------
The Nokia 7205 device does not support an AT interface for reporting request
responses, such as the call status and remote/network disconnect reasons, so
these are currently untested.

Dara Spieker-Doyle (9):
  dbus: Add CDMA Voicecall Interface
  types: Add CDMA Phone Number
  cdma-voicecall: Add CDMA MO Call Support
  cdma-voicecall: Add CDMA MO Call Support
  cdmamodem: Add CDMA MO Call Support
  cdmagen: Add CDMA MO Call Support
  ofono-rules: Add cdmagen device
  udev: Add cdmagen
  test: Add CDMA MO Call Support

 Makefile.am                   |   20 ++-
 configure.ac                  |    5 +
 drivers/cdmamodem/cdmamodem.c |   48 +++++
 drivers/cdmamodem/cdmamodem.h |   25 +++
 drivers/cdmamodem/voicecall.c |  190 ++++++++++++++++++
 include/cdma-voicecall.h      |   89 ++++++++
 include/dbus.h                |    3 +
 include/types.h               |    8 +
 plugins/cdmagen.c             |  274 +++++++++++++++++++++++++
 plugins/ofono.rules           |    4 +
 plugins/udev.c                |   21 ++
 src/cdma-voicecall.c          |  444 +++++++++++++++++++++++++++++++++++++=
++++
 src/common.c                  |   41 ++++
 src/common.h                  |    6 +
 src/ofono.h                   |    3 +
 test/cdma-dial-number         |   24 +++
 test/cdma-hangup              |   20 ++
 test/cdma-list-call           |   30 +++
 18 files changed, 1252 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cdmamodem/cdmamodem.c
 create mode 100644 drivers/cdmamodem/cdmamodem.h
 create mode 100644 drivers/cdmamodem/voicecall.c
 create mode 100644 include/cdma-voicecall.h
 create mode 100644 plugins/cdmagen.c
 create mode 100644 src/cdma-voicecall.c
 create mode 100755 test/cdma-dial-number
 create mode 100755 test/cdma-hangup
 create mode 100755 test/cdma-list-call


--===============3705044721205186868==--

