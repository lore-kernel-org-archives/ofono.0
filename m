Content-Type: multipart/mixed; boundary="===============9110965495020216567=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Add: set_online and post_online methods to isimodem
 driver
Date: Thu, 27 May 2010 06:44:01 -0500
Message-ID: <201005270644.01624.denkenz@gmail.com>
In-Reply-To: <1274942927.3755.481.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9110965495020216567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> On Thu, 2010-05-27 at 04:08 +0200, ext Denis Kenzior wrote:
> > Hi Pekka,
> >
> > > +static bool mtc_state_cb(GIsiClient *client, const void *restrict
> > > data, +				size_t len, uint16_t object, void *opaque)
> >
> > We don't use bools in oFono, please fix this to use gboolean or an int.
> =

> Well, stdbool.h is what gisi uses currently. I've been meaning to
> replace all occurrences with gboolean, but haven't gotten around to it
> yet.
> =

> So I think this can be pushed, and the issue fixed aftrewards.

This is new code, so might as well be done properly.  If the rest of the pa=
tch =

is looking good to you, then just --amend it to get rid of the bool.

Regards,
-Denis

--===============9110965495020216567==--

