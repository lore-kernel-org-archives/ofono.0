Content-Type: multipart/mixed; boundary="===============6055699251693088931=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Telit ME910C1-WW not detected
Date: Tue, 23 Jul 2019 15:11:16 +0200
Message-ID: <CAKSBH7FXFetDHJZoA_xwVP6H3DmGFo7x_b9WtRX5w2dGoRnH+g@mail.gmail.com>
In-Reply-To: <599D0C5744F85B4480C6B0762332A90524D0FE4F@dmdgate08-vm02.DMD06.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6055699251693088931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Gabriele,

On Tue, Jul 23, 2019 at 2:50 PM Dresdo Gabriele <Gdresdo@dmd.it> wrote:
>
> Hello,
>
> I'm new to oFono, I'm trying to setup a Telit ME910C1 with oFono 1.18 in =
our embedded system (ARMHF) with Debian stretch kernel 4.9.11 but list-mode=
ms returns no results.
>
> I installed ofono packet using apt-get

try install it from the official repository with git clone. You will
also need the ell library. These are the two official repositories:
   https://git.kernel.org/pub/scm/network/ofono/ofono.git
   https://git.kernel.org/pub/scm/libs/ell/ell.git/

The version 1.18 is a bit old.

>
> I can send and receive AT commands to the modem using a terminal connecte=
d to /dev/ttyUSB1
>
> I paste Log from ofonod -dn.
>
> Any suggestion will be useful
>
> Thanks
>
> Gabriele
>

If this doesn't work, it means that your modem is not supported.
In this case, please sent the result of:
   lsusb
   lsusb -t
(the part relevant for your modem)

Regards,
Giacinto

--===============6055699251693088931==--

