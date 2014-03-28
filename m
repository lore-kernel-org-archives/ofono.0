Content-Type: multipart/mixed; boundary="===============8468455929213001820=="
MIME-Version: 1.0
From: Eric BOUXIROT <eric.bouxirot@azimut-monitoring.com>
Subject: Re: wwan0 interface without IP
Date: Fri, 28 Mar 2014 16:42:53 +0100
Message-ID: <lh459e$70b$1@ger.gmane.org>
In-Reply-To: <533594BC.1040308@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8468455929213001820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> After activating the context, run test/list-contexts in oFono git.  What
> does it say?

/usr/lib/ofono/test/list-contexts
[ /sierra_1 ]
    [ /sierra_1/context1 ]
        Username =3D
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { Interface=3Dwwan0 Method=3Ddhcp }
        IPv6.Settings =3D { }
        Active =3D 1
        AccessPointName =3D objcPpublic
        Password =3D
        Type =3D internet

for me it's ok. i have made a test to add a "address" to 0.0.0.0 and =

get this.

/usr/lib/ofono/test/list-contexts
[ /sierra_1 ]
    [ /sierra_1/context1 ]
        Username =3D
        Protocol =3D ip
        Name =3D Internet
        Settings =3D { Interface=3Dwwan0 Method=3Ddhcp Address=3D0.0.0.0 }
        IPv6.Settings =3D { }
        Active =3D 1
        AccessPointName =3D objcPpublic
        Password =3D
        Type =3D internet

but in either cases i got connman getting an address..


--===============8468455929213001820==--

