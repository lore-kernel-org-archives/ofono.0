Content-Type: multipart/mixed; boundary="===============4724808242621033852=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 15:05:38 -0600
Message-ID: <4D505EA2.8020202@gmail.com>
In-Reply-To: <AANLkTik060s7RnKg3j-0XVx7P8NnTUg5v0gxFiexEgHx@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4724808242621033852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On 02/07/2011 02:37 PM, andre matos wrote:
> Hi Denis,
> =

> On Mon, Feb 7, 2011 at 8:46 PM, Denis Kenzior <denkenz@gmail.com
> <mailto:denkenz@gmail.com>> wrote:
> =

>     Hi Andre,
> =

>     > @@ -1350,11 +1351,12 @@ static DBusMessage
>     *manager_transfer(DBusConnection *conn,
>     >        * implementing the call transfer operation for a call that is
>     >        * still dialing/alerting.
>     >        */
>     > -     numactive +=3D voicecalls_num_connecting(vc);
>     > +     numconn =3D voicecalls_num_connecting(vc);
>     >
>     >       numheld =3D voicecalls_num_held(vc);
>     >
>     > -     if ((numactive !=3D 1) && (numheld !=3D 1))
> =

>     I don't get it, isn't the above condition taking care of this already?
>     Its been a while but the precondition of ECT is:
> =

>     Held Call
>     Outgoing or an Active call.  You cannot have an Outgoing and an Active
>     call at the same time.  Hence numactive =3D=3D 1 && numheld =3D=3D 1 =
should work
>     just fine.
> =

> =

> What you wrote is correct. transfer works when it supposed to work.
> =

> The changes i did takes care of the negative cases.  =

> This means calling transfer should fail if we have:
> multiparty call active and one held call

if mpty is an active call, then numactive would be > 1 -> fail to invoke ECT

> one active call and one held multiparty call

If mpty is a held call, then numheld would be > 1 -> fail to invoke ECT
> only one active call

If only active then numheld =3D=3D 0 -> fail to invoke ECT
> only one held call

if only held then numactive =3D=3D 0 -> fail to invoke ECT

So what condition are we actually trying to solve?

Regards,
-Denis

--===============4724808242621033852==--

