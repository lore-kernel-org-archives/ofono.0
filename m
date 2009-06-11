Content-Type: multipart/mixed; boundary="===============2108708572992443591=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 09:16:38 +0300
Message-ID: <7bc2c3262bf41a8bdc07149a9fea3098@localhost>
In-Reply-To: <200906101115.20159.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2108708572992443591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 10 Jun 2009 11:15:19 -0500, Denis Kenzior <denkenz@gmail.com>
wrote:
> It doesn't seem this clear-cut.  E.g. according to my Neo on with
T-Mobile
> US =

> SIM:
> =

> AT+COPS?
> +COPS: 0,0,"T-Mobile"
> OK
> AT+COPS=3D3,2
> OK
> AT+COPS?
> +COPS: 0,2,"31026"
> OK
> AT+COPS=3D2
> OK
> +CREG: 0
> AT+COPS=3D1,2,"31026"
> OK
> +CREG: 2
> +CREG: 1,"99EC","1A11"
> =

> At least according to wikipedia the real MCC/MNC of T-Mobile is 310260. =

Go
> =

> figure.

I think this might be a separate issue with some North American operators
that seem to pad also 3-digit codes, effectively dropping that trailing
zero. Perhaps this is for legacy reasons.
 =

>> Nokia modems both send and receive MNC/MCC pairs as Binary Coded Decimal
>> (BCD) strings. Any 2 digit MNC is padded with 0xF. Problem is, when
>> listing
>> operators, the conversion of MNC codes from BCD to short loses this
>> information, and will result in manual network selection failing (BCD
>> '001'
>> -> short '1' -> BCD '01F' !=3D BCD '001').
>>
>> Anyone opposed to changing the mnc and mcc code types from short to
>> string?
>>
> =

> I agree that this does seem to be an issue, so no problems in changing
> this.  =

> Do you consider this an implementation issue only (e.g. APIs do not
change)
> or =

> do you want to change the NetworkOperator attributes to a string as well?


I would go ahead and change them as well. In theory, there could exist both
2- and 3-digit MNCs within a single MCC, for which having strings is the
safest option.

Cheers,
Aki

--===============2108708572992443591==--

