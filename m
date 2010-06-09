Content-Type: multipart/mixed; boundary="===============8666097663518883458=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Huawei E1552 broken
Date: Wed, 09 Jun 2010 09:41:27 +0300
Message-ID: <87eiggzp0o.fsf@potku.valot.fi>
In-Reply-To: <1276029296.2182.51.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8666097663518883458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,

Hi Marcel,

>> But now connman doesn't show the operator name "Saunalahti" anymore, the
>> name property in connman Service is just empty:
>> =

>> ./cmcc show cellular_244053111242822_huawei0_primarycontext1
>> AutoConnect: true
>> Name: =

>> Nameservers: { 193.229.0.40 193.229.0.42 }
>> Proxy: { Method=3Ddirect }
>
> this might be a bug in the oFono plugin in ConnMan. I have encountered
> this as well. I think ConnMan forgets to listen to name changes and to
> update the name. Some times you get the name other times you don't.

Thanks, that's good to know. I have been testing connman and ofono for
some time now, but I saw this problem first time only yesterday. But I
might have been just lucky earlier.

-- =

Kalle Valo

--===============8666097663518883458==--

