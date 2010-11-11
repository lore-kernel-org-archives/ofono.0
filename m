Content-Type: multipart/mixed; boundary="===============1948614967519855712=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test/answer-calls: answer waiting calls, too
Date: Thu, 11 Nov 2010 09:14:09 -0600
Message-ID: <4CDC0841.1070100@gmail.com>
In-Reply-To: <1289480071-30423-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1948614967519855712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 11/11/2010 06:54 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> ---
>  test/answer-calls |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> =

> diff --git a/test/answer-calls b/test/answer-calls
> index 0deb832..1218c66 100755
> --- a/test/answer-calls
> +++ b/test/answer-calls
> @@ -4,8 +4,11 @@ import dbus
>  =

>  bus =3D dbus.SystemBus()
>  =

> -manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
> -						'org.ofono.Manager')
> +def oface(path, name):
> +	obj =3D bus.get_object('org.ofono', path)
> +	return dbus.Interface(obj, name)
> +
> +manager =3D oface('/', 'org.ofono.Manager')

I'd really like to keep things consistent even inside the test
directory.  Right now we have about two or three distinct styles of
python, and this change isn't helping ;)

>  =

>  modems =3D manager.GetModems()
>  =

> @@ -15,8 +18,7 @@ for path, properties in modems:
>  	if "org.ofono.VoiceCallManager" not in properties["Interfaces"]:
>  		continue
>  =

> -	mgr =3D dbus.Interface(bus.get_object('org.ofono', path),
> -					'org.ofono.VoiceCallManager')
> +	mgr =3D oface(path, 'org.ofono.VoiceCallManager')
>  =

>  	calls =3D mgr.GetCalls()
>  =

> @@ -24,10 +26,8 @@ for path, properties in modems:
>  		state =3D properties["State"]
>  		print "[ %s ] %s" % (path, state)
>  =

> -		if state !=3D "incoming":
> -			continue
> -
> -		call =3D dbus.Interface(bus.get_object('org.ofono', path),
> -						'org.ofono.VoiceCall')
> +		if state =3D=3D "incoming":
> +			oface(path, 'org.ofono.VoiceCall').Answer()
> +		elif state =3D=3D "waiting":
> +			mgr.HoldAndAnswer()

Actually I'd prefer a separate script for this.

>  =

> -		call.Answer()

Regards,
-Denis

--===============1948614967519855712==--

