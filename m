Content-Type: multipart/mixed; boundary="===============1194784937950624224=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Huawei voice output port issue + patch
Date: Fri, 09 Mar 2012 18:26:28 -0800
Message-ID: <1331346388.14217.36.camel@aeonflux>
In-Reply-To: <4F5A9723.5000809@jlranta.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1194784937950624224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

> Voice output serial port is enabled on some Huawei models (e.g. E169) =

> without problems, but for example on E173u-2 it is never enabled during =

> an incoming call. There might also be other Huawei models having the =

> same issue.
> =

> I traced the issue down to "^DDSETEX" AT command, which is used to =

> notify the device to start streaming audio. It seems that Ofono sends =

> this command too early on incoming calls. The command should always be =

> sent *after* the dial "D" or answer "A" command. The patch fixes this =

> behavior and afterwards voice will also work on E173u-2.
> =

> Bug: https://bugs.meego.com/show_bug.cgi?id=3D25004
> Patch: https://bugs.meego.com/attachment.cgi?id=3D9702

inline patches please. I am not digging patches out of Bugzilla.

Regards

Marcel



--===============1194784937950624224==--

