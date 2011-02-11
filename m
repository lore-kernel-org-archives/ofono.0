Content-Type: multipart/mixed; boundary="===============8423404936408144486=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: Issue with GPRS not attached?
Date: Thu, 10 Feb 2011 23:01:53 -0800
Message-ID: <1297407713.2181.8.camel@think03>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8423404936408144486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi there,

Has anyone seen this issue with oFono:
Error activating /ifx0/context1: org.ofono.Error.NotAttached: GPRS is
not attached

I am using IFX modem with specific hardware board. I have not seen this
issue before. I was using latest oFono from git (cloned sometimes on
Thursday, Feb 10, 2011). Maybe SIM card changed features? :-) =


[root(a)localhost test]# ./list-contexts
[ /ifx0 ]
    [ /ifx0/context1 ]
        Username =3D =

        Protocol =3D ip
        Name =3D Internet
        Settings =3D { }
        Active =3D 0
        AccessPointName =3D wap.cingular
        Password =3D =

        Type =3D internet
[root(a)localhost test]# =


Context has been created, and APN was added. Log file did not look
suspicious, so it should run fine. =


However, when I try =

[root(a)localhost test]# ./enable-gprs =

Connecting modem /ifx0...
[root(a)localhost test]#

- no error

But

[root(a)localhost test]# ./activate-context =

Error activating /ifx0/context1: org.ofono.Error.NotAttached: GPRS is
not attached

GPRS driver was successful loaded, and several GPRS channels created
during the ifx_enable(), from plugin. Each GPRS context seems to be
added properly. =


I have not seen any particular error in the log, that would hint
something more solid. =


Connman does not see the celular profile, as well.

Thanks for hints,
-- r.  =



--===============8423404936408144486==--

