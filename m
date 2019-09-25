Content-Type: multipart/mixed; boundary="===============2607572578719483548=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 0/3] ublox device initialisation
Date: Wed, 25 Sep 2019 06:35:04 +0200
Message-ID: <20190925043507.29892-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2607572578719483548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changed in v3:
- consolidate device closing into a common helper
- remove timeout in disable function

Jonas Bonn (3):
  ublox: consolidate teardown in common function
  ublox: use common close_devices when modem disabled
  ublox: rework device initialization sequence

 plugins/ublox.c | 155 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 118 insertions(+), 37 deletions(-)

-- =

2.20.1


--===============2607572578719483548==--

