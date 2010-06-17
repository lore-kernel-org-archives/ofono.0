Content-Type: multipart/mixed; boundary="===============9209194916354653319=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 05/12] Modify ussd parser
Date: Thu, 17 Jun 2010 18:33:51 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731ED17F93@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201006161748.13719.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9209194916354653319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,



>-----Original Message-----
>From: Denis Kenzior [mailto:denkenz(a)gmail.com]
>Sent: Thursday, June 17, 2010 6:48 AM
>To: ofono(a)ofono.org
>Cc: Gu, Yang
>Subject: Re: [PATCH 05/12] Modify ussd parser
>
>Hi Yang,
>
>> * Original code doesn't call unpack_7bit(), which seems not correct.
>> * An utility function is used to handle it, which supports 8-bit
>> and ucs2 besides 7-bit character.
>> * Status is assigned with correct value when error occurs
>
>Please drop this patch for now, the problem is that all AT modems do not
>actually report USSD data as a PDU, instead they actually decode this into=
 the
>current character set of the modem (as set by +CSCS.)  The spec really scr=
ewed
>up on this one.
>
>This is one of the weirder parts of the spec, I don't think USSDs that are=
 not
>GSM 7 bit are even possible.  At least not on the AT modems I've encounter=
ed.

When it's GSM 7-bit, is it needed to call unpack_7bit() before calling conv=
ert_gsm_to_utf8()? The isimodem does so.
Also the status doesn't have an initial value, so in some path of code stat=
us would have an uncertain value, which may cause problem when calling ofon=
o_ussd_notify(). Maybe the situation is it's always GSM 7-bit, but the code=
 shouldn't seem buggy. =

I will still include these changes in my new patches, feel free to comment =
them or even ignore them.

>
>Feel free to investigate this further.
>
>Regards,
>-Denis

--===============9209194916354653319==--

