Content-Type: multipart/mixed; boundary="===============0913762659625079899=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [sim-fdn PATCH 1/4] sim: add EnableFDN and DisableFDN methods
Date: Thu, 26 Aug 2010 18:54:01 +0300
Message-ID: <AANLkTinEf+aYvROkSJFEen9ameRZ0+MeLbRNfkdXyphC@mail.gmail.com>
In-Reply-To: <4C7686E4.5040007@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0913762659625079899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/8/26 Denis Kenzior <denkenz@gmail.com>:
> Hi Pekka,
>
> On 08/26/2010 07:52 AM, Pekka.Pessi(a)nokia.com wrote:
>> From: Pekka Pessi <Pekka.Pessi@nokia.com>
>>
>> Enable or disable Fixed Dialing Numbers feature on SIM card.
>>
>> If enabled, calls can be dialled or SMSs sent only to numbers listed on
>> special FDN phonebook on the SIM card.
>
> FDN has serious implications for the rest of the system, particularly on
> SMS atom and Sim Toolkit. =C2=A0oFono will either have to support the ent=
ire
> thing properly or use a 'limited' FDN mode (e.g. if FDN is enabled, we
> only permit emergency calls.)

> We have really not made our mind what makes sense here yet.

I think most modems support FDN in the firmware. (Well, famous last
words.) I don't think it makes any sense to support or "support" it in
oFono.

-- =

Pekka.Pessi mail at nokia.com

--===============0913762659625079899==--

