Content-Type: multipart/mixed; boundary="===============4882517307149246417=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ussd: Cancel pending requests when unregistering
Date: Wed, 23 May 2018 10:23:44 -0500
Message-ID: <8b081a19-b46d-fc71-c285-5b8cd05c9d2f@gmail.com>
In-Reply-To: <1527083281-21433-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4882517307149246417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 05/23/2018 08:48 AM, Slava Monich wrote:
> And reset state to idle before unregistering the D-Bus interface.
> This may occur e.g. when we receive REFRESH from STK.
> ---
>   src/ussd.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============4882517307149246417==--

