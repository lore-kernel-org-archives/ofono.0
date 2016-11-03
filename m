Content-Type: multipart/mixed; boundary="===============7943952506101072732=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Check GPRS_FLAG_ATTACHED_UPDATE in
 pri_deactivate_callback
Date: Thu, 03 Nov 2016 14:25:25 -0500
Message-ID: <581B8F25.40804@gmail.com>
In-Reply-To: <1478200322-5886-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7943952506101072732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 11/03/2016 02:12 PM, Slava Monich wrote:
> This prevents attached state from getting stuck at 0 like this:
>
> 1. Context deactivation is initiated over D-Bus, ctx->pending is set
> 2. Attached becomes FALSE, context is still marked as active
> 3. Attached becomes TRUE, gprs_attached_update sets GPRS_FLAG_ATTACHED_UP=
DATE
> 4. Deactivation completes, attached is 0, driver_attached is 1
>
> Futher network status updates don't call gprs_attached_update because
> driver_attached is still 1, so attached is staying 0 until we lose the
> data registration again which may not happen for quite a long time.
> ---
>   src/gprs.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============7943952506101072732==--

