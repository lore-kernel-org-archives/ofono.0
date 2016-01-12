Content-Type: multipart/mixed; boundary="===============3035406200019515620=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Tue, 12 Jan 2016 10:52:23 -0600
Message-ID: <56952F47.5070904@gmail.com>
In-Reply-To: <CADnUhn2vxkMDZrBkTL98BryyOmzPUM=ivceK1ekcV+uLHgKZcQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3035406200019515620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On 01/12/2016 10:46 AM, matti kaasinen wrote:
>
> Hi Denis,
> 2016-01-12 18:30 GMT+02:00 Denis Kenzior <denkenz@gmail.com
> <mailto:denkenz@gmail.com>>:
>
>
>         activate-context
>         =3D>
>         Error activating /huawei_0/context1: org.ofono.Error.NotImplement=
ed:
>         Implementation not provided
>
>
>     There is no gprs context driver provided or it failed to setup.  Do
>     you have TUN/TAP in the kernel or kernel module?
>
> It was not loaded, but I modprobed it now manually and got different
> error message:
> Error activating /huawei_1/context1: org.ofono.Error.Failed: Operation
> failed

Please provide the AT command trace.

>
>
>     Please note, that there are two different versions of the Huawei
>     cards supported by oFono.  One uses the "gobi" driver (these are
>     Qualcomm chips).  While the more traditional one uses PPP & the
>     "huawei" driver.
>
>
> I suppose I should edit setup_gobi() and vendor_list() as before in case
> it's "gobi"?

Its a bit more subtle.  Check the logic in udevng.c setup_huawei()

Regards,
-Denis

--===============3035406200019515620==--

