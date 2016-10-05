Content-Type: multipart/mixed; boundary="===============8191676213102703402=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: IPV6 question
Date: Wed, 05 Oct 2016 13:01:03 -0500
Message-ID: <57F53FDF.4020501@gmail.com>
In-Reply-To: <CAH4ZQwtH8U2kftiLgq1DXsvtkQa6sHVDH4vUbooB5itft-_bvg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8191676213102703402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 10/05/2016 01:50 AM, Enrico Sau wrote:
> Hi all,
>
> I'm still trying to make IPV6 work.
> First, I ensured that my modem and network support IPV6 making a
> successful IPV6 connection with linux pppd.

Which modem are you using, if its no secret?

>
> Then I set the ofono context protocol to "dual", removed the check on
> the protocol in at_gprs_activate_primary(), and set +CGDCONT with
> "IPV4V6" which works for my modem.
>
> Result is that the modem successfuly get an IPV6 address because I can
> query it from another AT channel, but ofono does not retrieve any IPV6
> parameters:
>
> [ /le910na1_0/context1 ]
>          Username =3D
>          AccessPointName =3D
>          Settings =3D {
>                      Interface =3D ppp0
>                      Method =3D static
>                      DomainNameServers =3D 172.22.1.201,  0.0.0.0,
>                      Address =3D 172.22.1.101
>                      Netmask =3D 255.255.255.255 }
>          AuthenticationMethod =3D chap
>          Password =3D
>          Protocol =3D dual
>          Type =3D internet
>          Active =3D 1
>          IPv6.Settings =3D {
>                      Interface =3D ppp0 }
>          Name =3D Internet
> The consequence is that the ppp0 interface only has an IPV4 address.
> I also tried with IPV6 only but same result.
> Any hints?
>

It looks like IPV6CP was never properly integrated into GAtPPP logic. =

At least I don't see ipv6cp_new() inside gatchat/gatppp.c anywhere.  You =

might have to extend gatppp.c to manage IPV6CP as well.

Regards,
-Denis


--===============8191676213102703402==--

