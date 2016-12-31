Content-Type: multipart/mixed; boundary="===============2347448049102957917=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] MC7430: fix QMI notification messages handling
Date: Fri, 30 Dec 2016 18:39:46 -0600
Message-ID: <e8046724-99a8-d683-da02-856a04a970ea@gmail.com>
In-Reply-To: <20161228150402.15660-5-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2347448049102957917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 12/28/2016 09:04 AM, Christophe Ronco wrote:
> QMI notification messages handlers are never called on MC7430 without thi=
s fix.
>
> drivers/qmimodem/qmi.c
>  Do not test transaction id before calling notification handler.
>  On MC7430, notification messages contain a not null transaction id
>  (starts with 1, increased at each message for a particular client).
>  On MC7304 transaction id in notification messages is always 0.
> ---
>  drivers/qmimodem/qmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied, thanks!

Regards,
-Denis


--===============2347448049102957917==--

