Content-Type: multipart/mixed; boundary="===============1615565187102499802=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH 0/5] ubloxmodem support +UCGED mode 2
Date: Tue, 13 Dec 2016 12:05:23 +0100
Message-ID: <1481627128-20233-1-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1615565187102499802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

These patches support +UCGED mode 2 for ubloxmodem to collect some
Network environment statistics.

For now it only returns the following:
EARFCN  E-UTRA Absolute Radio Frequency Channel Number (official name)
EBAND   E-UTRA Band
CQI     Channel Quality Indicator


Questions:

EBAND in ublox documentation is called LBand in +UCGED command doc.
It refers to E-UTRA Band , so I did go with the name EBAND instead of
LBAND, not sure if this is the right thing to do ?

If other values of +UCGED are useful upstream I will try to send them.

Will also follow up with a patch that allows older firmware to make use
of +UCGED mode 3.

Djalal Harouni (5):
  netmon: add NETMON_INFO_{EARFCN|EBAND|CQI}
  doc: document netmon EARFCN, EBand and CQI properties
  netmon: handle OFONO_NETMON_INFO_{EARFCN|EBAND|CQI}
  test:netmon: support EARFCN, Eband and CQI in testing
  ublox:netmon: support +UCGED and get EARFCN, EBAND and CQI

--===============1615565187102499802==--

