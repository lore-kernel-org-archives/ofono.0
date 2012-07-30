Content-Type: multipart/mixed; boundary="===============7989010246658884480=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] test: Tweak hangup script to clear waiting active and
 held calls
Date: Mon, 30 Jul 2012 09:50:05 -0700
Message-ID: <1343667005.1803.56.camel@aeonflux>
In-Reply-To: <1343663109-5542-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7989010246658884480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>  test/hangup |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)

this is a case where you should have done a summary email to describe
why are you doing things.

> =

> diff --git a/test/hangup b/test/hangup
> index 6444b23..60858a8 100755
> --- a/test/hangup
> +++ b/test/hangup
> @@ -3,6 +3,16 @@
>  import sys
>  import dbus
>  =

> +if (len(sys.argv) < 2):
> +	print "Usage: %s <call state>" % (sys.argv[0])
> +	sys.exit(1)
> +
> +cstate =3D sys.argv[1]
> +
> +if cstate !=3D "active" and cstate !=3D "waiting" and cstate !=3D "held":
> +	print "Valid <call state> is active / waiting / held"
> +	sys.exit(1)
> +

If you wanna do things like this, then at least the call without
parameter should list the current calls and in what state they are.
Otherwise this is making things worse.

And don't bother renaming the script first. Just introduce a new script
and delete the duplicate later on.

Regards

Marcel



--===============7989010246658884480==--

