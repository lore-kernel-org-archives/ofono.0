Content-Type: multipart/mixed; boundary="===============2574342601652166367=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [gprs-provision PATCHv5 0/6] Plugin API for provisioning of GPRS
 context setting
Date: Thu, 20 Jan 2011 15:11:33 +0200
Message-ID: <1295529099-21082-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2574342601652166367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

And again, here is a new patchset about implementing automatic provisioning=
 of GPRS context settings.

Since last time, driver API should be cleaner now. Some whitespace issues f=
ixed, and probably some new ones introduced :)

Example driver patch requires ofono_sim_get_mcc/mnc in SIM atom API patches=
, that I mailed earlier.

[copy from earlier mail]
Provisioning data for gprs contexts is returned by gprs-provisioning plugin=
s/drivers. Different kind of provisioning modules may be created for differ=
ent platforms or use cases.
It is up to the module what settings database it uses, and how many, and wh=
at type of contexts (with settings) it returns.
Several plugins may be loaded in oFono, and they will be called in priority=
 order until first plugin returns non-empty result.

Provisioning modules are called in case there are no previously configured =
contexts found during gprs atom registration.
 =

These patches add new gprs-provision.[hc] API for provisioning plugins to r=
egister into, and __ofono_gprs_provision_get_settings for gprs.c to call wh=
en needed.
gprs.c is modified to use provisioning if reading existing context settings=
 fails.

A dummy example provisioning plugin is included. In case it is called when =
using phonesim with default.xml configuration, the plugin returns dummy set=
tings for two contexts, one type Internet and one type MMS. =


--Jukka Saunam=C3=A4ki


Jukka Saunamaki (6):
      gprs-provision: add driver API header
      ofono.h: add new atom type for gprs-provision
      gprs-provision: add driver API sources
      modem: probe gprs_provision drivers
      gprs: add gprs context provisioning
      gprs-provision: add example context provisioning driver

 Makefile.am              |    7 +-
 examples/provision.c     |  221 ++++++++++++++++++++++++++++++++++++++++++=
++++
 include/gprs-provision.h |   74 +++++++++++++++
 src/gprs-provision.c     |  219 ++++++++++++++++++++++++++++++++++++++++++=
+++
 src/gprs.c               |  147 ++++++++++++++++++++++++++++---
 src/modem.c              |    1 +
 src/ofono.h              |    8 ++
 7 files changed, 661 insertions(+), 16 deletions(-)
 create mode 100644 examples/provision.c
 create mode 100644 include/gprs-provision.h
 create mode 100644 src/gprs-provision.c


--===============2574342601652166367==--

