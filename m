Content-Type: multipart/mixed; boundary="===============8986428535156791750=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: fix for +CMER parser of AT driver (fixes registration)
Date: Wed, 16 Jan 2013 21:28:22 -0600
Message-ID: <50F76FD6.30008@gmail.com>
In-Reply-To: <20130107205823.GI7263@emdete.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8986428535156791750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 01/07/2013 02:58 PM, M. Dietrich wrote:
> Hi All,
>
>
> i recently noticed that the at driver did not reach the state "registered=
".
> marcel pointer me to the message
>
> 	+CMER not supported by this modem.  If this is an error please submit
> 	patches to support this hardware
>
> and i started digging. problem was parsing of the response
>
> 	+CMER: (0,3),(0,2),0,(0-1),0

This is quite obviously wrong.  Quoting v.250:

"When the action accepts a single numeric subparameter, or the parameter =

accepts only one numeric value, the set of supported values may be =

presented in the information text as an ordered list of
values. The list shall be preceded by a left parenthesis ("(", IA5 2/8), =

and is followed by a right parenthesis (")", IA5 2/9). If only a single =

value is supported, it shall appear between the parentheses. If more =

than one value is supported, then the values may be listed individually, =

separated by comma characters (IA5 2/12), or, when a continuous range of =

values is supported, by the first value in the range, followed by a =

hyphen character (IA5 2/13), followed by the last value in the range. =

The specification of single values and ranges of values may be =

intermixed within a single information text. In all cases, the supported =

values shall be indicated in ascending order."

>
> that expresses the allowed options of CMER. neither (a list of) single in=
teger

I'm pretty sure that this is supported by GAtChat.

> "(0,3)" (in opposite to range "(0-1)") nor missing brackets "0" were supp=
orted
> by ofono so i added this (see patch).
>
> i'm not sure if missing brackets are allowed or espress something differe=
nt,
> maybe a AT-guru can tell. for now "(0)" behaves like "0".
>
> i assume that also other response-parsing flows in ofono have that problem
> so either a generic aproach should be implemented or other places be revi=
ewed.
>

It is only a problem if the modem is broken, in which case you need to =

use a quirk and parsing the result of CMER=3D? is likely unnecessary.  For =

broken devices it is likely easier to simply skip CMER probing and just =

set the wanted CMER settings.

> marcel already pointer out that a generic aproach may be unnecessarily co=
mplex
> where i agree if it comes to strings and nested brackets but for plain in=
teger
> cases it would be quite useful to get this done in one place for all. if
> interested i could implement such stuff into gatchat/gatresult.c which th=
en can
> be used for the integer-only cases. what do you think?

Not sure what you're asking here, can you elaborate?

Regards,
-Denis

--===============8986428535156791750==--

