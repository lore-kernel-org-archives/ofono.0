Content-Type: multipart/mixed; boundary="===============7647669378016648276=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 0/6] Add location-reporting atom
Date: Tue, 22 Feb 2011 15:35:09 -0300
Message-ID: <1298399715-9617-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7647669378016648276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

This is the 4th version of the location-reporting patches (previous title w=
as
"Add GPS atom"). I worked with Rafael Ignacio Zurita to implement this last
version, making some changes in order to fit the new design as discussed on=
 irc.

Now when a client calls 'Request()' we give it a file
descriptor in which the location reporting will be written. By checking the
'Type' property the client can decide what to do with such information. As =
of
now only NMEA is supported and it's implemented on mbm modem.

If client exits or calls 'Release()', the location reporting is disabled.

Rafael Ignacio Zurita (6):
  location-reporting: add public header
  location-reporting: add atom implementation
  mbmmodem: add location-reporting driver implementation
  mbm: add location-reporting atom
  udev: add location-reporting device to mbm
  location-reporting: add documentation

 Makefile.am                           |   11 +-
 doc/location-reporting-api.txt        |   39 ++++
 drivers/mbmmodem/location-reporting.c |  247 +++++++++++++++++++++
 drivers/mbmmodem/mbmmodem.c           |    2 +
 drivers/mbmmodem/mbmmodem.h           |    3 +
 include/location-reporting.h          |   81 +++++++
 plugins/mbm.c                         |    8 +
 plugins/udev.c                        |    5 +-
 src/location-reporting.c              |  393 +++++++++++++++++++++++++++++=
++++
 src/ofono.h                           |    2 +
 10 files changed, 785 insertions(+), 6 deletions(-)
 create mode 100644 doc/location-reporting-api.txt
 create mode 100644 drivers/mbmmodem/location-reporting.c
 create mode 100644 include/location-reporting.h
 create mode 100644 src/location-reporting.c

-- =

1.7.4.1


--===============7647669378016648276==--

