Content-Type: multipart/mixed; boundary="===============5137474004360369181=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] n950: Add new plugin for Nokia N950
Date: Wed, 30 May 2012 00:53:21 -0500
Message-ID: <4FC5B5D1.8040100@gmail.com>
In-Reply-To: <1337018591-6553-2-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5137474004360369181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 05/14/2012 01:03 PM, Aki Niemi wrote:
> ---
>   plugins/n950.c |  563 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 files changed, 563 insertions(+), 0 deletions(-)
>   create mode 100644 plugins/n950.c
>

Running diff plugins/n950.c plugins/n900.c I see no differences to note =

besides:

< 		DBG("Error: %s", g_isi_msg_strerror(msg));
---
 > 		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));

Do we really need a new driver for the n950?

Regards,
-Denis

--===============5137474004360369181==--

