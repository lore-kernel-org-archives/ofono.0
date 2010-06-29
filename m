Content-Type: multipart/mixed; boundary="===============5119870775591745150=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/3] Merge Huawei EM770 into plugins/huawei.c
Date: Tue, 29 Jun 2010 15:07:07 +0800
Message-ID: <1277795230-18323-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5119870775591745150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series merges existing plugins/em770.c with plugins/huawei.c. The most=
 part of EM770 is the same as plugins/huawei.c, except EM770 has voicecall =
capability. The idea is to get modem model from udev. If it is EM770, we en=
able voicecall and related features for EM770 only.

Best Regards,
Zhenhua

--===============5119870775591745150==--

