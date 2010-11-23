Content-Type: multipart/mixed; boundary="===============8767240765962045908=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH -v3 3/3] modem: add support to restore state when
 resetting the modem
Date: Tue, 23 Nov 2010 19:33:24 -0200
Message-ID: <20101123213324.GF22502@vigoh>
In-Reply-To: <20101123175009.GB22502@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8767240765962045908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Gustavo F. Padovan <padovan@profusion.mobi> [2010-11-23 15:50:09 -0200]:

> Hi Denis,
> =

> * Denis Kenzior <denkenz@gmail.com> [2010-11-23 05:04:40 -0600]:
> =

> > Hi Gustavo,
> > =

> > On 11/19/2010 03:36 PM, Gustavo F. Padovan wrote:
> > > ---
> > >  src/modem.c |   74 ++++++++++++++++++++++++++++++++-----------------=
---------
> > >  1 files changed, 41 insertions(+), 33 deletions(-)
> > > =

> > =

> > Ah ok, you implement the getting back to online process in this patch.
> > Ignore my previous comment.
> > =

> > > diff --git a/src/modem.c b/src/modem.c
> > > index e57f8fc..704de29 100644
> > > --- a/src/modem.c
> > > +++ b/src/modem.c
> > > @@ -61,6 +61,7 @@ enum modem_state {
> > >  struct ofono_modem {
> > >  	char			*path;
> > >  	enum modem_state	modem_state;
> > > +	enum modem_state	old_state;
> > =

> > Can we simply use a boolean like 'get_online' that is FALSE by default,
> > but gets set to TRUE (assuming we're online) during a silent reset?
> > This can then get re-used for implementing of the Lockdown property as =
well.
> =

> Yeah, I'm reusing it there.
> =

> > =

> > It also seems that the 'reset' value is not really needed.
> =

> I'm using that to avoid emit DBus signal during the silent reset, Not
> seeing how to do that without modem->reset, maybe we can rely on
> modem->pending, not sure yet. =


Or do you mean that have DBus signaling about Powered and Online during
silent reset is just fine? That is starting to make sense to me. We may
want to notify users that the modem is not there.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============8767240765962045908==--

