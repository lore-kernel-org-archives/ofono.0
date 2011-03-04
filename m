Content-Type: multipart/mixed; boundary="===============3908909692259951917=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbmmodem: don't let chat open after fd is sent
Date: Thu, 03 Mar 2011 21:57:52 -0600
Message-ID: <4D706340.1080603@gmail.com>
In-Reply-To: <1299191007-8081-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3908909692259951917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 03/03/2011 04:23 PM, Lucas De Marchi wrote:
> Instead of using a GAtChat, just use a GIOChannel and close it as soon
> as its fd is sent to core.
> ---
>  drivers/mbmmodem/location-reporting.c |   32 +++++++++++++++------------=
-----
>  1 files changed, 15 insertions(+), 17 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============3908909692259951917==--

