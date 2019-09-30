Content-Type: multipart/mixed; boundary="===============1170639942132819228=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 4/4] quectel: use own cmux implementation over kernel line
 discipline
Date: Mon, 30 Sep 2019 21:56:51 +0200
Message-ID: <189f1255-4a49-a212-22e6-d7a3b7225d54@geanix.com>
In-Reply-To: <2a2597d7-b0f6-fcfe-9b94-bc19611ae633@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1170639942132819228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 30/09/2019 21.55, Denis Kenzior wrote:
> Hi Martin,
> =

>>> So I wonder whether instead of fully reverting back to CMUX (only to =

>>> put in n_gsm in later) you might want to just keep both around and =

>>> use a /etc/quectel.conf or OFONO_QUECTEL_MUX=3Dn_gsm|internal instead?
>>
>> I'd prefer a single method to keep the needed testing to a minimum.
>>
> =

> I know where you're coming from, but you will probably come back in 6 =

> months and want to use the kernel multiplexer again and this change will =

> get reverted again.
> =

> Then someone with an old kernel will want the built-in one.=C2=A0 Might a=
s =

> well bite the bullet now..

Ok, drop my v2 cmux patch then. I'll spin a new one.

// Martin
--===============1170639942132819228==--

