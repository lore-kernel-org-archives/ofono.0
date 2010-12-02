Content-Type: multipart/mixed; boundary="===============5175497511504302370=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 0/5] Add CDMA MO Call Support
Date: Thu, 02 Dec 2010 15:31:20 -0800
Message-ID: <1291332685-18740-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5175497511504302370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Dara Spieker-Doyle (5):
  cdma-voicecall: Add CDMA MO Call Support
  cdma-voicecall: Add CDMA MO Call Support
  cdma-atmodem: Add CDMA MO Call Support
  cdmagen: Add CDMA MO Call Support
  test: Add CDMA MO Call Support

 Makefile.am                      |   20 ++-
 configure.ac                     |    5 +
 drivers/cdma-atmodem/atmodem.c   |   47 ++++
 drivers/cdma-atmodem/atmodem.h   |   26 +++
 drivers/cdma-atmodem/atutil.c    |   45 ++++
 drivers/cdma-atmodem/atutil.h    |   65 ++++++
 drivers/cdma-atmodem/voicecall.c |  195 +++++++++++++++++
 include/cdma-voicecall.h         |   82 +++++++
 include/dbus.h                   |    3 +
 include/types.h                  |    8 +
 plugins/cdmagen.c                |  276 +++++++++++++++++++++++
 plugins/ofono.rules              |    4 +
 plugins/udev.c                   |   21 ++
 src/cdma-voicecall.c             |  449 ++++++++++++++++++++++++++++++++++=
++++
 src/common.c                     |   42 ++++
 src/common.h                     |   14 ++
 src/ofono.h                      |    3 +
 test/cdma-dial-number            |   25 ++
 test/cdma-hangup                 |   20 ++
 test/cdma-list-call              |   30 +++
 20 files changed, 1377 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cdma-atmodem/atmodem.c
 create mode 100644 drivers/cdma-atmodem/atmodem.h
 create mode 100644 drivers/cdma-atmodem/atutil.c
 create mode 100644 drivers/cdma-atmodem/atutil.h
 create mode 100644 drivers/cdma-atmodem/voicecall.c
 create mode 100644 include/cdma-voicecall.h
 create mode 100644 plugins/cdmagen.c
 create mode 100644 src/cdma-voicecall.c
 create mode 100755 test/cdma-dial-number
 create mode 100755 test/cdma-hangup
 create mode 100755 test/cdma-list-call


--===============5175497511504302370==--

