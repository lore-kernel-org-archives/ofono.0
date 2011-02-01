Content-Type: multipart/mixed; boundary="===============0495706105462684222=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 3/4] nettime: Documentation
Date: Tue, 01 Feb 2011 16:54:50 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802DA147E@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1296571771-26513-4-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0495706105462684222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

ofono-bounces(a)ofono.org wrote:
> ---
>  doc/network-time-api.txt |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)  create
> mode 100644 doc/network-time-api.txt
> =

> diff --git a/doc/network-time-api.txt
> b/doc/network-time-api.txt new file mode 100644 index
> 0000000..9133a73 --- /dev/null +++ b/doc/network-time-api.txt
> @@ -0,0 +1,36 @@
> +Network time hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Interface	com.meego.NetworkTime
> +Object path	[variable]
> +
> +Methods		void Notify(dict info)
> +
> +			Notifies the service of current time and date
> +			as notified by the cellular network.  The info
> +			argument contains a dictionary with the
> +			following possible keys:
> +
> +			int64 UTC [optional]
> +				Network time in seconds from epoch
> +				normalized to device boot time.
> +				Reveicing entity obtains current real
> +				time by adding the value from monotonic
> +				clock e.g.
> +				clock_gettime(CLOCK_MONOTONIC,...).
> +
> +			int32 Timezone [optional]
> +				Current timezone offset in seconds from
> +				UTC.
> +
> +			int32 DST [optional]
> +				Current daylight saving setting in
> +				hours.

few hours back I delivered a patch for converting the DST from hours to
seconds in ofono driver code.
are we going to take that into consideration?

Aki??

Regards,
Jeevaka

--===============0495706105462684222==--

