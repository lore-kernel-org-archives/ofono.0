Content-Type: multipart/mixed; boundary="===============5891970123875132044=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: Bug/Oversight in gatchat/gatresult.c with negative numbers
Date: Mon, 09 Aug 2021 08:40:53 +0200
Message-ID: <20210809064053.hrz6b5l26mm4kgww@xps.localdomain>
In-Reply-To: <6d2dd964-db29-b092-a0e5-b4060854fae5@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5891970123875132044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 06, 2021 at 10:02:18AM -0500, Denis Kenzior wrote:
> > Yeah ok - what name do you suggest?
> =

> So there's a few things you can do actually:
> - We do have g_at_result_next_unquoted_string.  You could try using that =
to
> obtain the negative <rsrp> and then just sscanf/strtol or whatever to
> convert it.
> - We also have g_at_result_iter_raw_line() which can give you the raw res=
ult
> line.  It should be trivial to come up with some sscanf magic to parse the
> result.
> - Just add a new g_at_result_iter_next_negative_number.  Or if you come up
> with a more descriptive word than negative, feel free.

I would go with g_at_result_iter_next_signed_number() to reflect that
the value isn't necessarily negative.

// Martin
--===============5891970123875132044==--

