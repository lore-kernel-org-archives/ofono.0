Content-Type: multipart/mixed; boundary="===============2818810173427715602=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Issue with GPRS not attached?
Date: Thu, 10 Feb 2011 23:10:21 -0800
Message-ID: <1297408221.2647.4.camel@aeonflux>
In-Reply-To: <1297407713.2181.8.camel@think03>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2818810173427715602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> Has anyone seen this issue with oFono:
> Error activating /ifx0/context1: org.ofono.Error.NotAttached: GPRS is
> not attached

this normally does mean exactly what it says. You are not attached to
the GPRS network. If not attached you can not establish any GPRS
connection.

> I am using IFX modem with specific hardware board. I have not seen this
> issue before. I was using latest oFono from git (cloned sometimes on
> Thursday, Feb 10, 2011). Maybe SIM card changed features? :-) =

> =

> [root(a)localhost test]# ./list-contexts
> [ /ifx0 ]
>     [ /ifx0/context1 ]
>         Username =3D =

>         Protocol =3D ip
>         Name =3D Internet
>         Settings =3D { }
>         Active =3D 0
>         AccessPointName =3D wap.cingular
>         Password =3D =

>         Type =3D internet
> [root(a)localhost test]# =

> =

> Context has been created, and APN was added. Log file did not look
> suspicious, so it should run fine. =

> =

> However, when I try =

> [root(a)localhost test]# ./enable-gprs =

> Connecting modem /ifx0...
> [root(a)localhost test]#
> =

> - no error
> =

> But
> =

> [root(a)localhost test]# ./activate-context =

> Error activating /ifx0/context1: org.ofono.Error.NotAttached: GPRS is
> not attached

You might wanna check with list-modem if you are actually registered to
the CS network and then if so if the PS network is attached or not.

> GPRS driver was successful loaded, and several GPRS channels created
> during the ifx_enable(), from plugin. Each GPRS context seems to be
> added properly. =


Of course that is just fine. This does not involve any network activity.
It just adds the atoms.

Regards

Marcel



--===============2818810173427715602==--

