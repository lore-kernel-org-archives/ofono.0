Content-Type: multipart/mixed; boundary="===============5561988279432167826=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] cbs: Resolve a use-after-free that could occur with rapid
 location changes.
Date: Mon, 21 Dec 2015 17:55:48 -0600
Message-ID: <56789184.8060705@gmail.com>
In-Reply-To: <1450692250-29422-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5561988279432167826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

On 12/21/2015 04:03 AM, John Ernberg wrote:
> From: John Ernberg <john.ernberg@actia.se>
>
> What happens is that the timeout leaks and then the cbs struct with
> the callback is cleaned up, resulting in a SIGSEGV when the callback
> occurs from the glib loop.
> ---
>   src/cbs.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============5561988279432167826==--

