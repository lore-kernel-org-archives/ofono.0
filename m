Content-Type: multipart/mixed; boundary="===============3332471482718270624=="
MIME-Version: 1.0
From: Paavo Leinonen <paavo.leinonen@tieto.com>
Subject: Re: Selecting multiple radio access technologies in oFono
Date: Wed, 02 Feb 2011 11:33:11 +0200
Message-ID: <4D4924D7.4060406@tieto.com>
In-Reply-To: <1296591930.2619.60.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3332471482718270624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 02/01/2011 10:25 PM, Aki Niemi wrote:
> The current API has 'gsm', 'umts', 'lte' and 'any'. I think you are
> suggesting something like 'all-but-lte', right?
I think it would be nice if user could be able to select multiple
preferred  bands, not just only one. The use case I came up with was
this 'all-but-lte'.
>> Other approach could be that we would rephrase existing API so that
>> instead of
>> using "only" LTE, we would use LTE whenever available and some older
>> technology
>> when LTE coverage is lacking. So user would select "highest" allowed rad=
io
>> access without restrictions to use only one technology which has been
>> selected.
> This is what 'any' essentially is for.
You can't limit preferred bands with 'any'. I was trying to find an
alternative for polluting API by listing all the possible combinations
('gsm_umts', 'gsm_lte', 'umts_lte') in API.

However, I don't think we need this anymore as R=C3=A9mi kindly pointed out
a solution earlierwhich involves dictionary with strings and booleans.

Br,
Paavo

--===============3332471482718270624==--

