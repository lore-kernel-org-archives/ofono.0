Content-Type: multipart/mixed; boundary="===============8430348122031945537=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: DUN client questions
Date: Thu, 20 Jan 2011 12:08:46 +0200
Message-ID: <87tyh3sx8x.fsf@potku.valot.fi>
In-Reply-To: <4D36B625.6000009@sysgo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8430348122031945537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rolf,

Rolf Offermanns <roffermanns@sysgo.com> writes:

> Here is what I did to get the DUN connection up:
>
> 1. Connect the mobile using the bluetooth applet in MeeGo
>    -> The modem was recognized as DUN capable and shows up in the
>       "list-modems" output from ofonos test script as "/dun/xxx_yyy"
> 2. Then using the ofono test scripts: enable_modem,
> create-internet-context, activate-context

connman should enable modem and all the magic needed to set it up, you
should not need to run ofono test scripts.

> Questions:
> - How to proceed from here. What is missing to have the context show up
> in the meego-network-panel?

It seems that somehow connman doesn't detect the modem. Once connman
detects it, I would assume UI would show it as well.

-- =

Kalle Valo

--===============8430348122031945537==--

