Content-Type: multipart/mixed; boundary="===============0207339482959427103=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Setting up the Telit HE910 and Option GTM382
Date: Mon, 08 Apr 2013 11:01:02 -0500
Message-ID: <5162E9BE.9040601@gmail.com>
In-Reply-To: <CAMtf1D-Ryk3EcxT9UfcnFHBje-5WM3gdR4C6jtAOgDxN_vpxiw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0207339482959427103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

> I also used gdbserver to find out where the problem is. Here is the
> backtrace from where i think the failure is :
>
>     =E2=94=82230                     }
>     =E2=94=82231             }
>     =E2=94=82232
>  >=E2=94=82233             fd =3D open(tty, O_RDWR | O_NOCTTY |
> O_NONBLOCK);               /* the open function fails and returns -1 */
>     =E2=94=82234             if (fd < 0)
>     =E2=94=82235                     return -1;
>     =E2=94=82236
>     =E2=94=82237             tcflush(fd, TCIOFLUSH);
>

Can you trace and see what the errno is being set to?  I really have no =

idea what could be causing this.

Regards,
-Denis

--===============0207339482959427103==--

