Content-Type: multipart/mixed; boundary="===============2236579364624765568=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to get network interface working
Date: Wed, 08 Oct 2014 10:18:17 -0500
Message-ID: <543555B9.5030808@gmail.com>
In-Reply-To: <CAH4ZQwsFW5nvNVi01MWZErz+EaJjvhGVej_ZNDQaUuL6kS=6_Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2236579364624765568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 10/08/2014 09:50 AM, Enrico Sau wrote:
>     oFono understands escape sequences, so #1 is sufficient.  On most
>     hardware we can send AT&C0 to disable #2, but some hardware still
>     ignores that.
>
> =E2=80=8B
> Thank you so much,
> I solved the problem changing the port from "chat" to "modem" for the
> AT&C0 command in the he910 plugin.
> It may be a fix for ofono.
>

Feel free to send a patch if you think that the port detection logic is =

incorrect.

Regards,
-Denis


--===============2236579364624765568==--

