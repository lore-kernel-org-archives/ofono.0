Content-Type: multipart/mixed; boundary="===============0673838149190185024=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RFC PATCH v2 1/4] sms_util: status_report_expiration
Date: Fri, 10 Sep 2010 22:24:37 +0300
Message-ID: <AANLkTikirDsNwAJnMnP=M3jsAMeyynrykpFJTh_hovjQ@mail.gmail.com>
In-Reply-To: <4C8A53A3.7000001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0673838149190185024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/9/10 Denis Kenzior <denkenz@gmail.com>:
> I've been hearing reports that some networks actually rewrite the
> address (e.g. change national number to international, etc) which causes
> our status reports to not match.

That happens.

> We can do two things:
> 1. Rely on message reference only. =C2=A0This seems dangerous
> 2. Fallback to a 'fuzzy'. =C2=A0E.g. try to match on the reference and la=
st n
> digits of the phone number, ignoring ton/npi. =C2=A0This can get tricky as
> some national numbers can get different prefixes from the equivalent
> international number, so we need to pick a nice value of 'n'.

I seem to recall some empirical evidence that n=3D6 works well, when
paired with the message reference.

Cheers,
Aki

--===============0673838149190185024==--

