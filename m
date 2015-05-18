Content-Type: multipart/mixed; boundary="===============2739408754093762280=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] gprs: Add DBus method to reset contexts
Date: Mon, 18 May 2015 09:09:22 -0500
Message-ID: <5559F292.4000604@gmail.com>
In-Reply-To: <CACM4vuDtBm0T9fwftYino6RYz=+MAXEQSQJqg+JYnaNpoi5y=g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2739408754093762280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/18/2015 01:53 AM, Alfonso Sanchez-Beato wrote:
> Hi Denis,
>

<snip>

>         +
>         +       for (l =3D gprs->contexts; l; l =3D l->next) {
>         +               struct pri_context *ctx =3D l->data;
>         +
>         +               if (ctx->pending)
>         +                       return __ofono_error_busy(msg);
>         +       }
>         +
>         +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
>         +               return __ofono_error_invalid_args(msg);
>         +
>         +       if (gprs->powered)
>         +               return __ofono_error_not_allowed(msg);
>         +
>         +       for (l =3D gprs->contexts; l; l =3D l->next) {
>         +               struct pri_context *ctx =3D l->data;
>         +
>         +               if (ctx->active)
>         +                       return __ofono_error_not_allowed(msg);
>
>
>     Is there a particular reason you're running through the list of
>     contexts again here?  Why not check for ctx->active at the same time
>     as ctx->pending?
>
>
> I wanted to make sure that __ofono_error_busy was returned before
> __ofono_error_not_allowed if one context was busy and another one was
> active, for instance. Not that I feel is really important and I can
> change this if the other way is preferred.
>

Makes sense.  However, since this is not obvious, we probably should add =

a comment as to why this is being done.  Want to submit a patch or do =

you want me to do this?

Regards,
-Denis

--===============2739408754093762280==--

