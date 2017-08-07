Content-Type: multipart/mixed; boundary="===============2482788113378746864=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ussd: Switch the state from USER_ACTION to IDLE
Date: Mon, 07 Aug 2017 14:51:22 -0500
Message-ID: <c3264968-c5c4-a863-bfce-e96f6778048e@gmail.com>
In-Reply-To: <1498046088-545-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2482788113378746864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 06/21/2017 06:54 AM, Slava Monich wrote:
> ... when a USSD notification is received. Some networks
> send 0 (no further user action required) after the response
> timeout expires. That should result in the user input form
> getting removed from the ME screen.
> ---
>  src/ussd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============2482788113378746864==--

