Content-Type: multipart/mixed; boundary="===============2838595574543240934=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/1] Remove superfluous definitions of _GNU_SOURCE
Date: Wed, 17 Oct 2018 16:31:06 +0200
Message-ID: <b34e2ead-d373-82f6-a343-536c835d53e6@norrbonn.se>
In-Reply-To: <413B384A-9DBF-489B-AB1B-0D94228F484F@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2838595574543240934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 17/10/18 13:55, Marcel Holtmann wrote:
> Hi Jonas,
> =

>>>> There are a large number of files in the tree that define _GNU_SOURCE
>>>> despite not actually using features hidden behind this flag.  This pat=
ch
>>>> removes all these definitions in one fell swoop...
>>>> ---
>>>>
>>>> I realize that it's not quite kosher in ofono to send pathes that touch
>>>> more than directory.  Breaking this up into separate patches doesn't
>>>> really make sense though, given its nature.  If the list insists,
>>>> though, I can break this up into a series of ~50 patches...
>>>>
>>>> /Jonas
>>> Do all files and the project compile?
>>
>> Yes.  At least with the configuration I've got, which is mostly the defa=
ult.
>>
>> There are ~5 files where _GNU_SOURCE features are actually used.  Those,=
 of course, retain the definition.
> =

> I found musl most strict in this regards while glibc is rather relaxed. I=
f this compiles with musl cleanly, I am fine.
> =


I have now built this against musl (via OpenEmbedded) and it builds cleanly.

/Jonas

> Regards
> =

> Marcel
>=20

--===============2838595574543240934==--

