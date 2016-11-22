Content-Type: multipart/mixed; boundary="===============0390047225509763760=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: lte: set attached after successful activation
Date: Tue, 22 Nov 2016 10:51:39 -0600
Message-ID: <5834779B.5040107@gmail.com>
In-Reply-To: <1479833289-28141-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0390047225509763760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 11/22/2016 10:48 AM, Dragos Tatulea wrote:
> Otherwise the attached state gets to be set before the actual LTE
> automatic context is ready. This triggers a race between connman
> and ofono: connman sees status attached before the context is active
> so connman will try to activate another context with same apn and will
> fail over and over again.
> ---
>   src/gprs.c | 50 +++++++++++++++++++++++++++-----------------------
>   1 file changed, 27 insertions(+), 23 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============0390047225509763760==--

