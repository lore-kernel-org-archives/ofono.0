Content-Type: multipart/mixed; boundary="===============4091977381421455946=="
MIME-Version: 1.0
From: Tikander Petteri <petteri.tikander@ixonos.com>
Subject: Re: unsolicited multiline result
Date: Thu, 30 Dec 2010 19:52:27 +0200
Message-ID: <1293731547.17038.35.camel@r82e1wc.ixonos.local>
In-Reply-To: <4D1CBB54.8040103@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4091977381421455946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Actually I meant with multiline unsolicited results the same thing, as
you mentioned below:

+prefix: result data 1 <CRLF>
+prefix: result data 2 <CRLF>
...

And my problem originally was, that although the result-handler handled
the first line correctly, the next lines where missed.
So when looking state-machine gsmv1_feed() in gatsyntax.c:

when handling first byte of the second-line, state machine is in the
idle-state, but it thinks that first byte is echo-character, so it
switches to the echo-state, where it receives all other bytes of the
second line. Although in this state byte-counter works, state-machine
doesn't give in this state any valid result (G_AT_SYNTAX_RESULT_LINE
etc) to the calling function.

If I tested with two enters/line, different lines where recognized
correctly:
+prefix: result data 1 <CRLF><CRLF>
+prefix: result data 2 <CRLF><CRLF>

But then it's not according to TS.27007 (see +CEN, as well as +CCWA).

Thanks:)

Br, Petteri

On Thu, 2010-12-30 at 11:03 -0600, Denis Kenzior wrote:
> Hi Petteri,
> =

> On 12/30/2010 10:55 AM, Petteri Tikander wrote:
> > =

> > This patch is for handling multiline unsolicited result-codes.
> > So state-machine used for handling result-bytes (gsmv1_feed) is set to =
the multiline-response
> > state. Otherwise next lines from the result-buffer are not handled corr=
ectly,
> > and response-handling will get stuck.
> =

> I've never heard of multiline-unsolicited result codes.  Unsolicited
> responses are always prefixed and suffixed by a crlf.  Are you trying to
> combine the +CEN query and +CEN unsolicited responses into a single
> parser by any chance?
> =

> > =

> > In the other hand, this correction keeps result-handling still unchange=
d.
> > So single line is notified to the upper level (atoms) at a time, not al=
l lines of the result.
> > For instance: network-emergency numbers cannot be collect to the one si=
ngle notification yet.
> =

> Regards,
> -Denis
> =





--===============4091977381421455946==--

