Content-Type: multipart/mixed; boundary="===============3265062237392294318=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] mbpi: Parse gsm provider name
Date: Fri, 18 Apr 2014 02:22:06 +0300
Message-ID: <5350621E.4010508@jolla.com>
In-Reply-To: <535051B4.6040301@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3265062237392294318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
>> If instead I changed the interface between mbpi and provisioning plugin
>> and kept the interface with the core intact, would that look acceptable
>> to you?
> Perhaps, but I'm still failing to see why the service provider name as
> entered in MBPI is useful to anyone.

Operators share mcc/mnc meaning that automatically finding the best AP =

(the one most likely to work) from the database may involve some sort of =

fuzzy logic (partial or case-insensitive name comparison or something =

like this) implemented in a product-specific provisioning plugin. Making =

things work out-the-box translates into fewer customer complaints, =

better user experience and is generally the right thing to do.

I was trying to share a piece of code that doesn't involve any =

product-specific logic and yet might be useful to others.

Please let me know if I should give it another try, otherwise I won't =

waste anyone's time and this code will just remain in our branch of ofono.

Thanks,
-Slava


--===============3265062237392294318==--

