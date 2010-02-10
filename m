Content-Type: multipart/mixed; boundary="===============2152477123686948603=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] Add support of Huawei EM770 modem
Date: Wed, 10 Feb 2010 18:03:55 +0100
Message-ID: <fb249edb1002100903g24e90ecbn64430da3badc69a@mail.gmail.com>
In-Reply-To: <1EC975D79B8B1F4BBDC50EA54418A00412219846A9@shzsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2152477123686948603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 10 February 2010 11:17, Gu, Yang <yang.gu@intel.com> wrote:
> 1. Once connecting this modem to PC via USB, we can get 5 tty ports: ttyU=
SB0, ttyUSB1, ttyUSB2, ttyUSB3 and ttyUSB4. The correct way to talk to this=
 modem is using ttyUSB2. I'm not sure if I handled this correctly in file u=
dev.c.

If there are more devices on the system that have a USB serial
interface the ttyUSBn numbers will be different so it would be more
reliable to decide based on some other characteristic of ttyUSB2 than
the name (don't know which, maybe you can retrieve USB
config/interface number).  If there's nothing better, then maybe take
n =3D 2 + the lowest number of the five devices.

Regards,

--===============2152477123686948603==--

