Content-Type: multipart/mixed; boundary="===============3232358950654783020=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] AT modem: fix COLR reporting
Date: Thu, 13 Jan 2011 10:33:38 -0600
Message-ID: <4D2F2962.2010006@gmail.com>
In-Reply-To: <1294928281-11905-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3232358950654783020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/13/2011 08:18 AM, R=C3=A9mi Denis-Courmont wrote:
> AT+COLR does not have a local override; it cannot be factored with the
> other commands.
> =

> This partially reverts commit f2baa88d7577649358f1f8587e5a9b6aa730ca41.
> ---
>  drivers/atmodem/call-settings.c |   29 ++++++++++++++++++++++++++++-
>  1 files changed, 28 insertions(+), 1 deletions(-)
> =


Patch has been applied, thanks.  I did reword the commit message slightly.

Regards,
-Denis

--===============3232358950654783020==--

