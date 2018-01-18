Content-Type: multipart/mixed; boundary="===============5263036214788974393=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] dbus: Use dbus_validate_path
Date: Thu, 18 Jan 2018 10:54:16 -0600
Message-ID: <97f4f450-8d03-ea44-0656-0e3854739c85@gmail.com>
In-Reply-To: <1516294077-16319-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5263036214788974393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 01/18/2018 10:47 AM, Slava Monich wrote:
> Instead of __ofono_dbus_valid_object_path
> ---
>   plugins/push-notification.c |  2 +-
>   plugins/smart-messaging.c   |  2 +-
>   src/dbus.c                  | 44 --------------------------------------=
------
>   src/gnss.c                  |  2 +-
>   src/modem.c                 |  2 +-
>   src/netmon.c                |  2 +-
>   src/ofono.h                 |  2 --
>   src/stk.c                   |  4 ++--
>   8 files changed, 7 insertions(+), 53 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============5263036214788974393==--

