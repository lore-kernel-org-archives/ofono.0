Content-Type: multipart/mixed; boundary="===============6272714748791804883=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/7] phonesim: Add UCS2 encoding support for CBS/USSD
Date: Mon, 25 Jun 2012 16:37:56 +0200
Message-ID: <1340635083-5877-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6272714748791804883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

phonesim is extended to support UCS2 encoding regarding CBS/USSD messages: =

- for CBS, a scheme combobox is now available for user selection.
- for USSD, the best scheme is used based on the content of the USSD text s=
tring.

phonesim is also able now to split the CBS text (according the chosen schem=
e) and send all the pages of the CBS message.  =



Philippe Nunes (7):
  control: Fix empty sender checking
  controbase: Add combobox for CBS scheme selection
  qcbsmessage: Extend QCBSMessage class
  hardwaremanipulator: Add UCS2 encoding support for CBS message
  hardwaremanipulator: Add multi-page support for CBS message
  sms: Extend CBS message formating to use UCS2 scheme
  hardwaremanipulator: Add USC2 encoding support for USSD.

 src/control.cpp             |    8 +--
 src/controlbase.ui          |   36 ++++++-----
 src/hardwaremanipulator.cpp |   90 ++++++++++++++++++++++------
 src/hardwaremanipulator.h   |    6 +-
 src/qcbsmessage.cpp         |  140 +++++++++++++++++++++++++++++++++++++++=
+++-
 src/qcbsmessage.h           |    7 +++
 src/qsmsmessage.cpp         |  119 +++++++++++++++++++++++++++++++++---
 7 files changed, 357 insertions(+), 49 deletions(-)

-- =

1.7.9.5


--===============6272714748791804883==--

