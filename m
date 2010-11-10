Content-Type: multipart/mixed; boundary="===============3806790592460515876=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Can I modify CallingLineRestriction(the Property of CallSetting)
 value to "disabled" or "enabled"
Date: Wed, 10 Nov 2010 14:32:32 +0200
Message-ID: <AANLkTind3eJwUwGrxXE6LN9q3cV0eJySZtVNXYyzKpbb@mail.gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A47330518CE2@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3806790592460515876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

2010/11/10 Gu, Yang <yang.gu@intel.com>:
>>According to your tip , I tried to set "HideCallerId" to "default", "disa=
bled" and
>>"enabled", and I can verify by run list-modem script that "HideCallerId" =
had been
>>modified . but I still could find phone number on both called party and c=
alling party ,
>>regardless the value of =C2=A0"HideCallerId" is what.
>>
>>How can I let phone number be withheld on incoming at called party , when=
 I make a
>>voice call.
>
> I think the reason is your operator doesn't provide this supplementary se=
rvice. Below is my log when enable the "HideCallerId". I couldn't enable th=
is feature either.
>
> ofonod[17734]: PCUI: > AT+CLIR=3D1\r
> ofonod[17734]: PCUI: < \r\nOK\r\n
> ofonod[17734]: PCUI: > AT+CLIR?\r
> ofonod[17734]: PCUI: < \r\n+CLIR: 1,0\r\n\r\nOK\r\n
> ofonod[17734]: drivers/atmodem/call-settings.c:clir_query_cb() clir_query=
_cb: override: 1, network: 0

What happens when you make a call? Does call get rejected or do you
get some CSSU indications?

Yang and Haitao, please set HideCallerId to "disabled", try to make
call, then set HideCallerId to "enabled", try to make a call, and
perhaps also try to make call with test/dial-number number enabled and
test/dial-number disabled and then post the results.

-- =

Pekka.Pessi mail at nokia.com

--===============3806790592460515876==--

