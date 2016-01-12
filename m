Content-Type: multipart/mixed; boundary="===============8567932583540403238=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Tue, 12 Jan 2016 10:30:03 -0600
Message-ID: <56952A0B.9060203@gmail.com>
In-Reply-To: <CADnUhn2f+==CS=5E1Bm07z7ChDch_tF=Vw78onqg+vPQ7b1fNQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8567932583540403238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matti,

 > test/online-modem
> =3D>
> - lots of traffic in ofono log
> - modem switches from blinking green to blinking blue
> - connmanctl monitor reports cellular interface (Powered=3DTrue + other
> status)
>

So modem goes online...

>
> activate-context
> =3D>
> Error activating /huawei_0/context1: org.ofono.Error.NotImplemented:
> Implementation not provided

There is no gprs context driver provided or it failed to setup.  Do you =

have TUN/TAP in the kernel or kernel module?

Please note, that there are two different versions of the Huawei cards =

supported by oFono.  One uses the "gobi" driver (these are Qualcomm =

chips).  While the more traditional one uses PPP & the "huawei" driver.

Regards,
-Denis

--===============8567932583540403238==--

