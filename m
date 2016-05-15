Content-Type: multipart/mixed; boundary="===============8310728081700933431=="
MIME-Version: 1.0
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Sun, 15 May 2016 14:09:45 +0200
Message-ID: <57386709.4020505@gmail.com>
In-Reply-To: <573860F7.2040104@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8310728081700933431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Il 15/05/2016 13:43, Georg Chini ha scritto:
> Did you try to run pulseaudio as normal user? You should avoid system =

> mode if possible.
> It still looks like there is something wrong with your dbus access =

> rights, this time the reply
> from pulseaudio is denied.

Someone else suggested to run pulseaudio in system mode on an embedded =

system.

> Maybe you could try and add something like
>
>   <policy user=3D"pulse">
>     <allow send_destination=3D"org.ofono"/>
>   </policy>
>
> to your ofono.conf, but that is just a wild guess. I am not too =

> familiar with dbus.


Before doing the test, I'm quite confused about users and permissions.
If pulseaudio will run as "normal" (do you mean user 'pulse' or the =

actual user?), what about the other daemons? ofono and bluetooth should =

also run as user?



--===============8310728081700933431==--

