Content-Type: multipart/mixed; boundary="===============8473401721439610227=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH 0/6] gemalto's ALS3 and PHS8P support
Date: Thu, 15 Mar 2018 13:49:24 +0100
Message-ID: <1521118170-23722-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8473401721439610227==
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


--===============8473401721439610227==--

