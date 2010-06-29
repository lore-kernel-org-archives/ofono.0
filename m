Content-Type: multipart/mixed; boundary="===============8591589387249561241=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] huawei: reopen the GPRS context when the modem closes
 it after PPP
Date: Tue, 29 Jun 2010 14:04:23 -0500
Message-ID: <201006291404.23766.denkenz@gmail.com>
In-Reply-To: <20100629075931.18717.84414.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8591589387249561241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Huawei always closes the tty port after PPP disconnect. Handle this in
> huawei plugin, similarly as done with novatel. Now there's no need
> to unplug the modem after disconnection.
> =

> Tested with Huawei E1552.
> =

> Based on a patch by Marcel Holtmann:
> =

> commit 0329a6ceaf8f69857cb5f8437b9db86ca327ef1d
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Mon Jun 7 02:36:12 2010 -0700
> =

>     Reopen the GPRS context channel when the modem closes it after PPP

Both have been applied, thanks.

Regards,
-Denis

--===============8591589387249561241==--

