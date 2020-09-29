Content-Type: multipart/mixed; boundary="===============6485284924543459439=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] common: APN with a dot in second position are not invalid
Date: Tue, 29 Sep 2020 09:13:54 -0500
Message-ID: <fa2871d1-6eea-f58e-8668-ea9dd6be3cb4@gmail.com>
In-Reply-To: <1601278689-6876-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6485284924543459439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 9/28/20 2:38 AM, Christophe Ronco wrote:
> APN with a dot in second position (example: "t.est") are wrongly
> considered invalid.
> ---
>   src/common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6485284924543459439==--

