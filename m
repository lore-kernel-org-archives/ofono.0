Content-Type: multipart/mixed; boundary="===============6410770109430860804=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 3/4] Add: set_online and post_online methods to isimodem
 driver
Date: Thu, 27 May 2010 09:48:47 +0300
Message-ID: <1274942927.3755.481.camel@tucson.research.nokia.com>
In-Reply-To: <201005262108.37085.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6410770109430860804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-05-27 at 04:08 +0200, ext Denis Kenzior wrote:
> Hi Pekka,
> =

> > +static bool mtc_state_cb(GIsiClient *client, const void *restrict data,
> > +				size_t len, uint16_t object, void *opaque)
> =

> We don't use bools in oFono, please fix this to use gboolean or an int.

Well, stdbool.h is what gisi uses currently. I've been meaning to
replace all occurrences with gboolean, but haven't gotten around to it
yet.

So I think this can be pushed, and the issue fixed aftrewards.

Cheers,
Aki



--===============6410770109430860804==--

