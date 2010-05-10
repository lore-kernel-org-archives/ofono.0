Content-Type: multipart/mixed; boundary="===============3631374057788551381=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/6] gatchat: Add g_at_chat_send_full.
Date: Mon, 10 May 2010 18:48:39 -0500
Message-ID: <201005101848.40097.denkenz@gmail.com>
In-Reply-To: <AANLkTimad9xDirmjF1WHzrb6Qu6b39plcgRki-eq7rLF@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3631374057788551381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Hi Denis,
> =

> On 10 May 2010 21:13, Denis Kenzior <denkenz@gmail.com> wrote:
> >> g_at_chat_send_full takes two additional parameters compared to
> >> g_at_chat_send.  The destroy notification is removed from
> >> g_at_chat_send and users updated.
> >> ---
> >
> > You stated earlier that the modem will return an error and not time out.
> >  If this is the case then I'm really failing to see the point of needing
> > the submit callback.
> =

> I stated that as en example of an incompliant modem.  The specs are
> not very clear here but say that we should assume the modem is dead if
> no response to the AT+CSIM is sent within a timeout of at least 5
> seconds.

The modem or the SIM?  I think the specs are talking about the SIM here and =

the modems do need to poll and detect SIM dead conditions.  If we were to =

implement a GSM soft-modem, then we'd definitely need to poll...

> =

> My thinking so far was that ofono should support an (imaginary) modem
> that's described by the specs, and on top of that add support for
> vendor specific things, but maybe that is useless in this case.  What
> do you think?

I think we should drop this capability until we actually see this 'imaginar=
y' =

modem you describe in the wild.  Most vendors intercept everything related =
to =

SIM / STK and can even do hardware SIM detection.  Makes no sense for us to =

worry about it right now.

Regards,
-Denis

--===============3631374057788551381==--

