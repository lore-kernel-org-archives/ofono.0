Content-Type: multipart/mixed; boundary="===============7362942093602889072=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] audio-settings: Fix unneeded async for GetProperties
Date: Mon, 25 Feb 2013 12:21:49 -0600
Message-ID: <512BABBD.3040909@gmail.com>
In-Reply-To: <1361800119-10775-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7362942093602889072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 02/25/2013 07:48 AM, Claudio Takahasi wrote:
> GetProperties method call for Audio settings returns the reply in the
> same iteraction, it doesn't need to be asynchronous.
> ---
>   src/audio-settings.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============7362942093602889072==--

