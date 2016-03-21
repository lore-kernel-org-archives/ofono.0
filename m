Content-Type: multipart/mixed; boundary="===============8763069853853599504=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: assume attached state when registered on LTE
Date: Mon, 21 Mar 2016 11:00:05 -0500
Message-ID: <56F01A85.7010002@gmail.com>
In-Reply-To: <1458575731-30914-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8763069853853599504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/21/2016 10:55 AM, Dragos Tatulea wrote:
> LTE doesn't really use the concept of an attached state. However,
> the oFono API needs it. ConnMan needs it as well.
> ---
>   src/gprs.c | 36 ++++++++++++++++++++++++++----------
>   1 file changed, 26 insertions(+), 10 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============8763069853853599504==--

