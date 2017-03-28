Content-Type: multipart/mixed; boundary="===============2568971223896113738=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev v2 0/5] Device handling cleanup series
Date: Tue, 28 Mar 2017 15:18:19 +0200
Message-ID: <20170328131824.13261-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2568971223896113738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is version 2 of the udev handling cleanups.

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
 plugins/udevng.c | 266 ++++++++++++++++++++++++++++++++--
 3 files changed, 255 insertions(+), 444 deletions(-)
 delete mode 100644 plugins/udev.c

-- =

2.9.3


--===============2568971223896113738==--

