Content-Type: multipart/mixed; boundary="===============7771873095597272887=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] Refactor the command parsing framework
Date: Thu, 25 Mar 2010 20:10:28 -0500
Message-ID: <201003252010.28985.denkenz@gmail.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B351D67BF96@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7771873095597272887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua

> > Err, OK stop right there.  This is really way too complicated.
> > How about we simply set a flag before calling
> > at_command_notify.  If after executing it send_final or
> > send_ext_final response has been sent, then we continue
> > processing, otherwise we restart when send_ext_final or
> > send_final will be called again.  You really don't need to touch this
> > function at all.
> =

> OK. So the problem is if the at_command_notify is blocked by user callbac=
k,
>  the mainloop won't have chance to read data in from non-blocking I/O I
>  guess. That's the reason I added this. If we don't need to handle such
>  case, then the logic could be much simplier. We could discuss it on IRC.

So what you want to assume here is that for long running operations the =

callback with schedule its own g_sources and will eventually call send_fina=
l.  =

This works because the server can only have one outstanding command at a ti=
me. =

You don't need to worry about blocking semantics here (they just work) and =
we =

won't consider re-entrant event loops for now.

Regards,
-Denis

--===============7771873095597272887==--

