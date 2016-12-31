Content-Type: multipart/mixed; boundary="===============8671728356417079092=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] MC7430: fix get signal strength
Date: Fri, 30 Dec 2016 18:36:42 -0600
Message-ID: <2370c48e-b84c-088a-35d5-ef86be301f23@gmail.com>
In-Reply-To: <20161228150402.15660-4-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8671728356417079092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 12/28/2016 09:04 AM, Christophe Ronco wrote:
> drivers/qmimodem/nas.h
>  Get current signal strength (type: 0x01), not list of other signals stre=
ngth (0x10)
>  Without this fix:
>   - I can't get a signal strength on MC7430 because list does not exist (=
only one signal strength).
>   - On MC7304, result is wrong
> ---
>  drivers/qmimodem/nas.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Been a while since I looked at QMI, but this looks correct to me. =

Applied, thanks!

Regards,
-Denis


--===============8671728356417079092==--

