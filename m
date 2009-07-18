Content-Type: multipart/mixed; boundary="===============4131019643933603812=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Cache EF-PNN, EF-OPL sim files on disk.
Date: Sat, 18 Jul 2009 13:39:06 +0200
Message-ID: <1247917146.4549.80.camel@violet>
In-Reply-To: <fb249edb0907180432x4a44eafcu8f1ed47914cfae35@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4131019643933603812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

> > However, not all files can be updated by the user.  Namely files with t=
he 'ADM'
> > for UPDATE access condition.  The only way they can be changed is at a =
service
> > center.
> >
> > What do you think of transparently caching only such files?  This would=
 include
> > the ones we're really interested in caching anyway, namely EFspn, EFpnn,
> > EFopl, EFust, etc.
> =

> True, I was going to add code or a TODO in ofono_sim_write() to
> invalidate cache but it's a good point about updating outside ofono
> control.  I now added a parameter to ofono_sim_read() to indicate that
> a file can be cached on disk, making it a little less transparent.  In
> previous version I had separate entry points for cached read.
> =

> >
> > If we decide to do this, we should store them in /var/lib/ instead of
> > /var/cache, since these files will be stored semi-permanently.
> =

> Ok, changed.  There's also a standard path /var/state, I don't know if
> it's better or worse.

go with /var/lib since that is most common for persistent information.
You can use /var/cache for information that can be easily retrieved
again without having an impact on the functionality.

The /var/state should not be bothered with. If you have information that
are only stored for one session then /var/run should be used. However
that will be wiped during reboot.

Regards

Marcel



--===============4131019643933603812==--

