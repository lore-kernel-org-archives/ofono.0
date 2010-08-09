Content-Type: multipart/mixed; boundary="===============7497075927850012650=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] add default property setter for modemconf
Date: Mon, 09 Aug 2010 04:24:17 -0400
Message-ID: <1281342257.12579.189.camel@localhost.localdomain>
In-Reply-To: <AANLkTi=itV4peGUyvxmU5LeS-cryWVTqFJm=jR5dPuM_@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7497075927850012650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Leaf,

> I was trying to run ofono for a huawei usb modem on my meego netbook,
> but the udev on netbook seems not work for ofono, so that I've to
> mannualy write settings in modem.conf.
> =

> Huawei driver needs two device, pcui & modem, and I can't specify them
> by either Interface & Device in modem.conf.
> =

> Then I wrote this patch, It will load all Key=3DValue pairs in
> modem.conf file( Except Driver=3Dxxx pair ), and store them to modem
> properties.
> =

> Then I add Pcui=3D & Modem=3D entry in modem.conf file, it works, I can
> use ofono to send & recieve message by huawei stick now.

my question is why you wanna do this at all? oFono should auto-detect
any Huawei modem via udev. So this is not needed.

Regards

Marcel



--===============7497075927850012650==--

