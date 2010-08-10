Content-Type: multipart/mixed; boundary="===============7656341701234669352=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/10] Unregister AT notifiers when removing drivers
Date: Tue, 10 Aug 2010 22:43:39 +0800
Message-ID: <1281451429-17257-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7656341701234669352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series unregister AT notifiers in removing various AT modem drivers wh=
en modem goes to offline mode. Please review them.

We should fix other modem drivers other than atmodem as well. I will send s=
eperate patches for review.

To Emmanuel, could you try these patches to see wheter it fixes your proble=
ms? Thanks.

Regards,
Zhenhua


--===============7656341701234669352==--

