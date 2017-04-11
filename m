Content-Type: multipart/mixed; boundary="===============3926781496119029817=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/8] qmi: retrieve GPRS context parameters
Date: Tue, 11 Apr 2017 11:44:25 -0500
Message-ID: <304e865c-8031-0d79-7cc1-2b1d949d39ea@gmail.com>
In-Reply-To: <20170411081818.19544-4-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3926781496119029817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/11/2017 03:18 AM, Jonas Bonn wrote:
> The GPRS context needs to be configured with connection parameters when
> the bearer has been established.  This was only partially implemented, so
> this patch adds additional parameters to those passed to the context.
> ---
>  drivers/qmimodem/gprs-context.c | 52 +++++++++++++++++++++++++++++++++++=
++++++
>  drivers/qmimodem/wds.h          |  1 +
>  2 files changed, 53 insertions(+)
>

I went ahead and applied a slightly modified version of this patch that =

fixed various style issues.

Regards,
-Denis

--===============3926781496119029817==--

