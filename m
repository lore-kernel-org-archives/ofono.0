Content-Type: multipart/mixed; boundary="===============1943418512236003517=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Selecting multiple radio access technologies in oFono
Date: Wed, 02 Feb 2011 10:42:42 +0100
Message-ID: <1296639762.1520.314.camel@aeonflux>
In-Reply-To: <4D4924D7.4060406@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1943418512236003517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paavo,

> > The current API has 'gsm', 'umts', 'lte' and 'any'. I think you are
> > suggesting something like 'all-but-lte', right?
> I think it would be nice if user could be able to select multiple
> preferred  bands, not just only one. The use case I came up with was
> this 'all-but-lte'.

can we first be clear that we are talking about technology selection and
not band selection. They are different.

Right now I have no idea on how the hardware will ever support this
properly. RAT selection is already so different that I prefer to keep it
like this. It is simple. We can cross the LTE bridge once this becomes a
real problem.

Regards

Marcel



--===============1943418512236003517==--

