Content-Type: multipart/mixed; boundary="===============6756395644322209702=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [gprs-provision PATCHv4 0/8] plugin API for provisioning of GPRS
 context settings
Date: Tue, 18 Jan 2011 10:09:24 +0200
Message-ID: <1295338172-12773-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6756395644322209702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

Here is a new patchset about implementing automatic provisioning of GPRS co=
ntext settings. ("Internet Access Provider database" TODO item).

Compared to last one, this makes gprs-provision a "pseudo" atom similar to =
nettime. And possible races caused by a removed gprs-atom, while it is runn=
ing asyncronous provisioning, should hopefully be fixed now.

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


Patches also add new functions ofono_sim_get_mcc/mnc to SIM atom API (typic=
ally needed by provisioning plugins).

--Jukka Saunam=C3=A4ki

Jukka Saunamaki (8):
      gprs-provision: add driver API header
      gprs-provision: add new atom type
      gprs-provision: add driver API sources
      gprs-provision: probe gprs_provision drivers
      gprs: add gprs context provisioning
      sim: getters for mcc and mnc definition
      sim: getters for mcc and mnc implementation
      gprs-provision: add example context provisioning driver

 Makefile.am              |    7 +-
 examples/provision.c     |  206 ++++++++++++++++++++++++++++++++++++++++
 include/gprs-provision.h |   80 ++++++++++++++++
 include/sim.h            |    2 +
 src/gprs-provision.c     |  236 ++++++++++++++++++++++++++++++++++++++++++=
++++
 src/gprs.c               |  147 ++++++++++++++++++++++++++---
 src/modem.c              |    1 +
 src/ofono.h              |    9 ++
 src/sim.c                |   50 ++++++----
 9 files changed, 703 insertions(+), 35 deletions(-)
 create mode 100644 examples/provision.c
 create mode 100644 include/gprs-provision.h
 create mode 100644 src/gprs-provision.c



--===============6756395644322209702==--

