Content-Type: multipart/mixed; boundary="===============5223127544050528821=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: FW: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Fri, 07 May 2010 13:27:55 +0200
Message-ID: <i2wfb249edb1005070427nc826698w8ecbfd952b9061ad@mail.gmail.com>
In-Reply-To: <COL106-W4E56D0EA71CF82AF31100F6F60@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5223127544050528821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 7 May 2010 12:53, krishna k <id_kishore@live.in> wrote:
>
> Hi Dario,
>
> Thank you for your quick reply. I didn't power on the modem. Can you sugg=
est

So phonesim emulates a modem, ofono connects to this modem and first
thing it needs to do is power it up.  Only then the phonesim window
should appear.

To power up the modem you can use the test/modem-enable python script
from ofono.

Cheers

--===============5223127544050528821==--

