Content-Type: multipart/mixed; boundary="===============2068424339202721586=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 00/11] Samsung IPC modem support
Date: Wed, 19 Sep 2012 11:49:35 +0200
Message-ID: <5059952F.8010407@monom.org>
In-Reply-To: <1347992335-9016-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2068424339202721586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,


On 18.09.2012 20:18, Simon Busch wrote:
> Heyho,
>
> the following patch series adds support for the Samsung IPC protocol whic=
h is implemented
> in an external library called libsamsung-ipc (see [0]). The library conta=
ins the
> implementation of the protocol used in most Samsung mobile handsets. As o=
f right now the
> implementation contains drivers for the devinfo, sim, voicecall, gprs and=
 gprs-context
> subsystems. Implementation for other subsystems like sms will follow.


The COPYING file from the libsamsung-ipc indicates that it is released =

under GPLv3. oFono is pure GPLv2. I fear this is a show stopper.

cheers,
daniel

--===============2068424339202721586==--

