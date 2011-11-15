Content-Type: multipart/mixed; boundary="===============6240396943802282465=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/3] Add a parser to retrieve the CDMA network name
Date: Tue, 15 Nov 2011 14:04:12 +0100
Message-ID: <1321362255-11262-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6240396943802282465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A new API is introduced in mbpi plugin to parse the mobile broadband provid=
er
info' database in order to retrieve the serving network name from the System
Identifier (SID).
Next step is precisely to retrieve the SID broadcasted by the CDMA modem =


Philippe Nunes (3):
  mbpi: mbpi_lookup becomes mbpi_lookup_apn
  mbpi: Add mbpi_lookup_cdma_provider_name API
  tools: Add utility for looking CDMA network name from database

 Makefile.am                  |    7 +-
 plugins/mbpi.c               |  214 +++++++++++++++++++++++++++++++++++---=
---
 plugins/mbpi.h               |    4 +-
 plugins/provision.c          |    2 +-
 tools/lookup-apn.c           |    2 +-
 tools/lookup-provider-name.c |  104 ++++++++++++++++++++
 6 files changed, 297 insertions(+), 36 deletions(-)
 create mode 100644 tools/lookup-provider-name.c


--===============6240396943802282465==--

