Content-Type: multipart/mixed; boundary="===============7148170437217814922=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 0/6] Driver registration rework
Date: Fri, 26 Oct 2018 11:54:13 +0200
Message-ID: <20181026095419.26260-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7148170437217814922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Since I don't know if you'd even be interested in a series like this,
here's a draft that touches just a few places to give you an idea of
where this would take us... take a look and let me know what you think.

/Jonas

******

ofono has historically had a system in place whereby modems are
encapsulated as 'plugins', the idea being that these could be loosely
coupled to the core and added/removed flexibly as requirements changed.
Theoretically, the plugin would register a set of new drivers (atoms)
with the core and then call ofono_modem_register(...) after having
configured the modem object appropriately (device node, etc).  In
practice, however, this does not work well and the modem plugins don't
really follow this model.

- drivers (atoms) use a lot of core functionality and cannot be built
externally using only the exported ofono headers.  As such, the
drivers really need to be part of core ofono, irregardless of whether
they are packed into separate modules (plugins) or linked into one
monolithici mage

- ofono no longer provides the ability to built the plugins in the
source tree as external libs; they are all linked into one monolithic
image by default with no option to change this

- the modem 'plugins' are 99% modem driver and 1% plugin; the plugin bit
just takes care of registering the modem driver with the core and does
nothing else

- udevng takes care of setting up the modem objects and binding them
with their drivers

This patch series tries to addres this in the following way:

i) Add driver registration macros that lift registration with the core
into init() (constructor) functions; this allows the drivers to
automatically be registered at startup or on module load if they happen
be part of a plugin

ii)  Move the 'modem driver' part of the modem plugins into the drivers/
directory.

iii)  If the plugins are doing nothing other than registering the modem
driver, drop it altogether.

Jonas Bonn (6):
  include: add macros for declaring drivers
  qmimodem: simplify driver registration
  gobi: modem driver cannot be a plugin
  atmodem: add missing headers to atutil.h
  telitmodem: simplify driver registration
  telitmodem: modem driver is not a plugin

 Makefile.am                             | 12 ++----
 drivers/atmodem/atutil.h                |  3 ++
 {plugins =3D> drivers/qmimodem}/gobi.c    | 13 +------
 drivers/qmimodem/gprs-context.c         | 10 +----
 drivers/qmimodem/location-reporting.c   | 10 +----
 drivers/qmimodem/qmimodem.c             |  4 --
 drivers/qmimodem/qmimodem.h             |  6 ---
 drivers/telitmodem/gprs-context-ncm.c   | 15 +-------
 drivers/telitmodem/location-reporting.c | 16 ++------
 {plugins =3D> drivers/telitmodem}/telit.c | 15 +-------
 drivers/telitmodem/telitmodem.c         | 51 -------------------------
 drivers/telitmodem/telitmodem.h         | 27 -------------
 include/gprs-context.h                  | 11 ++++++
 include/location-reporting.h            | 10 +++++
 include/modem.h                         | 11 ++++++
 15 files changed, 47 insertions(+), 167 deletions(-)
 rename {plugins =3D> drivers/qmimodem}/gobi.c (97%)
 rename {plugins =3D> drivers/telitmodem}/telit.c (97%)
 delete mode 100644 drivers/telitmodem/telitmodem.c
 delete mode 100644 drivers/telitmodem/telitmodem.h

-- =

2.17.1


--===============7148170437217814922==--

