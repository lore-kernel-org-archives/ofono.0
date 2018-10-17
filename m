Content-Type: multipart/mixed; boundary="===============5078155804952821086=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/1] Remove superfluous definitions of _GNU_SOURCE
Date: Wed, 17 Oct 2018 12:38:22 +0200
Message-ID: <8704db57-f6ef-59bc-985c-a91ec08a611a@norrbonn.se>
In-Reply-To: <CAKSBH7FaCYUOmpG6JYkzGMPxKEKXm+XDFeAZ0N9LDwrFEdmzgg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5078155804952821086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 17/10/18 12:35, Giacinto Cifelli wrote:
> Hi,
> =

> On Wed, Oct 17, 2018 at 12:23 PM Jonas Bonn <jonas@norrbonn.se> wrote:
>>
>> There are a large number of files in the tree that define _GNU_SOURCE
>> despite not actually using features hidden behind this flag.  This patch
>> removes all these definitions in one fell swoop...
>> ---
>>
>> I realize that it's not quite kosher in ofono to send pathes that touch
>> more than directory.  Breaking this up into separate patches doesn't
>> really make sense though, given its nature.  If the list insists,
>> though, I can break this up into a series of ~50 patches...
>>
>> /Jonas
> =

> Do all files and the project compile?

Yes.  At least with the configuration I've got, which is mostly the default.

There are ~5 files where _GNU_SOURCE features are actually used.  Those, =

of course, retain the definition.

/Jonas

> =

> A single patch seems better in this case, in my opinion - for what it's w=
orth -.
> =

> Regards,
> Giacinto
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>=20

--===============5078155804952821086==--

