Content-Type: multipart/mixed; boundary="===============8273128694941252901=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [RFC 2/4] stk: Handle Launch Browser proactive command
Date: Thu, 13 Jan 2011 16:56:56 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802D5A07B@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTikjKnoR7di__8BKW-VCGBU5WrkCLYCcsqn3pF4y@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8273128694941252901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>> =

>> So a question about this. =C2=A0Why are we checking the netreg atom?
>> Shouldn't we be checking the gprs atom's attached property? =C2=A0But th=
is
>> brings up an even more interesting question, do we even need to
>> assume that we have to be attached to the cellular network to
>> perform these operations? =C2=A0We could in theory go over wifi.
> =

> I agree that the modem online property is unrelated to this.
> Also the card may in theory specify a URL that designates a
> local file or something on a local network, not the internet.
> =


Agree. It can be anything not only cellular network. Do we need
to check the bearer parameters in that case or can I just remove the
current check code?

Regards,
Jeevaka

--===============8273128694941252901==--

