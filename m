Content-Type: multipart/mixed; boundary="===============0948387745204827145=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei EM 770 not working properly
Date: Thu, 04 Nov 2010 09:16:50 -0500
Message-ID: <4CD2C052.1050909@gmail.com>
In-Reply-To: <1288869331.10035.0.camel@par-r81vxc7.par.novell.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0948387745204827145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On 11/04/2010 06:15 AM, Frederic Crozat wrote:
> Hi,
> =

> I'm trying to get ofono working properly with integrated 3G card on my
> EEE PC.
> =

> Card is Huawei EM 770 (12d1:1001).
> =

> I'm testing with ofono 0.34.
> =

> so far, the modem is correctly detected :
> =

> list-modem returns :
> [ /huawei0 ]
>  Features =3D sim
>  Powered =3D 1
>  Interfaces =3D org.ofono.SimManager
>  Online =3D 0
>  Model =3D EM770
>  Manufacturer =3D huawei
>  Serial =3D ....
>  Revision =3D 11.104.16.12.00
>  [ org.ofono.SimManager ] =

>   Present =3D 0

What is happening is that oFono thinks the sim is not inserted, and it
does not proceed further with modem initialization.  oFono polls the
SYSINFO command, with one of the fields being the status of the SIM.

Do you have a SIM PIN set?  The current huawei driver does not handle
this case gracefully yet, mainly because the huawei firmware is quite
'peculiar'.

The other possibility is that the EM770 firmware is simply acting
different than other huawei devices and the driver needs to be updated.

Kalle touched the SYSINFO polling last, so maybe he has more insight...

Regards,
-Denis

--===============0948387745204827145==--

