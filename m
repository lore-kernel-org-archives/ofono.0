Content-Type: multipart/mixed; boundary="===============6323906575690846565=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] Allow use of from_io constructor
Date: Mon, 10 May 2010 16:26:33 -0500
Message-ID: <201005101626.33880.denkenz@gmail.com>
In-Reply-To: <1273516783-5132-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6323906575690846565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> Create a way to get the GAtIO object from GAtChat.  Use it to call
> g_at_ppp_new_from_io so that g_at_chat_suspend will work properly.
> =

> Kristen Carlson Accardi (3):
>   gsmdial: use g_at_chat_suspend
>   gatchat: implement g_at_chat_get_io()
>   gsmdial: use g_at_ppp_new_from_io()
> =

>  gatchat/gatchat.c |    8 ++++++++
>  gatchat/gatchat.h |    2 ++
>  gatchat/gsmdial.c |   14 +++++++-------
>  3 files changed, 17 insertions(+), 7 deletions(-)
> =


All three have been applied, thanks.

Regards,
-Denis

--===============6323906575690846565==--

