Content-Type: multipart/mixed; boundary="===============7912441934421082297=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 13:46:46 -0600
Message-ID: <4D504C26.4030504@gmail.com>
In-Reply-To: <1297079813-26573-1-git-send-email-andre.matos.ste@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7912441934421082297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andre,

> @@ -1350,11 +1351,12 @@ static DBusMessage *manager_transfer(DBusConnecti=
on *conn,
>  	 * implementing the call transfer operation for a call that is
>  	 * still dialing/alerting.
>  	 */
> -	numactive +=3D voicecalls_num_connecting(vc);
> +	numconn =3D voicecalls_num_connecting(vc);
>  =

>  	numheld =3D voicecalls_num_held(vc);
>  =

> -	if ((numactive !=3D 1) && (numheld !=3D 1))

I don't get it, isn't the above condition taking care of this already?
Its been a while but the precondition of ECT is:

Held Call
Outgoing or an Active call.  You cannot have an Outgoing and an Active
call at the same time.  Hence numactive =3D=3D 1 && numheld =3D=3D 1 should=
 work
just fine.

> +	if ((numactive > 1 || numheld > 1) ||
> +		((numheld + numactive + numconn) !=3D 2))
>  		return __ofono_error_failed(msg);
>  =

>  	if (vc->driver->transfer =3D=3D NULL)

Regards,
-Denis

--===============7912441934421082297==--

