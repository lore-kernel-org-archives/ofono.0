Content-Type: multipart/mixed; boundary="===============8628487160415183764=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] coex: Adding documetation for coex interface
Date: Tue, 27 Nov 2018 10:01:29 +0100
Message-ID: <20181127090129.GB20504@amd>
In-Reply-To: <1543227452-29542-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8628487160415183764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> +LTE Coexistence hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.IntelLTECoex*
> +Object path	[variable prefix]/{modem0,modem1,...}

The interface should be generic, not Intel-specific in the end, right?


> +		a(a{sv}) GetPlmnHistory()
> +			Requests for LTE Plmn history list stored in NVM to
> +			retrieve geo location history like MobileNetworkCode,
> +			MobileCountryCode, LteBandsFDD, LteBandsTDD, ChannelBandwidth.
> +			*most recently uused

"uused" is typo?


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8628487160415183764==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsdjlCK2tBQ2drUU1PZndhcFhiK3ZLMUpBQ2ZhRXhnRmQ0dVY1bjVYZDRlWUdmMGZsWk4K
VTYwQW4xZ3MvTm4wdUVOclVIeXFzMWM4dUtNMDRQM3AKPUtRbzgKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============8628487160415183764==--

