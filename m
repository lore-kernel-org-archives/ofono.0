Content-Type: multipart/mixed; boundary="===============5931704293078205933=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/6] phonesim: CBS/USSD improvments
Date: Wed, 27 Jun 2012 17:10:39 +0200
Message-ID: <1340809845-26595-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5931704293078205933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

-CBS message is encoded using the best CBS data coding scheme. In case of =

non-GSM characters in the plain text body, the UCS-2 alphabet is used.

-CBS message is splitted automatically in pages if needed. The UI entries
related to the page number and the maximum of pages are removed since this =
is
handled internally.

-USSD answer and cancellation commands are now supported.

Philippe Nunes (6):
  controbase: Remove entries in CBM UI
  qcbsmessage: Add bestScheme method in QCBSMessage class
  hardwaremanipulator: Use the best scheme for CBS message
  hardwaremanipulator: Add multi-page support for CBS message
  phonesim: Add support for USSD answer
  phonesim: Add support for USSD session cancellation

 src/control.cpp             |    9 +--
 src/controlbase.ui          |  184 ++++++++++++++++-----------------------=
----
 src/default.xml             |   14 ++++
 src/hardwaremanipulator.cpp |   70 +++++++++-------
 src/hardwaremanipulator.h   |    6 +-
 src/qcbsmessage.cpp         |   10 ++-
 src/qcbsmessage.h           |    1 +
 7 files changed, 137 insertions(+), 157 deletions(-)

-- =

1.7.9.5


--===============5931704293078205933==--

