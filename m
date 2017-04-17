Content-Type: multipart/mixed; boundary="===============7277422144054696619=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH qmi lte v3 2/6] qmi: implement detach_shutdown method
Date: Mon, 17 Apr 2017 12:10:23 -0500
Message-ID: <24c82cb0-aeed-149b-77e5-42dcf29dbaf7@gmail.com>
In-Reply-To: <20170415153446.31803-4-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7277422144054696619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/15/2017 10:34 AM, Jonas Bonn wrote:
> The detach_shutdown method is invoked to unconditionally release
> an active context.  For QMI, this is equivalent to a call to
> deactivate_primary.
>
> This patch makes the callback to deactivate_primary optional and
> implements detach_shutdown to simply call it.  When there is no
> callback, the stop_net callback notifies ofono about the context
> release via an asynchronous ofono_gprs_context_deactivated() call.
> ---
>  drivers/qmimodem/gprs-context.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============7277422144054696619==--

