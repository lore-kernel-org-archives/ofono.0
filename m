Content-Type: multipart/mixed; boundary="===============5769131958040900434=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 0/3] Long phone numbers
Date: Tue, 18 Jan 2011 22:27:24 -0600
Message-ID: <4D36682C.8040009@gmail.com>
In-Reply-To: <20110118093908.GA20108@nodo3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5769131958040900434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On 01/18/2011 03:39 AM, Rafael Ignacio Zurita wrote:
> On Mon, Jan 17, 2011 at 11:18:51PM +0200, Pekka Pessi wrote:
>> Hi Rafael,
>>
>> 2011/1/17 Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>:
>>> This is a proposal for the "long phone number" task (80 digits max leng=
th).
>>> It changes OFONO_MAX_PHONE_NUMBER_LENGTH and splits
>>> common:valid_phone_number_format(), to make sure long numbers are handl=
ed
>>> appropriately for functions that need manage shorter numbers, like
>>> numbers written to the SIM, or sms SCA.
>>
>> Perhaps a validator and type for long phone numbers is better than for
>> short numbers? I guess long numbers are mostly used when reporting an
>> outgoing call back to oFono.
> =

> No completely sure if it is better. Maybe it is the same?. With a new
> type for long number we will have modifications on other parts of the code
> which use OFONO_MAX_PHONE_NUMBER_LENGTH. The first idea could be simpler
> because we just have one type and would check for the format and length o=
n the
> proper places.

So I actually agree with Pekka on this one, validating the long phone
number might actually be a bit easier.  Basically the long phone number
only happens when we place an outgoing call.

For the rest we can keep the limit to 20.

However, do note that this function is being (ab)used for:
- Checking valid destination for an SMS (20 chars max)
- Checking valid phone number to be written to SIM (currently no
extension records, so 20 chars max)
- Checking valid phone number to be sent to ATD (80 chars max)
- Checking valid phone number to be uses for deflection (? chars max)

Perhaps we should use an enumeration of the type of number we want,
similar to how is_valid_pin is implemented.

>  =

>> BTW, with call forwarding you could have numbers up to 16 digits or if
>> longForwardedToNumber is supported (by modem and both home and visited
>> networks) even 28 digits. See TS 29.002 for merry details.
> =

> Thanks for that. I am checking, and going to add an extra validator
> surely.
> =


This might be a good idea, but keep in mind that if we set a long number
into CFU, we might not be able to support writing it out to the SIM's
EFcfis record.  So 20 characters might be all you have anyway.

Regards,
-Denis

--===============5769131958040900434==--

