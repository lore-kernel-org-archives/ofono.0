Content-Type: multipart/mixed; boundary="===============8461257486154366959=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 0/4] phonesim: CBS/USSD improvments
Date: Fri, 29 Jun 2012 17:52:59 +0200
Message-ID: <1340985183-22049-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8461257486154366959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

-mDataCodingScheme is set when we need to apply the same scheme in case of
multi-page CBS message. =

-The method 'shouldsplit' is removed since we are using directly the method
compute size in order to check the number of pages.
-When the text is too long, the text truncation is done directly by the met=
hod
'split'. =


Philippe Nunes (4):
  controbase: Remove entries in CBM UI
  qcbsmessage: apply the same coding scheme for all the pages
  hardwaremanipulator: Use the best scheme for CBS message
  hardwaremanipulator: Add multi-page support for CBS message

 src/control.cpp             |    9 +--
 src/controlbase.ui          |  184 ++++++++++++++++-----------------------=
----
 src/hardwaremanipulator.cpp |   59 +++++++-------
 src/hardwaremanipulator.h   |    6 +-
 src/qcbsmessage.cpp         |   38 ++++-----
 src/qcbsmessage.h           |    1 -
 6 files changed, 117 insertions(+), 180 deletions(-)

-- =

1.7.9.5


--===============8461257486154366959==--

