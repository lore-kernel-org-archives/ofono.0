Content-Type: multipart/mixed; boundary="===============2502191221981960719=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 05/11] test-server: Fix GIOChannel leak in create_tty
Date: Fri, 18 Jun 2010 12:50:23 -0500
Message-ID: <201006181250.23863.denkenz@gmail.com>
In-Reply-To: <1276321850-13307-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2502191221981960719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Remove client_io and unref server_io after creating GAtServer.
> ---
>  gatchat/test-server.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> =


This patch has been applied, thanks.

Regards,
-Denis

--===============2502191221981960719==--

