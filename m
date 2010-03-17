Content-Type: multipart/mixed; boundary="===============8552430394599904175=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 2/4] Handle the conversion failure when parsing item
Date: Tue, 16 Mar 2010 21:44:43 -0700
Message-ID: <1268801083.2700.40.camel@localhost.localdomain>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731C76B5B7@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8552430394599904175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> >> -	item->text =3D sim_string_to_utf8(data+1, len-1);
> >> +	utf8 =3D sim_string_to_utf8(data+1, len-1);
> >
> >I applied the patch and fixed up the arithmetic operator style issue.  P=
lease
> >make sure you follow this convention from now on.
> =

> Thank you, and I will pay attention to this in future. =

> =

> I'm always wondering what's the complete coding style we should follow. C=
an we have some document to describe them? I have collected some of them:
> 1. Check the patch using checkpatch.pl (checkpatch.pl --no-tree patch_nam=
e). In theory, you need to clean up all the warnings and errors except one =
"ERROR: Missing Signed-off-by: line(s)". However, sometimes, the warning of=
 exceeding maximum characters for a line (80 characters) can be ignored.
> 2. There should be a blank line before if statement, unless it is nested =
and not preceded by an expression or variable declaration.
> 3. There should be space before and after operator.
> 4. It's better not to have a complicated statement for if. You may judge =
its contrary condition and return | break | continue ASAP.
> 5. Better to use abbreviation, rather than full name, to name a variable,=
 function, struct, etc.
> Any others?

general rule is to look at the already existing code. We might need
checkpatch.pl specific for BlueZ, ConnMan and oFono. There are cases
where some of the style is different from kernel code. However it is not
that major.

We all make mistakes and sometimes think to complicated. That is why we
do reviews and enforce the coding style. Just keep an eye on the simple
mistakes like the one above. They are pretty obvious ;)

Regards

Marcel



--===============8552430394599904175==--

