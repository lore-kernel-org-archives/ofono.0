Content-Type: multipart/mixed; boundary="===============6749722380313916231=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gdbus: Drop message replies if the sender requested no
 reply
Date: Mon, 11 Jan 2016 11:20:14 -0600
Message-ID: <5693E44E.3020702@gmail.com>
In-Reply-To: <1452297478.3610.4.camel@tecnocode.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6749722380313916231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 01/08/2016 05:57 PM, Philip Withnall wrote:
> If the sender flags a D-Bus message as not expecting a reply, it is
> against system bus policy to send a reply =E2=80=94 sending one will resu=
lt in
> errors being sent to us by dbus-daemon.
>
> Magically drop all replies to messages which request no reply.
>
> This is not a complete fix. In an ideal world, the existing check for
> G_DBUS_METHOD_FLAG_NOREPLY would be dropped, as the server should be
> prepared to return a reply to every method, if the client requests and
> expects one =E2=80=94 otherwise the client will time out. However, that=
=E2=80=99s a
> much bigger change with a much bigger risk of breaking things, so I=E2=80=
=99ll
> stick with this for now.
> ---
>   gdbus/object.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Patch is still corrupt.

Applying: gdbus: Drop message replies if the sender requested no reply
fatal: corrupt patch at line 10
Patch failed at 0001 gdbus: Drop message replies if the sender requested =

no reply

Are you using git send-email?

Regards,
-Denis

--===============6749722380313916231==--

