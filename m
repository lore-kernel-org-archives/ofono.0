Content-Type: multipart/mixed; boundary="===============1246385574276043060=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: Re: [PATCH 00/11] Samsung IPC modem support
Date: Wed, 19 Sep 2012 21:16:48 +0200
Message-ID: <505A1A20.70902@gravedo.de>
In-Reply-To: <5059952F.8010407@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1246385574276043060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Am 19.09.2012 11:49, schrieb Daniel Wagner:
> Hi Simon,
> =

> =

> On 18.09.2012 20:18, Simon Busch wrote:
>> Heyho,
>>
>> the following patch series adds support for the Samsung IPC protocol
>> which is implemented
>> in an external library called libsamsung-ipc (see [0]). The library
>> contains the
>> implementation of the protocol used in most Samsung mobile handsets.
>> As of right now the
>> implementation contains drivers for the devinfo, sim, voicecall, gprs
>> and gprs-context
>> subsystems. Implementation for other subsystems like sms will follow.
> =

> =

> The COPYING file from the libsamsung-ipc indicates that it is released
> under GPLv3. oFono is pure GPLv2. I fear this is a show stopper.

Thats something that will change in the near future. Good thing I am the
author of libsamsung-ipc too :)

regards,
Simon

-- =

Simon Busch - http://mm.gravedo.de/blog/

--===============1246385574276043060==--

