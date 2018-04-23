Content-Type: multipart/mixed; boundary="===============3880805651903092899=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ussd: Don't ignore data from TERMINATED response
Date: Mon, 23 Apr 2018 13:49:56 -0500
Message-ID: <e8036401-cb9e-70f2-d7fe-2392a388aaf9@gmail.com>
In-Reply-To: <1524497588-12079-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3880805651903092899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 04/23/2018 10:33 AM, Slava Monich wrote:
> Typically responses to USSD requests are coming with status
> zero (NOTIFY) but some are coming with status 2 (TERMINATED).
> If those contain data, the data should be presented to the user.
> ---
>   src/ussd.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============3880805651903092899==--

