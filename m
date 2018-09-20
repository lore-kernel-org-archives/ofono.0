Content-Type: multipart/mixed; boundary="===============2413542636097779225=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] src/main.c: removed call to g_thread_init
Date: Thu, 20 Sep 2018 10:41:09 -0500
Message-ID: <aaa82f20-3ac4-718e-db0e-97170ea80ce7@gmail.com>
In-Reply-To: <1537418381-18473-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2413542636097779225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 09/19/2018 11:39 PM, Giacinto Cifelli wrote:
> according to g_thread documentation, this call is no longer needed,
> and starting from g_thread version 2.32 it must not be used
> ---
>   src/main.c | 5 -----
>   1 file changed, 5 deletions(-)
> =


Both applied after tweaking the commit messages.

Regards,
-Denis


--===============2413542636097779225==--

