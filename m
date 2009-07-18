Content-Type: multipart/mixed; boundary="===============3966801765251436335=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Cache EF-PNN, EF-OPL sim files on disk.
Date: Sat, 18 Jul 2009 01:02:26 -0500
Message-ID: <200907180102.27090.denkenz@gmail.com>
In-Reply-To: <1247891688-10028-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3966801765251436335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> This uses plain files in /var/cache/ofono for storing contents of the
> operator lists to avoid possibly numerous queries to the SIM on every
> startup.  Files are indexed with IMSI.  I'm not 100% sure about the
> autoconf magic.
>
> Users need to rerun bootstrap-configure after applying this.
>
> File format slightly changed in this second version (make it as simple as
> possible).
>  		return -1;

I somewhat like the idea of transparently caching the SIM file system, =

unfortunately we can't do it for all files.  Suppose a user shuts off oFono =

device, takes out the SIM and puts it in another device.  Then modifies som=
e =

settings (e.g. like MBDN or MSISDN.)  Then the SIM is returned to oFono bas=
ed =

device.

However, not all files can be updated by the user.  Namely files with the '=
ADM' =

for UPDATE access condition.  The only way they can be changed is at a serv=
ice =

center.

What do you think of transparently caching only such files?  This would inc=
lude =

the ones we're really interested in caching anyway, namely EFspn, EFpnn, =

EFopl, EFust, etc.

If we decide to do this, we should store them in /var/lib/ instead of =

/var/cache, since these files will be stored semi-permanently.  If really =

necessary, the carrier service center could probably remove the cache someh=
ow =

during the SIM upgrade.

Regards,
-Denis

--===============3966801765251436335==--

