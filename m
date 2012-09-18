Content-Type: multipart/mixed; boundary="===============2716674282409913977=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH 00/11] Samsung IPC modem support
Date: Tue, 18 Sep 2012 20:18:44 +0200
Message-ID: <1347992335-9016-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2716674282409913977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Heyho,

the following patch series adds support for the Samsung IPC protocol which =
is implemented
in an external library called libsamsung-ipc (see [0]). The library contain=
s the
implementation of the protocol used in most Samsung mobile handsets. As of =
right now the
implementation contains drivers for the devinfo, sim, voicecall, gprs and g=
prs-context
subsystems. Implementation for other subsystems like sms will follow.

I submit the patches here for a first review to make sure things I did are =
right and are
fine for inclusion in ofono. Anyway the code is not ready yet and needs mor=
e tweaking and
testing but I think it's time for a first look.

One thing about libsamsung-ipc: The library itself needs some rework and fi=
ne tuning and
is not ready for a release yet so this is a hard dependency for the inclusi=
on in ofono.

regards,
Simon

[0]: https://github.com/morphis/libsamsung-ipc

Simon Busch (11):
  build: Add skeleton for Samsung IPC modem driver
  build: add dependency for samsung-ipc library
  samsungmgr: plugin for powering up samsung related modems via an
    additional daemon
  samsungipcmodem: implement the transport layer for the IPC protocol
  samsungipcmodem: add devinfo driver implementation
  samsungipcmodem: add sim driver implementation
  samsungipcmodem: add network registration driver implementation
  samsungipcmodem: add voicecall driver implementation
  samsungipcmodem: add gprs driver implementation
  samsungipcmodem: add gprs-context driver implementation
  samsungipc: Add initial implementation of the Samsung IPC modem
    plugin

 Makefile.am                                    |   25 +
 configure.ac                                   |   11 +
 drivers/samsungipcmodem/devinfo.c              |  214 ++++++++
 drivers/samsungipcmodem/gprs-context.c         |  311 +++++++++++
 drivers/samsungipcmodem/gprs.c                 |  215 ++++++++
 drivers/samsungipcmodem/ipc.c                  |  443 ++++++++++++++++
 drivers/samsungipcmodem/ipc.h                  |   58 ++
 drivers/samsungipcmodem/network-registration.c |  398 ++++++++++++++
 drivers/samsungipcmodem/samsungipcmodem.c      |   53 ++
 drivers/samsungipcmodem/samsungipcmodem.h      |   33 ++
 drivers/samsungipcmodem/sim.c                  |  674 ++++++++++++++++++++=
++++
 drivers/samsungipcmodem/util.h                 |   57 ++
 drivers/samsungipcmodem/voicecall.c            |  358 +++++++++++++
 plugins/samsungipc.c                           |  414 +++++++++++++++
 plugins/samsungmgr.c                           |  199 +++++++
 15 files changed, 3463 insertions(+)
 create mode 100644 drivers/samsungipcmodem/devinfo.c
 create mode 100644 drivers/samsungipcmodem/gprs-context.c
 create mode 100644 drivers/samsungipcmodem/gprs.c
 create mode 100644 drivers/samsungipcmodem/ipc.c
 create mode 100644 drivers/samsungipcmodem/ipc.h
 create mode 100644 drivers/samsungipcmodem/network-registration.c
 create mode 100644 drivers/samsungipcmodem/samsungipcmodem.c
 create mode 100644 drivers/samsungipcmodem/samsungipcmodem.h
 create mode 100644 drivers/samsungipcmodem/sim.c
 create mode 100644 drivers/samsungipcmodem/util.h
 create mode 100644 drivers/samsungipcmodem/voicecall.c
 create mode 100644 plugins/samsungipc.c
 create mode 100644 plugins/samsungmgr.c

-- =

1.7.9.5


--===============2716674282409913977==--

