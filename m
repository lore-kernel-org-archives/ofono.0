Content-Type: multipart/mixed; boundary="===============0357824718120494828=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbpi: Parse gsm provider name
Date: Thu, 17 Apr 2014 19:58:31 -0500
Message-ID: <535078B7.9090402@gmail.com>
In-Reply-To: <5350621E.4010508@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0357824718120494828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

> Operators share mcc/mnc meaning that automatically finding the best AP
> (the one most likely to work) from the database may involve some sort of
> fuzzy logic (partial or case-insensitive name comparison or something
> like this) implemented in a product-specific provisioning plugin. Making
> things work out-the-box translates into fewer customer complaints,
> better user experience and is generally the right thing to do.
> =

> I was trying to share a piece of code that doesn't involve any
> product-specific logic and yet might be useful to others.
> =

> Please let me know if I should give it another try, otherwise I won't
> waste anyone's time and this code will just remain in our branch of ofono.

So you're trying to parse and return provider name information from mbpi
and return it back to the caller.  Then the caller will try to
'fuzzy-logic' and match it against the SPN.  Right?  Why not make things
easy on yourself and fix the database for the operators you need?  But I
digress.

Feel free to try.  If you can do this cleanly, then I have no problem
with it in principle.

Regards,
-Denis

--===============0357824718120494828==--

