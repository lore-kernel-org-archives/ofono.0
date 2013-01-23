Content-Type: multipart/mixed; boundary="===============2760176936630844033=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AW: [PATCH 05/10] hfp_hf_bluez5: Handle NewConnection from BlueZ
Date: Wed, 23 Jan 2013 08:49:58 -0600
Message-ID: <50FFF896.4080800@gmail.com>
In-Reply-To: <sig.9735c4f085.B3F251FD87EC894A88C2221EEEBDF54807096F7F55@Exchange>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2760176936630844033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

<snip>

> I assume returning NULL is ok here if nothing went wrong?
> I'm not familiar with plain dbus API, just using glib gdbus, there I woul=
d expect to create an answer to the call.

The NewConnection method is marked as 'ASYNC' in the method table (see =

profile_methods).  In our gdbus library, returning NULL here means that =

the method return is deferred until a later time.  E.g. when we try to =

establish a SLC connection and fail / succeed.

In this patch it is left kind of hanging out there and you would need to =

peek at patch 10 to really know what happens to it.  Confusing, I know ;)

Regards,
-Denis

--===============2760176936630844033==--

