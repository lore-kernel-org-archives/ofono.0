Content-Type: multipart/mixed; boundary="===============2426735082071714030=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] network.c: notify_status_watches: check for NULL
Date: Mon, 11 Sep 2017 10:39:34 -0500
Message-ID: <4644de46-efed-8260-11b7-9509b9a970e2@gmail.com>
In-Reply-To: <20170911002543.31030-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2426735082071714030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 09/10/2017 07:25 PM, Alexander Couzens wrote:
> In rare cases when ofono_netreg_status_notify() is called before
> ofono_netreg_register() netreg->status_watches is NULL.
> ---
>   src/network.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============2426735082071714030==--

