Content-Type: multipart/mixed; boundary="===============0479293543778168992=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gdbus: Drop message replies if the sender requested no
 reply
Date: Mon, 04 Jan 2016 23:36:41 -0600
Message-ID: <568B5669.3000505@gmail.com>
In-Reply-To: <1449071047.4523.18.camel@tecnocode.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0479293543778168992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 12/02/2015 09:44 AM, Philip Withnall wrote:
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
> much
> bigger change with a much bigger risk of breaking things, so I=E2=80=99ll=
 stick
> with this for now.
>
> Signed-off-by: Philip Withnall <philip.withnall@collabora.co.uk>
> Reviewed-by: Simon McVittie <simon.mcvittie@collabora.co.uk>

No Signed-off-by or Reviewed-by lines please.

> ---
>   gdbus/object.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>

Doesn't apply:

Applying: gdbus: Drop message replies if the sender requested no reply
fatal: corrupt patch at line 10
Patch failed at 0001 gdbus: Drop message replies if the sender requested =

no reply
The copy of the patch that failed is found in:

Regards,
-Denis

--===============0479293543778168992==--

