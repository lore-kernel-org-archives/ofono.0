Content-Type: multipart/mixed; boundary="===============2421198356560655515=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] mbpi: Parse gsm provider name
Date: Fri, 18 Apr 2014 15:02:42 +0300
Message-ID: <53511462.9040206@jolla.com>
In-Reply-To: <535078B7.9090402@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2421198356560655515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Hi Slava,
>
>> Operators share mcc/mnc meaning that automatically finding the best AP
>> (the one most likely to work) from the database may involve some sort of
>> fuzzy logic (partial or case-insensitive name comparison or something
>> like this) implemented in a product-specific provisioning plugin. Making
>> things work out-the-box translates into fewer customer complaints,
>> better user experience and is generally the right thing to do.
>>
>> I was trying to share a piece of code that doesn't involve any
>> product-specific logic and yet might be useful to others.
>>
>> Please let me know if I should give it another try, otherwise I won't
>> waste anyone's time and this code will just remain in our branch of ofon=
o.
> So you're trying to parse and return provider name information from mbpi
> and return it back to the caller.  Then the caller will try to
> 'fuzzy-logic' and match it against the SPN.  Right?  Why not make things
> easy on yourself and fix the database for the operators you need?  But I
> digress.
>
> Feel free to try.  If you can do this cleanly, then I have no problem
> with it in principle.


Even if the operator database was 100% accurate (which is practically =

impossible) something would still have to be done about the operators =

sharing MCC/MNC and yet using different AP settings.

I'll give it another try.

Thanks,
-Slava

--===============2421198356560655515==--

