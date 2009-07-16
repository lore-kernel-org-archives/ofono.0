Content-Type: multipart/mixed; boundary="===============0827708796242945021=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems with voice call.
Date: Thu, 16 Jul 2009 10:08:31 -0500
Message-ID: <200907161008.31736.denkenz@gmail.com>
In-Reply-To: <4A5EBC7B.6060203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0827708796242945021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> Hi Denis,
>
> With Option iCON 225 the SMS service started to work and I was also able
> to send SMS message with the following command:
>
> $ dbus-send --system --print-reply --dest=3Dorg.ofono /modem1
> org.ofono.SmsManager.SendMessage array:string:"+358000000000"
> string:"ofono test message"

Excellent.

> The Nokia E51 returns still the SMS error thing. To AT+CPMS=3D? the E51
> returns the following:
> +CPMS: (),(),()
>
> OK

Are you running this over bluetooth?  Perhaps this has a really cut down at =

command set in bluetooth serial profile.  The other possibility is that you =

need to send some initialization commands first, (maybe AT+CFUN=3D1 would d=
o it?)

Regards,
-Denis

--===============0827708796242945021==--

