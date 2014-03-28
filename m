Content-Type: multipart/mixed; boundary="===============8228055026338498883=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: wwan0 interface without IP
Date: Fri, 28 Mar 2014 09:47:18 -0500
Message-ID: <53358B76.9000505@gmail.com>
In-Reply-To: <lh3n4k$a8i$1@ger.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8228055026338498883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 03/28/2014 06:41 AM, Eric BOUXIROT wrote:
> hi !!
> =

> i'm back with my project using ofono/connman/sierra 3G modem...
> =

> now my modem work fine with ofono until connection. i can see IP address
> with ofono in debug mode (response from !SCPADDR command)
> interface wwan0 is UP... but without IPV4 parameters.. (only MAC address)
> i can't go to internet with this.

oFono does not assign the IP parameters.  ConnMan does that or you need
to do this some other way.

> =

> i have try to put connman in debug mode too, and get an error because
> IPAddress is not set.
> =

> at this time, if i start udhcpc -i wwan0... connection is made and work
> fine....
> =

> few seconds only after a very short time, connman say idle timeout and
> ofono goes offline.
> =

> i mean there is something wrong in ofono... (or connman ? don't know..)
> =

> someone can help me ?

Not really enough information.  If oFono establishes the connection
successfully, then likely you need to look more closely at what is
happening with ConnMan.

Regards,
-Denis


--===============8228055026338498883==--

