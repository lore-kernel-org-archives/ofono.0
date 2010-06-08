Content-Type: multipart/mixed; boundary="===============7515439619517928658=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Huawei E1552 broken
Date: Tue, 08 Jun 2010 18:03:10 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351EAD924E@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <87r5khzw9k.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7515439619517928658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Kalle Valo wrote:
> Hi,
> =

> I mentioned this briefly on irc, but I'll inform it here as well. This
> patch broke ofono support for my Huawei E1552:
> =

> commit 6ab0b6f29acc8f6b2a5f3b94c02c405ee7318244
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Sun Jun 6 15:51:36 2010 -0700
> =

>    Fix detection of Huawei E220 and E270 modems
> =

> Huawei plugin uses /dev/ttyUSB1 for the event channel but for my modem
> it should be /dev/ttyUSB2. We need to solve this problem somehow, even
> if we need to add usb ids to ofono.rules.

Denis has already updated udev.c by commit 71ea72adf and now it detects int=
erface number by ofono.rules. So I think you should add one more E1552 spec=
ific item in ofono.rules with your product id and interface number, etc.
 =

> --
> Kalle Valo
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============7515439619517928658==--

