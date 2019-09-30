Content-Type: multipart/mixed; boundary="===============6397330294499118749=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] udev: Adding PCIe as a subsystem in udev
Date: Mon, 30 Sep 2019 11:29:29 -0500
Message-ID: <621b5480-fb84-1b3c-a560-691c3da1b46e@gmail.com>
In-Reply-To: <1569563480-16711-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6397330294499118749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 9/27/19 12:51 AM, Antara Borwankar wrote:
> Adding support for enumerating PCIe types of modems in ofono
> ---
>   plugins/udevng.c | 178 +++++++++++++++++++++++++++++++++++++++++-------=
-------
>   1 file changed, 135 insertions(+), 43 deletions(-)
> =


<snip>

>   =

> +static struct {

I made this static const struct {

> +	const char *driver;
> +	const char *drv;
> +	const char *vid;
> +	const char *pid;
> +} pci_driver_list[] =3D {
> +	{ "xmm7xxx",	"imc_ipc",	"0x8086",	"0x7560"},
> +	{ }
> +};
> +

applied, thanks.

Regards,
-Denis

--===============6397330294499118749==--

