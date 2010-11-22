Content-Type: multipart/mixed; boundary="===============6212318136761484848=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stkutil: mask the DCS value to keep only the intersting
 bits
Date: Mon, 22 Nov 2010 04:57:40 -0600
Message-ID: <4CEA4CA4.4050604@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813542B193@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6212318136761484848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>>> -	switch (dcs) {
>>> +	switch (dcs & 0x06) {
>>
>> Do you mean to bitwise and with 0xc here?  Otherwise you break the UCS2
>> case.  Also do any SIMs use the '1111' Coding Bits Entry entry from
>> 23.038 Section 4?  If so, then we need to use sms_dcs_decode to
>> retrieve
>> the character set.
> =

> Yes you are right. I did a bit-shifting error in my mask and don't see it=
 during my test.
> It's 0xc and not 0x6 to use for the mask.
> =

> The issue that I've is effectively due to the fact that some SIMs use the=
 '1111' Coding Bits Entry (it's the case for French Orange SIM card for exa=
mple). For me having the upper bits set to '1' do not really changes the ch=
aracter set decoding (only diff is that UCS2 will not be possible in that c=
ase). It's the reason why I've simply add a mask in the decode_text functio=
n. Using the sms_dcs_decode function is probably better as the DCS of the S=
IM ToolKit is the same as the one used for SMS.
> =

> Do you want that I re-publish a patch using the sms_dcs_decode function?

Bitwise shifting with 0x0c would work.  However, to be safe we might
just be extra pedantic and check that the DCS the SIM sends to us is
actually valid.

Regards,
-Denis

--===============6212318136761484848==--

