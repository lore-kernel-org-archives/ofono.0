Content-Type: multipart/mixed; boundary="===============4728085715352168148=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 1/3] Add: Online property to modem
Date: Tue, 25 May 2010 17:01:21 +0300
Message-ID: <1274796081.3755.169.camel@tucson.research.nokia.com>
In-Reply-To: <1274795286.3755.152.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4728085715352168148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-25 at 15:48 +0200, Niemi Aki (Nokia-D/Helsinki) wrote:
> Let's refactor this. It's not obvious why we need both these for loops.
> How about something like this instead:
> =

> >       struct ofono_atom *atom;
> >       GSList *l =3D modem->atoms;
> >       GSList *next;
> >
> >       for (l =3D modem->atoms; l; l =3D next) {
> >
> >               atom =3D l->data;
> >               next =3D l->next;
> >
> >               if (atom->modem_state > new_state)
> >                       continue;

Hmm... This probably should've been:

if (atom->modem_state <=3D new_state)
	continue;

Cheers,
Aki


--===============4728085715352168148==--

