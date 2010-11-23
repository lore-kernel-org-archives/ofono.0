Content-Type: multipart/mixed; boundary="===============1649159933316839735=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: STK DisplayText changes proposal
Date: Tue, 23 Nov 2010 17:55:56 +0100
Message-ID: <AANLkTink8S-MHkHa+L1p4qxSLKub1nn0GYSYcVWYMVXX@mail.gmail.com>
In-Reply-To: <4CEBE651.4080502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1649159933316839735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 23 November 2010 17:05, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/23/2010 09:33 AM, Lucas, GuillaumeX wrote:
>> Hi,
>>
>> According to the 3GPP specifications there is some missing points in the=
 SATK DisplayText implementation and I want to propose some API changes her=
e.
>>
>> 1. clear message after delay / wait for user to clear flag
>>
>> This flag corresponds to the bit 8 of the command qualifier (see ETSI TS=
 102 223) and indicates how the message should be cleared by the UI.
>> In the STK agent documentation it's indicated that this flag is handled =
using different timeout value for the Agent DisplayText method call. But th=
at doesn't seem the case in the code: there is no check of the flag.
>
> Andrew has to answer this one, it seems like there's a disconnect
> between the implementation and the docs. =C2=A0Probably just a bug.

It was in my first proposal, however the decision made here on the
list or on IRC (I don't remember) was to remove all the details from
the specification until there's a specific use case for them from UI
authors.  The current API is greatly simplified compared to TS 102.223
on the basis that some of the parameters are never used by SIM
manufacturers.  This includes for example the "help available"
information in the commands, the return values like "help requested",
"icon could not be displayed", "screen busy" and many other bits.  On
one hand this makes sense but on the other I don't see it as a huge
saving as long a we design the API in such a way that the unneeded
call parameters or return values can be ignored by the UI writer.  I
have to point out that you were the advocate for simplifying the API
to the minimum level needed to implement the iPhone STK app :)

As for the clear after delay flag, there's a check for it in
display_text_cb (line 1248).  As far as I can make out the only
difference is the response sent to the SIM.

Best regards

--===============1649159933316839735==--

