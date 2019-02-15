Content-Type: multipart/mixed; boundary="===============3042290033084210224=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] qmi: support sim hotplug
Date: Fri, 15 Feb 2019 15:37:23 +0100
Message-ID: <1550241444-14106-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3042290033084210224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a small patch to support SIM removal and insertion for QMI modems.
I think indication used is not supported by all QMI modems.
It has been tested on EG25G after enabling feature using AT+QSIMDET AT comm=
and.

Christophe Ronco (1):
  qmi: support sim hotplug

 drivers/qmimodem/sim.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 drivers/qmimodem/uim.h |  2 +-
 2 files changed, 41 insertions(+), 5 deletions(-)

-- =

2.7.4


--===============3042290033084210224==--

