Content-Type: multipart/mixed; boundary="===============5618269764015432034=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 09/19] stkutil: Add poll interval proactive command parser
Date: Wed, 12 May 2010 17:03:17 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731DE14AF5@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <201005111423.29504.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5618269764015432034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


>-----Original Message-----
>From: Denis Kenzior [mailto:denkenz(a)gmail.com]
>Sent: Wednesday, May 12, 2010 3:23 AM
>To: ofono(a)ofono.org
>Cc: Gu, Yang
>Subject: Re: [PATCH 09/19] stkutil: Add poll interval proactive command pa=
rser
>
>Hi Yang,
>
>>  	union {
>> +		struct stk_duration duration;
>>  		struct stk_command_display_text display_text;
>>  		struct stk_command_get_inkey get_inkey;
>>  		struct stk_command_get_input get_input;
>>
>
>For symmetry / consistency with other commands, can we please make a struct
>stk_command_poll_interval with only duration as a member?

I agree with you to wrap duratioin in a struct. Personally, I'd also like t=
o wrap all the fields of command details in stk_command into a struct, and =
fields of device identities into another struct. This will make stk_command=
_new_from_pdu() and unit tests more consistent and symmetric. =




Regards,
-Yang

--===============5618269764015432034==--

