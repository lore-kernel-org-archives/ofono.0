Content-Type: multipart/mixed; boundary="===============8077668163345312577=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] qmimodem: set APN for LTE default bearer
Date: Thu, 04 May 2017 11:00:58 -0500
Message-ID: <9d773152-3ec7-852d-2e4d-5e26b2b5f850@gmail.com>
In-Reply-To: <20170504132430.28813-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8077668163345312577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 05/04/2017 08:24 AM, Jonas Bonn wrote:
> Apparently, an empty APN in an ofono context means that that the context
> cannot be activated.  connman definitely interprets it this way.
>
> This patch sets a default name of "automatic" for the default bearer if
> no other LTE APN is supplied (which is currently the case as the LTE
> atom is not in place yet).  Without this, connman happily ignores the
> context, even though it has been activated by ofono.
> ---
>  drivers/qmimodem/gprs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Regards,
-Denis


--===============8077668163345312577==--

