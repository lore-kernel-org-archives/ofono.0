Content-Type: multipart/mixed; boundary="===============0091188961445574942=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbim driver: call the release function in case MBIM OPEN
 fails
Date: Thu, 20 Sep 2018 10:48:25 -0500
Message-ID: <f1794d9a-1edc-6c45-7667-5d29144e6186@gmail.com>
In-Reply-To: <1537418862-24984-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0091188961445574942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

An actual description of what is happening would be helpful

On 09/19/2018 11:47 PM, Giacinto Cifelli wrote:
> ---
>   drivers/mbimmodem/mbim.c | 3 +++
>   1 file changed, 3 insertions(+)
> =

> diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
> index 9fcf44b..f4132d0 100644
> --- a/drivers/mbimmodem/mbim.c
> +++ b/drivers/mbimmodem/mbim.c
> @@ -781,6 +781,9 @@ static bool open_read_handler(struct l_io *io, void *=
user_data)
>   	/* Grab OPEN_DONE Status field */
>   	if (l_get_le32(buf) !=3D 0) {
>   		close(fd);
> +		if (device->disconnect_handler)
> +			device->disconnect_handler(device->ready_data);
> +		device->is_ready =3D false;

I don't get this part.  So device->is_ready =3D false assignment is =

pointless.  It is already false.

Also, aren't we going to call device->disconnect_handler anyway by =

virtue of closing the fd?  l_io_set_disconnect_handler which we set in =

mbim_device_new should already be taking care of this.

Regards,
-Denis

--===============0091188961445574942==--

