Content-Type: multipart/mixed; boundary="===============3792334372869139002=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 1/4] bluetooth: only use bluetooth_refcount in
 bluetooth_ref/bluetooth_unref
Date: Thu, 27 Jan 2011 14:17:14 -0200
Message-ID: <20110127161714.GB2163@joana>
In-Reply-To: <4D418E5C.2040504@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3792334372869139002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Frederic Danis <frederic.danis@linux.intel.com> [2011-01-27 16:25:16 +0=
100]:

> Le 27/01/2011 16:12, Marcel Holtmann a =C3=A9crit :
> > Hi Fred,
> >
> >>   plugins/bluetooth.c |   14 +++++++++-----
> >>   1 files changed, 9 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> >> index 93dd7a1..e59bd31 100644
> >> --- a/plugins/bluetooth.c
> >> +++ b/plugins/bluetooth.c
> >> @@ -505,7 +505,7 @@ static guint adapter_added_watch;
> >>   static guint adapter_removed_watch;
> >>   static guint property_watch;
> >>
> >> -static void bluetooth_ref(void)
> >> +static int bluetooth_ref(void)
> >>   {
> >
> > why are we now reverting something back that we already applied
> > upstream. Something is wrong here.
> =

> I followed Padovan's comment on my first try for this patch :
> "bluetooth_refcount can only be read/write by bluetooth_ref/unref"
> which seems good to me

Yeah, but I'm now wondering why we merged a code access bluetooth_refcount
directly.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============3792334372869139002==--

