Content-Type: multipart/mixed; boundary="===============7792695992419597878=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] quectel: replace g_at_chat_set_wakeup_command() with
 g_at_chat_retry()
Date: Tue, 13 Aug 2019 02:16:49 -0500
Message-ID: <00cc88a7-17ec-1c94-db34-9d5ccd5c581b@gmail.com>
In-Reply-To: <20190812203832.19096-2-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7792695992419597878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 8/12/19 3:38 PM, Martin Hundeb=C3=B8ll wrote:
> If the modem isn't powered on, the use of g_at_chat_set_wakeup_command()
> makes ofono send out AT strings in an endless loop. Avoid this by using
> g_at_chat_retry() in a timer instead.
> ---
>   plugins/quectel.c | 64 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 53 insertions(+), 11 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============7792695992419597878==--

