Content-Type: multipart/mixed; boundary="===============2027605746010667543=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: AW: [PATCH 05/10] hfp_hf_bluez5: Handle NewConnection from BlueZ
Date: Wed, 23 Jan 2013 13:39:52 -0300
Message-ID: <20130123163951.GC6545@samus>
In-Reply-To: <50FFF896.4080800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2027605746010667543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 08:49 Wed 23 Jan, Denis Kenzior wrote:
> Hi Andreas,
> =

> <snip>
> =

> >I assume returning NULL is ok here if nothing went wrong?
> >I'm not familiar with plain dbus API, just using glib gdbus, there I wou=
ld expect to create an answer to the call.
> =

> The NewConnection method is marked as 'ASYNC' in the method table
> (see profile_methods).  In our gdbus library, returning NULL here
> means that the method return is deferred until a later time.  E.g.
> when we try to establish a SLC connection and fail / succeed.
> =

> In this patch it is left kind of hanging out there and you would
> need to peek at patch 10 to really know what happens to it.
> Confusing, I know ;)

Do you think it is worth adding a comment in the code, that would be later
removed?

> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


Cheers,
-- =

Vinicius

--===============2027605746010667543==--

