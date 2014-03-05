Content-Type: multipart/mixed; boundary="===============3021090745463350681=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: Re: [PATCH] idmap: use UL for bitshift literals
Date: Wed, 05 Mar 2014 16:43:59 -0500
Message-ID: <53179A9F.6070209@canonical.com>
In-Reply-To: <53173A32.4020109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3021090745463350681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/05/2014 09:52 AM, Denis Kenzior wrote:
> Hi Tony,
>
> On 03/04/2014 06:01 PM, Tony Espy wrote:
>> The current bitshift logic in idmap incorrectly uses
>> the literal 1 for the value to shift in idmap_alloc(),
>> idmap_take(), and idmap_alloc_next().  This causes the
>> resulting value to be an int instead of a long, which
>> results in the wrong bit being set once the number of
>> bits to shift operand exceeds sizeof(int).  Also
>> on some platforms, the behavior of the left bitshift
>> operator is undefined when this overflow occurs.
>> ---
>>   src/idmap.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>
> Good catch.  Patch has been applied, thanks.

Denis -

One of my co-workers recently sent a couple of patches that add Python3 =

support to the ofono test scripts, however he's not currently subscribed =

to the mailing list so they emails appear to be in limbo...

Can someone clear these as a list moderator, or should I go ahead and =

re-send them myself?

Regards,
/tony


--===============3021090745463350681==--

