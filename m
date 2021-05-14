Content-Type: multipart/mixed; boundary="===============6424413165470336256=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5 0/4]
Date: Fri, 14 May 2021 12:00:49 -0500
Message-ID: <3cce7264-b232-0744-8277-8ba5be09e6ae@gmail.com>
In-Reply-To: <615ae9a1-060f-4f61-4e7d-f6b4bc872863@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6424413165470336256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 5/12/21 4:17 AM, Jonas Bonn wrote:
> Hi Denis,
> =

> If we're going to get anywhere with this, the onus probably falls on you =
to do =

> some cleanup work on these patches.=C2=A0 I'll write some comments on the=
 patches and =

> maybe you can munge those into the commit messages...?

What now? ;)

Anyway, I am not taking this set since all patches seem to be whitespace da=
maged =

and this needs cleanup anyway.

> =

> Bing Jupiter has been running this modem (uBlox SARA R4) for well over a =
year =

> with these patches so they are somewhat tested.=C2=A0 That said, this mod=
em isn't =

> without issues, but it appears to me that those are mostly firmware relat=
ed at =

> this point.=C2=A0 Yeah, not great advertising for the product; probably b=
est to stay =

> away from it altogether, really...

This is driver code, so unless there's something obviously wrong I'm fine t=
aking =

it.  But it should at least comply with doc/coding-style.txt and someone sh=
ould =

have ran checkpatch.pl against it to check for issues.

Given that a v6 is needed, do you want to work with Jupiter to make the =

editorial changes to the commit descriptions?

Regards,
-Denis
--===============6424413165470336256==--

