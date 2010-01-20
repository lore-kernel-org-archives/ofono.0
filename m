Content-Type: multipart/mixed; boundary="===============6794964683406060606=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Add gatutil.c to share common APIs with GAtServer
Date: Wed, 20 Jan 2010 14:23:18 -0600
Message-ID: <201001201423.19179.denkenz@gmail.com>
In-Reply-To: <8B81FACE836F9248894A7844CC0BA8141C433BF03A@shzsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6794964683406060606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Hi Denis,
> =

> Denis Kenzior wrote:
> > Hi Zhenhua,
> >
> >> +gboolean g_at_util_set_io(GIOChannel *io)
> >
> > Rename this g_at_util_setup_io
> >
> >> +typedef void (*GAtDisconnectFunc)(gpointer user_data); typedef void
> >> +(*GAtDebugFunc)(const char *str, gpointer user_data);
> >
> > These don't belong here, create a new file called gat.h and put them
> > there.
> >
> > Regards,
> > -Denis
> =

> Thanks for your comments. Updated patch is attached.
> =


Patch has been applied.  Thanks.

Regards,
-Denis

--===============6794964683406060606==--

