Content-Type: multipart/mixed; boundary="===============4703453845642025757=="
MIME-Version: 1.0
From: Tikander Petteri <petteri.tikander@ixonos.com>
Subject: Re: unsolicited multiline result
Date: Fri, 14 Jan 2011 20:33:08 +0200
Message-ID: <1295029988.23336.355.camel@r82e1wc.ixonos.local>
In-Reply-To: <1293815269.17038.106.camel@r82e1wc.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4703453845642025757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 2010-12-31 at 19:07 +0200, Tikander Petteri wrote:

> > However, I'm now starting to question how the spec writers ever intended
> > the implementation of unsolicited +CEN reporting to work on the
> > application side.  Not to mention other similar ones like +CPOSR.  =

> =

> Thanks.
> =


Have you got some explanation from the standard writers, what was the
idea for these multiple unsolicited codes to be encoded in the way,
TS.27007 says?

> > When
> > the string / update is broken up over multiple unsolicited result codes
> > the application has no idea when the update has finished.
> > =

> =

> That's true. There is no terminator ('OK' etc) in the end of the
> unsolicited response for insuring that all the data has been received. =

> =


One solution (nasty one) popped in my mind, if no indication of the last
result-code is received: usage of timer. So, after receiving some bytes
of the unsolicited message, possible remaining bytes could be monitored
by starting some timer for a while. If after timeout I/O-buffer is
empty, then hopefully the result is ready. But naturally this makes the
result-handling a little bit lazy, because the result is not sent to the
upper level immediately...

> > What is particularly challenging in the +CEN case is the fact that it
> > uses two different prefixes for such unsolicited reporting.
> > This makes it impossible to reliably update the emergency call list,
> > obtain CPOSR information, etc.
> > =

> =


I noticed in the oFono-mailing list some earlier discussion of the plans
for taking care of Location service API (as well as TODO-task marked to
be done). Is it still a valid case, so is it planned to be implemented?

Thanks!

Br, Petteri



--===============4703453845642025757==--

