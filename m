Content-Type: multipart/mixed; boundary="===============6959757740250631361=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] stemodem: fix issue with gatchat usage
Date: Mon, 31 Jan 2011 10:50:45 +0100
Message-ID: <1296467445.1520.192.camel@aeonflux>
In-Reply-To: <1296327817-8420-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6959757740250631361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>  drivers/stemodem/radio-settings.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)

so I applied this patch since it actually fixes a clear issue with the
GAtChat usage and the register handling.

However I think triggering the register via AT+CFUN=3D? instead of
g_idle_add would be a good idea. Then you can actually check if the
different radio settings are supported or not.

Regards

Marcel



--===============6959757740250631361==--

