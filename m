Content-Type: multipart/mixed; boundary="===============6399271094509438594=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v3, Part2, 0/3] Add nokiacdma plugin and CDMA MO Call support
Date: Tue, 21 Dec 2010 11:23:27 -0800
Message-ID: <1292959410-6566-1-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6399271094509438594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patches is the second part of the split of the version 2 ser=
ies,
concerning the changes needed to provide foundation support for the nokiacd=
ma
device plugin and the adding the cdma-voicecall atom. This is needed for
testing the changes in the first part of the series, for providing the =

foundation cdmamodem driver and simple CDMA MO Call support with hardware.

These patches have been tested against the Nokia 7205 CDMA device in a teth=
ered
mode.

Limitations
-----------
The Nokia 7205 device does not support an AT interface for reporting request
responses, such as the call status and remote/network disconnect reasons, so
these are currently untested.

Dara Spieker-Doyle (3):
  nokiacdma: Add plugin and CDMA MO Call Support
  ofono-rules: Add nokiacdma device
  udev: Add nokiacdma device

 Makefile.am                   |   20 ++-
 plugins/nokiacdma.c           |  275 ++++++++++++++++++++++++++
 plugins/ofono.rules           |    4 +
 plugins/udev.c                |   21 ++
 4 files changed, 303 insertions(+), 0 deletions(-)
 create mode 100644 plugins/nokiacdma.c


--===============6399271094509438594==--

