Content-Type: multipart/mixed; boundary="===============5363669818418509260=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: Add Suspended property to GPRS (take 2)
Date: Thu, 09 Sep 2010 15:08:09 +0300
Message-ID: <1284034091-8288-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5363669818418509260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[PATCH 1/2] Add Suspended property to GPRS atom
[PATCH 2/2] isimodem: implement Suspended property

 doc/connman-api.txt      |   19 ++++++++++++
 drivers/isimodem/debug.c |   25 ++++++++++++++++
 drivers/isimodem/debug.h |    2 +
 drivers/isimodem/gpds.h  |   17 +++++++++++
 drivers/isimodem/gprs.c  |   56 ++++++++++++++++++++++++++++++++++++-
 include/gprs.h           |   10 ++++++
 src/gprs.c               |   69 ++++++++++++++++++++++++++++++++++++++++++=
++++
 7 files changed, 197 insertions(+), 1 deletions(-)

--===============5363669818418509260==--

