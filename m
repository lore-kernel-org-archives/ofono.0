Content-Type: multipart/mixed; boundary="===============3769426501900356550=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] gprs: fix error check of gprs_cid_alloc function
Date: Wed, 15 Feb 2017 14:40:09 -0600
Message-ID: <50b28bec-40d8-8a12-80be-f703e29ad517@gmail.com>
In-Reply-To: <20170215165421.30121-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3769426501900356550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 02/15/2017 10:54 AM, Christophe Ronco wrote:
> When there is no context id available, idmap_alloc and
> gprs_cid_alloc return max + 1.
> ---
>  src/gprs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============3769426501900356550==--

