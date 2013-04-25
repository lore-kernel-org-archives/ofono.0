Content-Type: multipart/mixed; boundary="===============8565163260845411680=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] include: Add ofono_emulator_create_card()
Date: Thu, 25 Apr 2013 03:35:44 -0500
Message-ID: <5178EAE0.8060208@gmail.com>
In-Reply-To: <1366823631-26262-2-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8565163260845411680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paulo,

On 04/24/2013 12:13 PM, Paulo Borges wrote:
> ---
>   include/emulator.h |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/emulator.h b/include/emulator.h
> index 5cd894b..49168a1 100644
> --- a/include/emulator.h
> +++ b/include/emulator.h
> @@ -74,6 +74,8 @@ void ofono_emulator_register(struct ofono_emulator *em,=
 int fd);
>
>   void ofono_emulator_remove(struct ofono_emulator *em);
>
> +int ofono_emulator_create_card(struct ofono_emulator *em, int fd, int ve=
rsion);
> +

Why do you need the fd argument?  It can be obtained from the =

g_at_server object.  e.g.
GIOChannel *channel =3D g_at_server_get_channel(server);
fd =3D g_io_channel_get_unix_fd(channel);

Also, what is the purpose of the version parameter?

>   void ofono_emulator_send_final(struct ofono_emulator *em,
>   				const struct ofono_error *final);
>   void ofono_emulator_send_unsolicited(struct ofono_emulator *em,

Regards,
-Denis

--===============8565163260845411680==--

