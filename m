Content-Type: multipart/mixed; boundary="===============4798376063986325708=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [gprs-provision RFCPATCHv6 0/4] Plugin API for provisioning of GPRS
 context settings
Date: Tue, 25 Jan 2011 14:15:10 +0200
Message-ID: <1295957714-21053-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4798376063986325708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

Another patchset about automatic provisioning of GPRS context settings.

This time, provisioning driver API is synchronous, and __ofono_gprs_provisi=
on_get_settings includes MCC,MNC and SPN as in parameters. =

Per modem probing and all related complexity was removed, since there was r=
eally no need for it. =


It is now the gprs-atom that queries SPN from SIM before calling provisioni=
ng. Cases when gprs-atom is unregistered or removed while SPN query is in p=
rogress, should be handled gracefully (unlike e.g. in netreg atom...)


--Jukka Saunam=C3=A4ki

Jukka Saunamaki (4):
      gprs-provision: add driver API header
      gprs-provision: add driver API sources
      gprs: add gprs context provisioning
      gprs-provision: add example context provisioning driver

 Makefile.am              |    8 ++-
 examples/provision.c     |   97 ++++++++++++++++++++++++++
 include/gprs-provision.h |   69 ++++++++++++++++++
 src/gprs-provision.c     |  104 ++++++++++++++++++++++++++++
 src/gprs.c               |  172 ++++++++++++++++++++++++++++++++++++++++++=
+---
 5 files changed, 438 insertions(+), 12 deletions(-)
 create mode 100644 examples/provision.c
 create mode 100644 include/gprs-provision.h
 create mode 100644 src/gprs-provision.c



--===============4798376063986325708==--

