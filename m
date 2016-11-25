Content-Type: multipart/mixed; boundary="===============9025706854221879695=="
MIME-Version: 1.0
From: djalal@endocode.com
Subject: [PATCH 0/5] RFC: ubloxmodem add netmon interface
Date: Fri, 25 Nov 2016 15:00:10 +0100
Message-ID: <1480082415-30822-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9025706854221879695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Djalal Harouni <djalal@endocode.com>

Hi,

These patches add netmon interface to ubloxmodem. This allows to query
and get data returned by +CESQ command through D-Bus.

The following types will be exposed as Network Monitor Property Types.
RSCP: Received Signal Code Power
ECN0: Received Energy Ratio
RSRQ: Reference Signal Received Quality
RSRP: Reference Signal Received Power
OPERATOR: the operator


The 5 patches are:

0001: add the ofono netmon types that we are interesting in
      OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR}
      These will be collected from +COPS and +CESQ

0002: handle OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR} in D-Bus

0003: ubloxmodem: add the netmon driver
      This adds the actual netmon driver. It also contains the code to
      do +COPS and +CESQ and send back result.

0004: ubloxmodem: intialize and register the netmon driver
      This adds the code to intialize and register the driver that was
      added in patch 0003

0005: test: support OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR}
      This makes get-serving-cell-info script return the all data that
      we did expose.


Questions:
How we should document these new fields in doc/networkmonitor-api.txt ?
Should we use the official values from the ublox AT manual ?

Thank you!


Djalal Harouni (5):
  netmon: add OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR}
  netmon: handle OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR} in D-Bus
  ubloxmodem: add the netmon driver
  ubloxmodem: intialize and register the netmon driver
  test: support OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR}

 Makefile.am                     |   1 +
 drivers/ubloxmodem/netmon.c     | 339 ++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++
 drivers/ubloxmodem/ubloxmodem.c |   2 +
 drivers/ubloxmodem/ubloxmodem.h |   3 ++
 include/netmon.h                |   5 ++
 plugins/ublox.c                 |   3 ++
 src/netmon.c                    |  40 +++++++++++++++-
 test/get-serving-cell-info      |  24 ++++++++++
 8 files changed, 416 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ubloxmodem/netmon.c

-- =

2.5.5


--===============9025706854221879695==--

