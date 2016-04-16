Content-Type: multipart/mixed; boundary="===============0985869492064164114=="
MIME-Version: 1.0
From: Holger Freyther <holger@freyther.de>
Subject: Re: [PATCH] wavecom: Re-work modem handling to improve stability
Date: Sat, 16 Apr 2016 15:41:02 +0000
Message-ID: <loom.20160416T173735-783@post.gmane.org>
In-Reply-To: <57055779.7050200@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0985869492064164114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@...> writes:

> =

> Hi Holger,

Dear Denis,


> =

> Just a minor nitpick here, but doc/coding-style.txt, item M1

sorry about that. I was not sure about. I should have addressed
everything now.



> > -	DBG("%p", modem);
> > +	/* TODO: Initialize GPRS support if we have an aux line */
> > +	/*
> > +	 * FIXME: This only seems to be called when no immediate
> > +	 * enabled -> online change is called
> > +	 */
> =

> ??

I had sent a separate mail about that. For some reason (well, we actually
patched the state machine in modem.c and I have to re-test), this post
sim cb was never called.

I will try to re-test when I am back to the office next week.


> =

> Please note that you can debug the wavecom plugin specifically by =

> starting ofonod with -d '*wavecom*'

thanks, I assumed it would be possible but sed -i s,DBG,o..error, was
easier when developing. :)

thank you for your fast review

  holger



--===============0985869492064164114==--

