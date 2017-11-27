Content-Type: multipart/mixed; boundary="===============0285120244017276859=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim-auth: Avoid using dbus_message_iter_get_element_count
Date: Mon, 27 Nov 2017 10:08:43 -0600
Message-ID: <da63b6a9-3f66-369f-ea35-9dc1ff276a50@gmail.com>
In-Reply-To: <1511780804-4383-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0285120244017276859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 11/27/2017 05:06 AM, Slava Monich wrote:
> It's the only thing in ofono that requires dbus 1.9.16 or later and it's
> not worth it.
> =

> And don't leak DBusMessage on format error.
> ---
>   src/sim-auth.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============0285120244017276859==--

