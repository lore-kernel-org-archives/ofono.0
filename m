Content-Type: multipart/mixed; boundary="===============8412942129465319837=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 0/3] QMI modem fixups
Date: Wed, 07 Mar 2018 15:55:08 +0100
Message-ID: <20180307145511.21142-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8412942129465319837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here's a couple of fixups to the qmimodem atoms in order handle service
lifetime.

The QMI services are 'shared' between various atoms and this has some
subtle problems.  Patch 3, for the LTE atom, handles an issue where
atoms from different ofono states share an atom.  For things to work
properly, only atoms from the same state should be sharing a service.

For things to work better, requests should probably be queued on the
actual service instance that the atom is using and not on the underlying
shared device queue.  That way, the responses for a destroyed service
instance could just be dropped instead of being propagated to a
potentially free'd atom.  This is a rather intrusive rework of the QMI
core though, so the patches here will need to do for now.

The patches here resolve a concrete segfault that arises when the modem
is set offline.

Jonas Bonn (3):
  qmimodem: release WDS service on GPRS atom removal
  qmimodem: release DMS service on radio-settings atom removal
  qmimodem: release WDS service handle in LTE atom

 drivers/qmimodem/gprs.c           |   3 +
 drivers/qmimodem/lte.c            | 143 +++++++++++++++++++++++++---------=
----
 drivers/qmimodem/radio-settings.c |   3 +
 3 files changed, 99 insertions(+), 50 deletions(-)

-- =

2.14.1


--===============8412942129465319837==--

