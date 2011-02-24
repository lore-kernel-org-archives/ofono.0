Content-Type: multipart/mixed; boundary="===============8498313583804742459=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 0/2] add support of void parameters in CMER
Date: Thu, 24 Feb 2011 18:16:04 +0100
Message-ID: <1298567766-17745-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8498313583804742459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

following commands are supported :
AT+CMER=3D3,0,0,1,0

OK
AT+CMER=3D3,0,0,1

OK
AT+CMER=3D3,,,1

OK
AT+CMER=3D3,,,1,

OK
AT+CMER=3D,,0,1,

OK
AT+CMER=3D3, ,,1

OK
AT+CMER=3D3,a,0,1

ERROR
AT+CMER=3D3,"a",0,1

ERROR
AT+CMER=3D3,

OK
AT+CMER=3D3

OK

Fr=C3=A9d=C3=A9ric Danis (2):
  gatchat: add g_at_result_iter_next_number_default API
  emulator: add support of void parameters in CMER

 gatchat/gatresult.c |   30 ++++++++++++++++++++++++++++++
 gatchat/gatresult.h |    2 ++
 src/emulator.c      |   24 ++++++++++++------------
 3 files changed, 44 insertions(+), 12 deletions(-)


--===============8498313583804742459==--

