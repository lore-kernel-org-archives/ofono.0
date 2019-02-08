Content-Type: multipart/mixed; boundary="===============4633177882900014209=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: Notify when SIM is initialized
Date: Fri, 08 Feb 2019 14:02:43 -0600
Message-ID: <9fcc9e4c-b427-f760-5046-dbecd0873c34@gmail.com>
In-Reply-To: <20190125131436.982-1-nicolas.serafini@sensefly.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4633177882900014209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 01/25/2019 07:15 AM, Nicolas Serafini wrote:
> Since the commit that introduced the notification API of a SIM inserted
> and initialized I can not unlock the SIM card on a WP7607 modem.
> =

> The previously mentioned commit: 54d56d763e40bc44c99a9b24aa0477bd373ea085
> =

> Signed-off-by: Nicolas Serafini <nicolas.serafini@sensefly.com>

No Signed-off-by please.  We do not use these.

> ---
>   drivers/qmimodem/sim-legacy.c | 1 +
>   drivers/qmimodem/sim.c        | 1 +
>   2 files changed, 2 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============4633177882900014209==--

