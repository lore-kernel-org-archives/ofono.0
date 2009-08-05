Content-Type: multipart/mixed; boundary="===============3285731154468183898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Wed, 05 Aug 2009 12:47:46 -0500
Message-ID: <200908051247.46922.denkenz@gmail.com>
In-Reply-To: <fb249edb0908050718h4088267ep5260658fccfa76c2@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3285731154468183898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> It is kind of working but one of the things "simplified away" is using
> the D-Bus interface even without working EF-MBDN or EF-MWIS files on
> the SIM, i.e. if the write fails then the user never finds out there
> was a notification.

Sorry I don't quite follow.  The mw_set_indicator function sets the value a=
nd =

emits the signals regardless of whether the MWIS file could be written.  Ca=
n =

you explain some more?

For setting mailbox numbers, a working EF-MBDN is required since the only =

alternative would be to store them on the filesystem.

>
> Consistently with the change to return invalid_args on D-Bus type
> mismatch, I'm attaching a diff to do the same thing for other
> interfaces we have.

Patch has been applied.

>
> You might want to add G_DBUS_METHOD_FLAG_ASYNC to SetProperty
> signature and remove mw_update declaration which is now unused.  Also
> the check in cache_info should probably be if (r < len).

Yep, yep and yep.  Thanks.

Regards,
-Denis

--===============3285731154468183898==--

