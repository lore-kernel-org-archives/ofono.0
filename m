Content-Type: multipart/mixed; boundary="===============1725336921279152463=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v3, Part1, 0/5] Add CDMA MO Call Support
Date: Mon, 20 Dec 2010 17:36:32 -0800
Message-ID: <1292895397-11573-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1725336921279152463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches is the first part of the split of the version 2 seri=
es,
concerning the changes needed to provide foundation support for cdmamodem
driver and the introducing the cdma-voicecall atom. Not included in this pa=
rt
of the series is the cdmagen plugin for testing these changes with hardware=
 as
this is under further discussion. Part2 will be submitted once the naming
convention for this plugin has been resolved.
This part also contains the relevant test scripts, although these will fail
for now until the cdmagen plugin changes have been submitted.

Implementation of the following has been carried out in this set of patches:

They cover making a simple MO call over a CDMA network, including call
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
  cdmamodem: Add cdmamodem stubs
  cdmamodem: Add CDMA MO Call Support with voicecall driver
  test: Add CDMA MO Call Support

 Makefile.am                   |   17 ++-
 configure.ac                  |    5 +
 drivers/cdmamodem/cdmamodem.c |   48 +++++
 drivers/cdmamodem/cdmamodem.h |   25 +++
 drivers/cdmamodem/voicecall.c |  190 ++++++++++++++++++
 include/cdma-voicecall.h      |   89 +++++++++
 src/cdma-voicecall.c          |  430 +++++++++++++++++++++++++++++++++++++=
++++
 src/common.c                  |   41 ++++
 src/common.h                  |    6 +
 src/ofono.h                   |    3 +
 test/cdma-dial-number         |   24 +++
 test/cdma-hangup              |   20 ++
 test/cdma-list-call           |   30 +++
 13 files changed, 925 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cdmamodem/cdmamodem.c
 create mode 100644 drivers/cdmamodem/cdmamodem.h
 create mode 100644 drivers/cdmamodem/voicecall.c
 create mode 100644 include/cdma-voicecall.h
 create mode 100644 src/cdma-voicecall.c
 create mode 100755 test/cdma-dial-number
 create mode 100755 test/cdma-hangup
 create mode 100755 test/cdma-list-call


--===============1725336921279152463==--

