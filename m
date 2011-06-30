Content-Type: multipart/mixed; boundary="===============4596110757854119463=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [HELP] Application Aborts After Making "Dial" Method Call
Date: Thu, 30 Jun 2011 00:35:54 -0500
Message-ID: <4E0C0B3A.8030005@gmail.com>
In-Reply-To: <10D123A956DC4B4FA9D7A48B33358362150DD42424@INDXM3131.dir.svc.accenture.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4596110757854119463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Milan,

On 06/30/2011 01:08 AM, milan.satpathy(a)accenture.com wrote:
> Hi,
> =

>  =

> =

> This issue may not be related directly to any d-bus functionality as
> such. Yet I would like to know,
> =

> If any one faced a similar problem and got any idea how to fix the issue.
> =

>  =

> =

> When I make the =E2=80=9CDial=E2=80=9D call using D-BUS method call, I ge=
t the below
> error sometimes:
> =

>  =

> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DERROR
> LOG=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =

> process 4536: arguments to dbus_message_iter_append_basic() were
> incorrect, assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in
> file dbus-message.c line 2526.
> =

> This is normally a bug in some application using the D-Bus library.
> =

>   D-Bus not built with -rdynamic so unable to print a backtrace
> =


What this means is that you're passing a non-utf8 string to D-Bus.  All
D-Bus strings must be UTF8, or the library will simply abort.  Your code
needs to be fixed...  In the future, please find a more appropriate
forum to ask such questions; they do not belong on the oFono mailing
list... ;)

Regards,
-Denis

--===============4596110757854119463==--

