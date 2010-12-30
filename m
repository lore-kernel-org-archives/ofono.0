Content-Type: multipart/mixed; boundary="===============4755491622875720506=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: unsolicited multiline result
Date: Thu, 30 Dec 2010 12:51:25 -0600
Message-ID: <4D1CD4AD.8040503@gmail.com>
In-Reply-To: <1293731547.17038.35.camel@r82e1wc.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4755491622875720506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

Remember, no top-posting on this list ;)

On 12/30/2010 11:52 AM, Tikander Petteri wrote:
> Hi Denis,
> =

> Actually I meant with multiline unsolicited results the same thing, as
> you mentioned below:
> =

> +prefix: result data 1 <CRLF>
> +prefix: result data 2 <CRLF>
> ...
> =


I know what you mean, however last I checked there's no such thing as
multi-line unsolicited results.  Are you trying to invent something new
here?  Or is there a modem that might be implementing this already?

> And my problem originally was, that although the result-handler handled
> the first line correctly, the next lines where missed.
> So when looking state-machine gsmv1_feed() in gatsyntax.c:

Of course, because unsolicited results are assumed to be prefixed and
suffixed by a CRLF.  When you do something like:

<cr><lf>+CUNSOLICITED<cr><lf>+CUNSOLICITED<cr><lf> the parser gets
understandably confused.

However, I'm now starting to question how the spec writers ever intended
the implementation of unsolicited +CEN reporting to work on the
application side.  Not to mention other similar ones like +CPOSR.  When
the string / update is broken up over multiple unsolicited result codes
the application has no idea when the update has finished.

What is particularly challenging in the +CEN case is the fact that it
uses two different prefixes for such unsolicited reporting.
This makes it impossible to reliably update the emergency call list,
obtain CPOSR information, etc.

Since these features are relatively recent, maybe people who are
implementing these features in real modem firmware can chime in here.

Regards,
-Denis

--===============4755491622875720506==--

