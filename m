Content-Type: multipart/mixed; boundary="===============6790174057722784214=="
MIME-Version: 1.0
From: Tikander Petteri <petteri.tikander@ixonos.com>
Subject: Re: unsolicited multiline result
Date: Fri, 31 Dec 2010 19:07:49 +0200
Message-ID: <1293815269.17038.106.camel@r82e1wc.ixonos.local>
In-Reply-To: <4D1CD4AD.8040503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6790174057722784214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 2010-12-30 at 12:51 -0600, Denis Kenzior wrote:

> I know what you mean, however last I checked there's no such thing as
> multi-line unsolicited results.  Are you trying to invent something new
> here?  Or is there a modem that might be implementing this already?
> =


Yep. There isn't mentioning about this kind of term as multi-line
unsolicited result-code. I just called those result-codes separated by
CR/LFs to multiline results (but naturally meaning multiply result
codes), so I had no intention to invent something new. Sorry for that,
it was probably confusing.

> However, I'm now starting to question how the spec writers ever intended
> the implementation of unsolicited +CEN reporting to work on the
> application side.  Not to mention other similar ones like +CPOSR.  =


Thanks.

> When
> the string / update is broken up over multiple unsolicited result codes
> the application has no idea when the update has finished.
> =


That's true. There is no terminator ('OK' etc) in the end of the
unsolicited response for insuring that all the data has been received. =


> What is particularly challenging in the +CEN case is the fact that it
> uses two different prefixes for such unsolicited reporting.
> This makes it impossible to reliably update the emergency call list,
> obtain CPOSR information, etc.
> =


I was provisionally thinking to handle single result-codes one by one,
so notify single ECC-value to the atom. But it's not a nice solution,
because the whole ECC-list (if more than one emergency numbers are
received) is not send to the atom at the same time (not an nice solution
for instance for +CPOSR either, I believe). Well, the result code with
the another prefix (+CEN1) then will also be sent separately, which as
such isn't a problem. But probably two separated notify-functions for
'+CEN1' and '+CEN2' should be implemented.

Br, =

Petteri




--===============6790174057722784214==--

