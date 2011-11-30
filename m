Content-Type: multipart/mixed; boundary="===============7498891008427406125=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/5] Provider name and SID 
Date: Wed, 30 Nov 2011 22:20:55 +0100
Message-ID: <1322688060-17588-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7498891008427406125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With this set of patches: =


- cdma-providers.c is introducing an abstracted API to retrieve the provider
name from the SID.
This abstraction layer provides the ability to support multiple database for
the provider name lookup.
- As an example, the new plugin "providers" is based on the Mobile Broadband
Provider Info database.
- The lookup for the provider name is performed only if the system identifi=
er
has changed.

Philippe Nunes (5):
  cdma-providers: add driver APIs header
  ofono.h: add cdma-providers
  cdma-providers: add driver APIs implementation
  providers: add cdma provider name plugin
  cdma-netreg: Add provider name and SID support

 Makefile.am              |    4 +-
 include/cdma-providers.h |   44 +++++++++++++++++++++++++
 plugins/providers.c      |   79 ++++++++++++++++++++++++++++++++++++++++++=
+++
 src/cdma-netreg.c        |   40 +++++++++++++++++++++++
 src/cdma-providers.c     |   80 ++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h              |    4 ++
 6 files changed, 249 insertions(+), 2 deletions(-)
 create mode 100644 include/cdma-providers.h
 create mode 100644 plugins/providers.c
 create mode 100644 src/cdma-providers.c


--===============7498891008427406125==--

