Content-Type: multipart/mixed; boundary="===============5734240641172098408=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH 0/6] gemalto's ALS3 and PHS8P support
Date: Mon, 12 Mar 2018 13:57:07 +0100
Message-ID: <1520859433-14112-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5734240641172098408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch serie bring further support to PHS8P modem
and the same level of support for ALS3 modem. Here are
the lists on enhancements:
- ALS3 is detected by Ofono and uses the gemalto plugin
- SIM removing and insertion is supported
- The optional Technology property on NetworkRegistration
is supported
- We ensure that the modem is ready to work before
initializing it

Some of the enhancements are brought by workarounds because
of AT command interface limitations

Gabriel Lucas (4):
  gemalto: add detection of ALS3 modem
  gemalto: support ALS3 in gemalto's plugin
  sim: give access to the driver
  gemalto: fix sim reinsertion issue

Mariem Cherif (2):
  gemalto: acquire the network technology
  gemalto: handle sim is inserted or removed URCs

 drivers/atmodem/network-registration.c |  45 +++++++++
 include/sim.h                          |   2 +
 plugins/gemalto.c                      | 169 +++++++++++++++++++++++++++++=
++--
 plugins/udevng.c                       |  18 ++++
 src/sim.c                              |   5 +
 5 files changed, 233 insertions(+), 6 deletions(-)

-- =

1.9.1


--===============5734240641172098408==--

