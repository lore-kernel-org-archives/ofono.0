Content-Type: multipart/mixed; boundary="===============8654555697114293525=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] xmm7modem: fix to activate context with cid zero
Date: Fri, 14 Jun 2019 11:44:01 -0500
Message-ID: <ecdba5e5-ac5d-9e9b-53df-50dc4610270d@gmail.com>
In-Reply-To: <1560504396-8891-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8654555697114293525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 06/14/2019 04:26 AM, Antara Borwankar wrote:
> xmm7modem returns 0 as cid for default pdp context. Thus
> initializing last_auto_context_id to -1 to indicate a deactivated
> context.
> ---
>   drivers/atmodem/gprs.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> =


Applied with a tweaked commit description.

Regards,
-Denis


--===============8654555697114293525==--

