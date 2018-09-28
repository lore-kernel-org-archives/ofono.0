Content-Type: multipart/mixed; boundary="===============2893152988475834783=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: status
Date: Fri, 28 Sep 2018 09:45:57 +0200
Message-ID: <8fa934fd-8da7-5953-4543-3b7487e97aec@monom.org>
In-Reply-To: <aa0f22dd-bf16-1f57-a4fc-a9b7261dbc2b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2893152988475834783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 27/09/2018 18:52, Denis Kenzior wrote:>> For the
gemaltomodem/gprs-context, it is not clear how to proceed. Would
>> you kindly give some suggestion other than "these modules don't exist
>> in my world"?
> =

> I did give you a suggestion on how to proceed.=C2=A0 Lets get the sane on=
es
> supported first.=C2=A0 That should be mostly easy.
> =

> For the insane ones we will need to figure something else out.=C2=A0 For
> example, it may be that we should just have oFono initiate the DHCP
> request itself for these devices.=C2=A0 The driver can then control both =
DHCP
> and context activation status and would be able to sanely tell the core
> what is going on.=C2=A0 We already have DHCP code available in ConnMan th=
at
> could be ported to oFono, or more likely finish DHCP support in ell and
> use that.

While we have DHCP code in ConnMan I wouldn't recommend to port it as it
is. Patrik reimplemented DHCP for systemd-netword using ConnMan's
version as blueprint. That code looks much saner. Propably, it would
make sense to carve out a library (using ELL as support library) from
the systemd's version and make ConnMan and oFono depending on it.

Thanks,
Daniel

--===============2893152988475834783==--

