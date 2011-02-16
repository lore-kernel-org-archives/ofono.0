Content-Type: multipart/mixed; boundary="===============3453237764016235657=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: Re: [PATCH 1/2] gprs:Add code to handle AT+CGDCONT
Date: Wed, 16 Feb 2011 09:30:19 +0100
Message-ID: <4D5B8B1B.7000200@linux.intel.com>
In-Reply-To: <1297839016.2519.14.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3453237764016235657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Marcel,

> Hi Denis,
>
>>> ---
>>>   include/gprs.h |    2 +
>>>   src/gprs.c     |   63 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>   2 files changed, 65 insertions(+), 0 deletions(-)
>> So I went in a slightly different direction with the emulator API.  Can
>> you please have a look?
>>
>> Also, I'd really rather hold off trying to implement CGDCONT right now.
>>   That piece is quite nasty and generally of lower priority.  I'd like to
>> get the emulator a bit more hashed out first and implement the base BT
>> DUN&  BT HFP profiles.
> for the sake of testing, I would be fine with the real basic CGDCONT and
> just offering IP and CID 1. And then of course accepting any APN in that
> range and rejecting any other command.
The submitted code is just an "how-to", and need to be updated to =

implement the complete CGDCONT (up to now, the function displays the =

existings contexts, and the default range values.
The idea behind this code was to provide the complete chain to handle AT =

commands in atoms. I m not sure the current handler mechanism fit with =

Denis's view ;)
Regards,
Olivier

--===============3453237764016235657==--

