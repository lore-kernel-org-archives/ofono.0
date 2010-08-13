Content-Type: multipart/mixed; boundary="===============6651154401415904177=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/phonebook: parse text as hexstring
Date: Fri, 13 Aug 2010 13:08:31 -0500
Message-ID: <4C658A1F.4080203@gmail.com>
In-Reply-To: <20100812175552.GB25956@barata.holoscopio.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6651154401415904177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cascardo,

>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

We don't use Signed-Off here, so please don't use it when sending
patches for oFono.

>>> ---
>>> drivers/atmodem/phonebook.c |  139 ++++++++++++++++++++----------------=
------
>>> 1 files changed, 66 insertions(+), 73 deletions(-)
>>>
>>> diff --git a/drivers/atmodem/phonebook.c b/drivers/atmodem/phonebook.c
>>> index 5e7a52b..59fcbbc 100644
>>> --- a/drivers/atmodem/phonebook.c
>>> +++ b/drivers/atmodem/phonebook.c
>>> @@ -59,16 +59,50 @@ struct pb_data {
>>> 	GAtChat *chat;
>>> };
>>>
>>> -static char *ucs2_to_utf8(const char *str)
>>> +static void warn_bad_text(const char *text)
>>> {
>>> -	long len;
>>> -	unsigned char *ucs2;
>>> +	ofono_warn("Name field conversion to UTF8"
>>> +		" failed, this can indicate a"
>>> +		" problem with modem"
>>> +		" integration, as this field"
>>> +		" is required by 27.007."
>>> +		"  Contents of name reported"
>>> +		" by modem: %s", text);
>>> +}
>>
>> Why this warning is extracted as a function here?
>>
> =

> In one of my versions of the patch, it was too much inlined and the
> function was already too long. Since it's static, it will probably be
> inlined. Should I just put it back in place of its only caller?
> =


This is actually fine, but please re-flow the text to take advantage of
the available space.  There's no reason to stick with 50 character
maximum now.

>>> +		if (utf8) {
>>> +			*str =3D utf8;
>>> +			return TRUE;
>>> +		} else {
>>> +			warn_bad_text(string);
>>
>> We only report the warning when the field "name" (i.e., text) couldn't b=
e converted correctly, for it's a mandatory field. Otherwise, we don't issu=
e the warning.
>>
> =

> I will add a gboolean mandatory parameter to the function. I've thought
> about that, but now I have a pretty good line (mandatory), that's pretty
> clear.
> =


Please do this.

>>> +		if (g_at_result_iter_next_string(iter, &string)) {
>>
>> Could the device omit the quote here? If so, this function couldn't hand=
le it correctly either.
>>
> =

> Not the device I have. This does not add a regression. If we find any
> device that will omit the quote in this case, we may add the fix later.
> For now, I am more confortable requiring the quote here and fixing it
> for the cases we know some devices will omit it.
> =

> In any case, the UCS2 case was already expecting an hexstring, since it
> was doing the conversion later. And the hexstring code allowed the
> quotes to be omited. This is not the case here, where a string is
> expected. I don't know about the IRA case.
> =


I agree, the standard says that all strings should be in quotes.  If
some modem does not follow this standard then we will need to quirk it
specifically.  For now I think this is fine.

Please fix up the other style issues commented on by Yang and resubmit
this patch.

Regards,
-Denis

--===============6651154401415904177==--

