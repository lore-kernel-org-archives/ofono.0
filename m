Content-Type: multipart/mixed; boundary="===============2835259418928721471=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/4] support MC7430 Sierra modem
Date: Wed, 28 Dec 2016 16:03:58 +0100
Message-ID: <20161228150402.15660-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2835259418928721471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have made some patch to add the support of the MC7430 Sierra modem.
This is a QMI modem.
I chose to use qmimodem sim driver instead of qmimodem simlegacy driver
because:
 - a QMI command used in sim-legacy is not supported by MC7430
 - UIM commands are more powerfull than DMS commands

I had some other problems fixed in following patches.
With these patches I am able to see the MC7430 modem as a service in
connman over ofono and to connect and disconnect it.

Patch can be applied to ofono 1.19.

Christophe

Christophe Ronco (4):
  MC7430: use qmimodem sim driver
  MC7430: add read_imsi feature to qmimodem sim driver
  MC7430: fix get signal strength
  MC7430: fix QMI notification messages handling

 drivers/qmimodem/nas.h |  2 +-
 drivers/qmimodem/qmi.c |  2 +-
 drivers/qmimodem/sim.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++=
----
 plugins/gobi.c         |  2 +-
 plugins/udevng.c       |  2 --
 5 files changed, 82 insertions(+), 12 deletions(-)

-- =

2.11.0


--===============2835259418928721471==--

