Content-Type: multipart/mixed; boundary="===============1445033020108785033=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev v3 0/5] Device handling cleanups
Date: Tue, 28 Mar 2017 23:54:10 +0200
Message-ID: <20170328215416.20119-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1445033020108785033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is version 3 of the udev handling cleanups.

Changes since v2:

* Addressed comments from Denis

Changes since v1:

* Reworked patch 1/5 (was 11/15) to handle 'legacy' devices in a simpler
  manner.
* Addressed comments from Denis

Original blurb follows:

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

Jonas Bonn (5):
  udevng: add serial device handling functions
  udevng: match on the hsi subsystem for legacy devices
  udevng: hook up legacy devices
  udevng: get properties from interface
  plugins: remove udev module

 Makefile.am      |   2 -
 plugins/udev.c   | 431 ---------------------------------------------------=
----
 plugins/udevng.c | 292 ++++++++++++++++++++++++++++++++++---
 3 files changed, 272 insertions(+), 453 deletions(-)
 delete mode 100644 plugins/udev.c

-- =

2.9.3


--===============1445033020108785033==--

