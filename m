Content-Type: multipart/mixed; boundary="===============8177688590924501695=="
MIME-Version: 1.0
From: Bob Ham <bob.ham@puri.sm>
Subject: [PATCH 0/2] Fix AT+COLP=1 stalling VoiceCall creation in SIMCom
 SIM7100E
Date: Mon, 14 May 2018 14:42:27 +0100
Message-ID: <20180514134229.14050-1-bob.ham@puri.sm>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8177688590924501695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setting AT+COLP=3D1 on the SIMCom SIM7100E causes oFono to stall and not
create a new VoiceCall object.  We fix that by adding the SIMCOM
vendor ID to the list for whom we set AT+COLP=3D0 instead.

Bob Ham (2):
  atmodem: Don't set AT+COLP=3D1 on SIMCom modems
  sim7100: Specify vendor ID while creating voicecall driver

 drivers/atmodem/voicecall.c | 1 +
 plugins/sim7100.c           | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- =

2.11.0


--===============8177688590924501695==--

