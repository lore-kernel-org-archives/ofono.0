Content-Type: multipart/mixed; boundary="===============4861414412875887025=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH v2 0/5] ubloxmodem add netmon interface
Date: Wed, 30 Nov 2016 13:13:15 +0100
Message-ID: <1480508002-15830-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4861414412875887025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

These patches add netmon interface to ubloxmodem. This allows to query
and get data returned by +CESQ command through D-Bus.

The following types will be exposed as Network Monitor Property Types.
RSCP: Received Signal Code Power
ECN0: Received Energy Ratio
RSRQ: Reference Signal Received Quality
RSRP: Reference Signal Received Power


V1 is here:
https://lists.ofono.org/pipermail/ofono/2016-November/016671.html

Thank you!

Changes since v1:
  * Re-worked patches to follow 'Submitting patches' section.
    Each top-level directory change should be in a separate patch
  * Removed OFONO_NETMON_INFO_OPERATOR
  * Documented all added fields in networkmonitor-api.txt
  * We only use one channel for communication, dropped the other one.
  * Fixed a cbd memory leak, now we try to be conservative and always
    report what we have collected so far. We only fail hard in case
    +COPS failed or sending +CESQ failed. Otherwise we report the result
    and make sure to free cbd.
  * Various fixes to follow the coding style.


Djalal Harouni (7):
  netmon: add OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP}
  netmon: handle OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP} in D-Bus
  doc: documentation for OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP}
  ubloxmodem: add the netmon driver
  ubloxmodem: register and initialize the netmon driver
  build: build the ublox netmon driver
  test: support OFONO_NETMON_INFO_{RXLEV|RSCP|ECN0|RSRQ|RSRP}

 Makefile.am                     |   1 +
 doc/networkmonitor-api.txt      |  22 +++
 drivers/ubloxmodem/netmon.c     | 335 ++++++++++++++++++++++++++++++++++++=
++++
 drivers/ubloxmodem/ubloxmodem.c |   2 +
 drivers/ubloxmodem/ubloxmodem.h |   3 +
 include/netmon.h                |   4 +
 plugins/ublox.c                 |   3 +
 src/netmon.c                    |  28 ++++
 test/get-serving-cell-info      |  20 +++
 9 files changed, 418 insertions(+)
 create mode 100644 drivers/ubloxmodem/netmon.c

--===============4861414412875887025==--

