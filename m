Content-Type: multipart/mixed; boundary="===============4977416363141444237=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Huawei E1552 broken
Date: Tue, 08 Jun 2010 12:52:39 +0300
Message-ID: <87r5khzw9k.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4977416363141444237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I mentioned this briefly on irc, but I'll inform it here as well. This
patch broke ofono support for my Huawei E1552:

commit 6ab0b6f29acc8f6b2a5f3b94c02c405ee7318244
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Sun Jun 6 15:51:36 2010 -0700

    Fix detection of Huawei E220 and E270 modems

Huawei plugin uses /dev/ttyUSB1 for the event channel but for my modem
it should be /dev/ttyUSB2. We need to solve this problem somehow, even
if we need to add usb ids to ofono.rules.

-- =

Kalle Valo

--===============4977416363141444237==--

