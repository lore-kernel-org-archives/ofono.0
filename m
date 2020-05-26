Content-Type: multipart/mixed; boundary="===============7086858426458479629=="
MIME-Version: 1.0
From: poeschel@lemonage.de
Subject: [PATCH 0/7] Add quectel EC21 in serial mode
Date: Tue, 26 May 2020 12:16:18 +0200
Message-ID: <20200526101625.31871-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7086858426458479629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lars Poeschel <poeschel@lemonage.de>

This patchset adds support for the quectel EC21 LTE modem connected
through its serial port.

Lars Poeschel (7):
  quectel: Add Quectel EC21 to known serial modems
  quectel: use lte atom on EC21
  quectel: Query the model before setting up the mux
  quectel: EC21 needs aux channel to be the first mux channel
  quectel: EC21 does not understand AT+QIURC
  voicecall: Quectel modem do not understand AT+CNAP
  quectel: EC21 add ussd with atmodem driver

 drivers/atmodem/voicecall.c |   4 +-
 plugins/quectel.c           | 153 +++++++++++++++++++++++-------------
 2 files changed, 101 insertions(+), 56 deletions(-)

-- =

2.26.2

--===============7086858426458479629==--

