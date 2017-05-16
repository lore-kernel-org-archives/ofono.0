Content-Type: multipart/mixed; boundary="===============7004296854062649525=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v2 3/3] doc: gemalto: add documentation about interface
 cinterion.HardwareMonitor.
Date: Tue, 16 May 2017 13:25:10 -0500
Message-ID: <eb33ed6f-11ec-1c4f-9680-b20d9306aeb2@gmail.com>
In-Reply-To: <1494923922-8874-3-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7004296854062649525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 05/16/2017 03:38 AM, Vincent Cesson wrote:
> This interface exposes a single method to access temperature and supply
> voltage of the modem.
> ---
>  doc/cinterion-hardware-monitor-api.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 doc/cinterion-hardware-monitor-api.txt
>

I reworded the commit slightly..

> diff --git a/doc/cinterion-hardware-monitor-api.txt b/doc/cinterion-hardw=
are-monitor-api.txt
> new file mode 100644
> index 0000000..50adca3
> --- /dev/null
> +++ b/doc/cinterion-hardware-monitor-api.txt
> @@ -0,0 +1,17 @@
> +
> +HardwareMonitor hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +Service		org.ofono.cinterion

You're still running inside the org.ofono service.  Only the interface =

has a different prefix.  So I fixed this as well and applied the patch.

Regards,
-Denis

--===============7004296854062649525==--

