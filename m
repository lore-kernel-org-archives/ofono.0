Content-Type: multipart/mixed; boundary="===============0360072402817500931=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/12] qmi: remove headroom parameter from req_alloc
Date: Thu, 29 Mar 2018 09:55:03 -0500
Message-ID: <08424bae-bcab-a60a-dc03-0e26121e1057@gmail.com>
In-Reply-To: <20180329135801.5981-3-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0360072402817500931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/29/2018 08:57 AM, Jonas Bonn wrote:
> The headroom can be established from the service type, so it's redundant
> to pass it as a parameter.
> ---
>   drivers/qmimodem/qmi.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============0360072402817500931==--

