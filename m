Content-Type: multipart/mixed; boundary="===============0704412350914377984=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/1] To fix Huawei GPRS context issue 
Date: Thu, 08 Jul 2010 18:17:48 +0800
Message-ID: <1278584269-3995-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0704412350914377984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Today I tested GPRS connection on Huawei E1552 modem and found similar issu=
es on EM770W before. After I activate/deactivate GPRS contexts several time=
s, the Ubuntu system is totally crashed with Caps lock blinkig. If I recrea=
te the whole GPRS atom, the problem is gone.

To Kalle, have you meet the same case on E1552?

Thanks.
Zhenhua


--===============0704412350914377984==--

