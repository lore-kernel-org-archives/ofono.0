Content-Type: multipart/mixed; boundary="===============6512850119985899253=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 00/15] Device handling cleanup series
Date: Sat, 25 Mar 2017 17:57:50 +0100
Message-ID: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6512850119985899253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a series of incremental cleanups to the libudev device handling
code.

- the early patches in the series are all good cleanups that can be
  taken irregardless of whether the last patches are desired
- the last patches are more intrusive as they attempt to move the
  functionality of udev.c into udevng.c

Somebody with access to old hardware really needs to take a look at
this series to see if the migration to udevng works properly.  I do
not have any such hardware, myself.  I suspect that there's not many
such devices in circulation; my hope is that this legacy code works
for now and can be ripped out in time.

In any case, if someone has such old hardware, hopefully these changes
are sufficiently correct that the last bugs can shake themselves out
easily... we'll see.

Jonas Bonn (15):
  udevng: simplify logic in check_usb_device
  ofono.rules: remove 'change' action
  udev: remove extraneous subsystem check
  udev: get udev property via lib function
  udev: remove unused modem property
  udev: simplify add_modem
  udev: add common modem registration code
  udev: simplify ifx modem registration
  udev: simplify wavecom modem registration
  udev: remove extraneous subsystem check
  udevng: add legacy device handling functions
  udevng: match on the hsi subsystem for legacy devices
  udevng: hook up legacy devices
  udevng: get properties from interface
  plugins: remove udev module

 Makefile.am         |   2 -
 plugins/ofono.rules |   2 +-
 plugins/udev.c      | 545 ------------------------------------------------=
----
 plugins/udevng.c    | 307 ++++++++++++++++++++++++++---
 4 files changed, 283 insertions(+), 573 deletions(-)
 delete mode 100644 plugins/udev.c

-- =

2.9.3


--===============6512850119985899253==--

