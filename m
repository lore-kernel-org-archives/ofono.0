Content-Type: multipart/mixed; boundary="===============5468428827186676827=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] qmimodem: remember lac and cellid
Date: Fri, 19 Jul 2019 01:20:16 -0500
Message-ID: <a8a410ec-64b2-7816-7ee1-57c44dea38ea@gmail.com>
In-Reply-To: <1563370164-2408-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5468428827186676827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 7/17/19 8:29 AM, Christophe Ronco wrote:
> Lac and cellid information are optional in ss_info notifications.
> Remember them in order to give a correct information each time a
> notification is received.
> ---
>   drivers/qmimodem/network-registration.c | 53 ++++++++++++++++++++++----=
-------
>   1 file changed, 35 insertions(+), 18 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============5468428827186676827==--

