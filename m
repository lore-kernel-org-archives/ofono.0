Content-Type: multipart/mixed; boundary="===============7286173334930073684=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] "magic" numbers (145,129)
Date: Mon, 17 Jan 2011 17:54:03 -0600
Message-ID: <4D34D69B.2020706@gmail.com>
In-Reply-To: <ab2c6e09851c2c5eecd49fe4bd1dfde1.squirrel@squirrel-webmail.surftown.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7286173334930073684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi George,

Kind reminder to please not top on this mailing list.

On 01/17/2011 03:10 PM, George Matveev wrote:
> Rajesh and Denis, thank you for your comments.
> =

> It is really comforting to know that project maintainer knows about
> specifications and could provide guidance to other developers.
> This is what most contributors have come to expect from them.
> =

> What makes me wonder is why don't we use those specs consistently?
> =

> Instead of relying on sporadic attempts to define number types ad hock,
> in different parts of project (see grep results) and using inconsistent
> or simply wrong comments, wouldn't it be more logical to use spec?
> =


Careful there, certainly we are extremely anal about using the specs and
the appropriate enums when it is... appropriate.  However, we break this
rule if it is prudent or makes the code look ugly.  If an enumeration
can be localized to a single function, then don't bother creating an
enum as this only makes the code harder to read.  It is fine to use
magic values if they are localized and you wouldn't understand the
function without the spec in hand.  Browse through stkutil.c, simutil.c
for plenty of examples of this.

There maybe parts that have suffered from bit-rot more than others, but
in general your criticism is a little misplaced.  I consider 145/129
thing to be border-line and can see it both ways.

> Denis, you may be surprised to know that such an attempt had already
> been made in the past (though possibly in a wrong place - src/driver.h)
> and that patch was accepted by someone called Denis Kenzior :-)
> =

> Just have a look into oFono archive here:
> =

> http://lists.ofono.org/pipermail/ofono/2009-June/000130.html

Yes, and I wonder where this code is now? Oh yes, it was refactored out
by the same guy because it was not actually used in the end ;)

> =

> Since other developers seem to agree that it'll make project code
> more organized and readable I think I'll submit a patch using all
> those values defined in 3GPP TS 24.008, section 10.5.4.7
> "Called party BCD number", Table 10.5.118.
> =

> What I am not entirely sure though is a name of new enumeration,
> possibly *called_number_type* would be more appropriate
> and also more in line with the spec?

Depends on whether you want to separate the number type from the
numbering plan or keep it as a single enum.

Regards,
-Denis

--===============7286173334930073684==--

