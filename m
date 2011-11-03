Content-Type: multipart/mixed; boundary="===============6671357117879969226=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/3] CDMA UIM implementation
Date: Thu, 03 Nov 2011 10:45:52 +0100
Message-ID: <1320313555-10320-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6671357117879969226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This patch contains the cdma UIM implementation.
For the moment UIM atom is designed for data call:
	- IMSI is used as identifer to save credentials into oFono and as
	  ConnMan cellular service identifier
	- PIN management might be needed for some Huwaei CDMA modem (EC1261)

Kind regards,
Guillaume

Guillaume Zajac (3):
  uim: Add CDMA UIM APIs documentation
  include: Add uim atom public api
  uim: Add uim implementation

 Makefile.am          |    4 +-
 doc/cdma-uim-api.txt |  152 ++++++++
 include/dbus.h       |    1 +
 include/uim.h        |  141 +++++++
 src/ofono.h          |    8 +
 src/uim.c            | 1031 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 6 files changed, 1335 insertions(+), 2 deletions(-)
 create mode 100644 doc/cdma-uim-api.txt
 create mode 100644 include/uim.h
 create mode 100644 src/uim.c


--===============6671357117879969226==--

