Content-Type: multipart/mixed; boundary="===============6361235942854334863=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 00/28] USB interface labelling via udev
Date: Thu, 30 Mar 2017 22:52:41 +0200
Message-ID: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6361235942854334863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series moves the labelling of USB modem interfaces to udev proper.
For most modems we are able to use the udev hwdb to do the labelling, and
for a few special cases we need to add udev rules.

Importantly, the OFONO_DRIVER and OFONO_LABEL properties are set on all
known interfaces.  This saves the ofono udev handler from having to figure
these out from parsing udev device properties and doing table lookups.

The reason for doing this is:
i)   ofono is currenly re-creating a lot of udev functionality when trying
     figure out the driver and label to apply to interfaces
ii)  the udev hwdb is an optimized path for setting device properties
iii) labelling interfaces via udev means it can be done for new devices
     without code changes (and thus without rebuilding ofono)
iv)  the udev implementation gets smaller and simpler; hopefully this
     can be made so generic that every new modem won't require changes
     to this module

This is an RFC because I'm not quite done with the conversion yet.  There
are still some sysattr details to work out for the mbm and telit modems;
and the qmi modems still need to be put into their final form.  A follow-up
series will be sent to this one but I wanted to get this sent out now for
some review.

Thanks,
Jonas

Jonas Bonn (28):
  zte: remove unused qcdm property
  zte: label interfaces via hwdb
  novatel: label interfaces via hwdb
  alcatel: label interfaces via hwdb
  huawei: label interfaces via hwdb
  simcom: label interfaces via hwdb
  ublox: label interfaces via hwdb
  gemalto: label interfaces via hwdb
  speedup: label interfaces via hwdb
  linktop: label interfaces via hwdb
  udevng (hso): remove impossible condition
  hso: label interfaces via udev rules
  isiusb: label interfaces via udev rules
  gobi: label interfaces via udev rules
  option: label interfaces via hwdb
  nokia: label interfaces via hwdb
  samsung: label interfaces via udev rules and hwdb
  sierra: label interfaces via udev rules
  telitqmi: label interfaces via udev rules
  telitqmi: drop unused device rule
  telit: label interfaces via hwdb
  icera: label interfaces via hwdb
  quectel: label interfaces via hwdb
  udevng: drop unused headers
  mbm: use standard atom names
  udevng: remove 'option' driver setup
  udevng: push device existence check into drivers
  udevng: consolidate setup functions for several USB devices

 drivers/mbmmodem/location-reporting.c |   2 +-
 plugins/alcatel.c                     |   9 +
 plugins/gobi.c                        |   9 +
 plugins/hso.c                         |   9 +
 plugins/huawei.c                      |   9 +
 plugins/icera.c                       |   9 +
 plugins/linktop.c                     |   9 +
 plugins/mbm.c                         |  15 +-
 plugins/nokia.c                       |   9 +
 plugins/novatel.c                     |   9 +
 plugins/ofono-speedup.rules           |  27 --
 plugins/ofono.hwdb                    | 307 +++++++++++++++
 plugins/ofono.rules                   |  51 +++
 plugins/quectel.c                     |   9 +
 plugins/speedup.c                     |   9 +
 plugins/telit.c                       |   9 +
 plugins/udevng.c                      | 687 +++++-------------------------=
----
 plugins/zte.c                         |   9 +
 18 files changed, 577 insertions(+), 620 deletions(-)
 delete mode 100644 plugins/ofono-speedup.rules
 create mode 100644 plugins/ofono.hwdb

-- =

2.9.3


--===============6361235942854334863==--

