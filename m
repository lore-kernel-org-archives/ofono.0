Content-Type: multipart/mixed; boundary="===============3277695667234699595=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v2 5/6] atmodem: add signal strength support for huawei
Date: Mon, 03 May 2010 09:43:24 +0300
Message-ID: <87eihta3jn.fsf@potku.valot.fi>
In-Reply-To: <1272634736.22838.196.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3277695667234699595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,
>
>> Huawei doesn't support CIND indications, instead it uses some non-standa=
rd
>> RSSI messages:
>> =

>> ofonod[6401]: < \r\n^RSSI:23\r\n
>> =

>> Add support for this to atmodem.
>
> please use ofono_netreg_strength_notify for this.
>
> The Huawei specific details with this stupid extra channel need to be
> handled inside the Huawei plugin. Cluttering the core with it is not a
> good idea.

I fully agree. I'll do this.

-- =

Kalle Valo

--===============3277695667234699595==--

