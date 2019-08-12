Content-Type: multipart/mixed; boundary="===============1596089089107082158=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Mon, 12 Aug 2019 16:54:13 +1000
Message-ID: <CAA=hcWQ+TrcGDdOis7i81Y0+0qeJPYAfPQWncb3vhCqp3baaUQ@mail.gmail.com>
In-Reply-To: <CAKSBH7FrgbdEf_b4RTcR1Y6PrzQX=LzXc8NrhrZLN6RChfjcRg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1596089089107082158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 8/11/19, Giacinto Cifelli <gciofono@gmail.com> wrote:

> can you check with the ofono script test/list-contexts if the method
> is static or dhcp?

# ofono/test/list-contexts
[ /ubloxqmi_0 ]
    [ /ubloxqmi_0/context1 ]
        Name =3D Internet
        Type =3D internet
        AuthenticationMethod =3D chap
        Settings =3D { Method=3Dstatic Gateway=3D10.116.103.22 Netmask=3D25=
5.255.255.25}
        Username =3D
        AccessPointName =3D telstra.m2m
        Password =3D
        Protocol =3D ip
        IPv6.Settings =3D { }
        Active =3D 1

Looks like it is static, how can change it to a correct one (dynamic
>)? Or any workarounds?

> I believe this can be the problem: if ofono managed to get an IP
> address, likely with at+cgpaddr and/or at+cgcontrdp,
> then it passes it to connman, and then it is set on the interface...
> static, with no lease expiration.

There are two devices for the SARA-R4 modem, /dev/ttyUSB0 is used for
QMI which is currently using as default protocol. /dev/ttyUSB1 is for
AT, let me know if you like to check AT command, I have never tried to
write / read AT command, are the following commands correct?

echo "at+cgpaddr" > /dev/ttyUSB1
cat < /dev/ttyUSB1

Thank you very much Giacinto.

-- jupiter

--===============1596089089107082158==--

