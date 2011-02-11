Content-Type: multipart/mixed; boundary="===============1301414436828360587=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/1] Fix issue in ifxmodem set rat mode
Date: Fri, 11 Feb 2011 11:20:28 -0800
Message-ID: <1297452029-13911-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1301414436828360587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
 =

  Find the syntax of the XRAT set command:

Defined values

<AcT> indicates the radio access technology and may be

0 GSM single mode
1 GSM / UMTS Dual mode
2 UTRAN (UMTS)

< PreferredAct > This parameter is used for network registration in case of=
 <AcT>=3D1.

0 RAT GSM
2 RAT UMTS

Regards,
Jeevaka

Jeevaka Badrappan (1):
  ifxmodem: fix issue in set rat mode

 drivers/ifxmodem/radio-settings.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)


--===============1301414436828360587==--

