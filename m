Content-Type: multipart/mixed; boundary="===============5627623330696804478=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 5/5] cell-info: Documentation
Date: Tue, 28 Dec 2010 09:13:54 -0800
Message-ID: <1293556434.9439.70.camel@aeonflux>
In-Reply-To: <1293542847-24248-6-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5627623330696804478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

>  doc/cell-info.txt |  124 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 124 insertions(+), 0 deletions(-)
>  create mode 100644 doc/cell-info.txt
> =

> diff --git a/doc/cell-info.txt b/doc/cell-info.txt
> new file mode 100644
> index 0000000..b288e69
> --- /dev/null
> +++ b/doc/cell-info.txt
> @@ -0,0 +1,124 @@
> +Cell Info hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.CellInfo
> +Object path	[variable prefix]/{modem0,modem1,...}
> +
> +Methods 	a{sv}aa{sv} GetNeighborCellInfo()
> +
> +			Calling this procedure returns properties of serving
> +			and neighbouring cells in GSM or WCDMA networks. This
> +			information can be used to determine current location
> +			using triangulation over neighbouring cell tower
> +			locations and estimated distances.
> +
> +			The return value consists of two parts: 1) dictionary
> +			of common information about network and serving cell 2)
> +			array of dictionaries containing measurement results
> +			of neighbouring cells. The contents of the dictionaries
> +			follow the specification OMA-TS-ULP-V2_0-20100816-C for
> +			user plane Location and is described in properties
> +			section.
> +
> +		a{sv} GetProperties
> +
> +			Calling this procedure returns properties of serving
> +			cell in GSM or WCDMA networks. Effectively the data
> +			returned is the part 1 of the data returned by
> +			GetNeighborCellInfo.

why do we bother here with two methods calls. What is the use of getting
only half of the information. You are making the same call to the
hardware, so why not return the same information.

The method name org.ofono.CellInfo.GetNeighborCellInfo is also not
really good. I duplicates the CellInfo information. So I would just have
called this GetNeighbors.

What is the reason behind a{sv}aa{sv} here? Wouldn't it be simpler to
just go with aa{sv} and declare that the first dict is always the
current serving cell? Are the information from the current cell really
that different than from the neighbors?

One other think that I don't really like with the GetProperties part is
that we could expect a PropertiesChanged signal. However that is not
really going to happen since the query should only be done on demand. So
I would prefer if we then don't have properties at all in this case.

Regards

Marcel



--===============5627623330696804478==--

